// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTViewConstraint.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/24
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "RTViewConstraint.h"
#import "RTLayoutConstraint.h"
#import "UIView+Layout.h"
#import <objc/runtime.h>

@interface UIView (RTConstraint)

@property (nonatomic, strong, readonly) NSMutableSet *installedConstraintBuffer;

@end

@implementation UIView (RTConstraint)

static char kInstalledConstraintBufferKey;

- (NSMutableSet *)installedConstraintBuffer {
    NSMutableSet *constraints = objc_getAssociatedObject(self, &kInstalledConstraintBufferKey);
    if (!constraints) {
        constraints = [NSMutableSet set];
        objc_setAssociatedObject(self, &kInstalledConstraintBufferKey, constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return constraints;
}

@end

@interface RTViewConstraint ()

@property (nonatomic, strong) RTViewAttribute *secondViewAttribute;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) UILayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, strong) RTLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, strong) UIView *installedView;


@end

@implementation RTViewConstraint

- (instancetype)initWithFirstViewAttribute:(RTViewAttribute *)firstViewAttribute {
    if (self = [super init]) {
        _firstViewAttribute = firstViewAttribute;
        self.layoutMultiplier = 1.f;
        self.layoutPriority = UILayoutPriorityRequired;
    }
    return self;
}

- (RTConstraint *(^)(id, NSLayoutRelation))equalToWithRelation {
    return ^(id attr, NSLayoutRelation relation) {
        self.secondViewAttribute = attr;
        self.layoutRelation = relation;
        return self;
    };
}

- (RTConstraint *(^)(UILayoutPriority))priority {
    return ^(UILayoutPriority priority) {
        self.layoutPriority = priority;
        return self;
    };
}

- (void)setSecondViewAttribute:(id)secondViewAttribute {
    if ([secondViewAttribute isKindOfClass:[NSValue class]]) {
        [self adaptValueType:secondViewAttribute];
    } else if ([secondViewAttribute isKindOfClass:[UIView class]]) {
        _secondViewAttribute = [[RTViewAttribute alloc] initWithView:secondViewAttribute layoutAttribute:self.firstViewAttribute.layoutAttribute];
    } else if ([secondViewAttribute isKindOfClass:[RTViewAttribute class]]) {
        _secondViewAttribute = secondViewAttribute;
    } else {
        NSLog(@"error: attribute is nil");
    }
}

- (void)adaptValueType:(NSValue *)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        [self setSize:size];
    }
}

- (RTConstraint *(^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        self.layoutMultiplier = multiplier;
        return self;
    };
}

- (void)setOffset:(CGFloat)offset {
    self.layoutConstant = offset;
}

- (void)setLayoutConstant:(CGFloat)layoutConstant {
    _layoutConstant = layoutConstant;
    self.layoutConstraint.constant = layoutConstant;
}

- (void)setInsets:(UIEdgeInsets)insets {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeTop:
            self.layoutConstant = insets.top;
            break;
        case NSLayoutAttributeLeft:
            self.layoutConstant = insets.left;
            break;
        case NSLayoutAttributeRight:
            self.layoutConstant = insets.right;
            break;
        case NSLayoutAttributeBottom:
            self.layoutConstant = insets.bottom;
            break;
        default:
            break;
    }
}

- (void)setSize:(CGSize)size {
    NSLayoutAttribute layoutAttribute = self.firstViewAttribute.layoutAttribute;
    switch (layoutAttribute) {
        case NSLayoutAttributeWidth:
            self.layoutConstant = size.width;
            break;
        case NSLayoutAttributeHeight:
            self.layoutConstant = size.height;
            break;
        default:
            break;
    }
}

- (void)install {

    if (self.layoutConstraint) {
        self.layoutConstraint.active = YES;
        [self.firstViewAttribute.view.installedConstraintBuffer addObject:self];
        return;
    }
    
    UIView *firstLayoutItem = self.firstViewAttribute.item;
    NSLayoutAttribute firstLayoutAttr = self.firstViewAttribute.layoutAttribute;
    UIView *secondLayoutItem = self.secondViewAttribute.item;
    NSLayoutAttribute secondLayoutAttr = self.secondViewAttribute.layoutAttribute;
    
    if (!self.firstViewAttribute.isSizeAttribute && !self.secondViewAttribute) {
        secondLayoutItem = self.firstViewAttribute.view.superview;
        secondLayoutAttr = firstLayoutAttr;
    }
    
    RTLayoutConstraint *layoutConstraint = [RTLayoutConstraint constraintWithItem:firstLayoutItem
                                                                        attribute:firstLayoutAttr
                                                                        relatedBy:self.layoutRelation
                                                                           toItem:secondLayoutItem
                                                                        attribute:secondLayoutAttr
                                                                       multiplier:self.layoutMultiplier
                                                                         constant:self.layoutConstant];
    
    layoutConstraint.priority = self.layoutPriority;
    if (self.secondViewAttribute.view) {
        //找到first..与second..共同的Superview
        self.installedView = [self.firstViewAttribute.view filterCommonSuperView:self.secondViewAttribute.view];
    } else if (self.firstViewAttribute.isSizeAttribute) {
        self.installedView = self.firstViewAttribute.view;
    } else {
        self.installedView = self.firstViewAttribute.view.superview;
    }
    
    RTLayoutConstraint *existingConstraint = nil;
    if (self.updateExisting) {
        existingConstraint = [self filterExistingLayoutConstraint:layoutConstraint];
    }
    if (existingConstraint) {
        existingConstraint.constant = layoutConstraint.constant;
        self.layoutConstraint = existingConstraint;
    } else {
        [self.installedView addConstraint:layoutConstraint];
        self.layoutConstraint = layoutConstraint;
        [firstLayoutItem.installedConstraintBuffer addObject:self];
    }
    
}

- (void)uninstall {
    self.layoutConstraint.active = NO;
    [self.firstViewAttribute.view.installedConstraintBuffer removeObject:self];
    
}

- (RTLayoutConstraint *)filterExistingLayoutConstraint:(RTLayoutConstraint *)layoutConstraint {
    for (NSLayoutConstraint *existingConstraint in self.installedView.constraints.reverseObjectEnumerator) {
        if (![existingConstraint isKindOfClass:[RTLayoutConstraint class]]) continue;
        if (existingConstraint.firstItem != layoutConstraint.firstItem) continue;
        if (existingConstraint.secondItem != layoutConstraint.secondItem) continue;
        if (existingConstraint.firstAttribute != layoutConstraint.firstAttribute) continue;
        if (existingConstraint.secondAttribute != layoutConstraint.secondAttribute) continue;
        if (existingConstraint.priority != layoutConstraint.priority) continue;
        if (existingConstraint.relation != layoutConstraint.relation) continue;
        if (existingConstraint.multiplier != layoutConstraint.multiplier) continue;
        return (id)existingConstraint;
    }
    return nil;
}

+ (NSArray *)installConstraintsForView:(UIView *)aView {
    return [aView.installedConstraintBuffer allObjects];
}

@end
