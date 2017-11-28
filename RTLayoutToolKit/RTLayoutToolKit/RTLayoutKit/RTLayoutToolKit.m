// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTLayoutToolKit.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/22
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "RTLayoutToolKit.h"
#import "RTViewAttribute.h"
#import "RTViewConstraint.h"
#import "UIView+Layout.h"
#import "RTCompositeConstraint.h"

@implementation RTLayoutToolKit

- (instancetype)initWithView:(UIView *)aView {
    if (self = [super init]) {
        _aView = aView;
        self.constraints = @[].mutableCopy;
    }
    return self;
}

- (void (^)(void))install {
    return ^(void){
        if (self.removeExisting) {
            NSArray *installedConstraints = [RTViewConstraint installConstraintsForView:self.aView];
            for (RTConstraint *constraint in installedConstraints) {
                [constraint uninstall];
            }
        }
        
        NSArray *constraints = [self.constraints copy];
        for (RTConstraint *constraint in constraints) {
            constraint.updateExisting = self.updateExisting;
            [constraint install];
        }
        [self.constraints removeAllObjects];
    };
}

- (RTConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    RTViewAttribute *viewAttribute = [[RTViewAttribute alloc] initWithView:self.aView layoutAttribute:layoutAttribute];
    RTViewConstraint *viewConstraint = [[RTViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    [self.constraints addObject:viewConstraint];
    return viewConstraint;
}

- (RTConstraint *)addConstraintWithLayoutAttributes:(RTLayoutAttribute)attrs {
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & RTLayoutAttributeLeft) [attributes addObject:self.aView.left];
    if (attrs & RTLayoutAttributeRight) [attributes addObject:self.aView.right];
    if (attrs & RTLayoutAttributeTop) [attributes addObject:self.aView.top];
    if (attrs & RTLayoutAttributeBottom) [attributes addObject:self.aView.bottom];
    
    if (attrs & RTLayoutAttributeWidth) [attributes addObject:self.aView.width];
    if (attrs & RTLayoutAttributeHeight) [attributes addObject:self.aView.height];
    
    if (attrs & RTLayoutAttributeCenterX) [attributes addObject:self.aView.centerX];
    if (attrs & RTLayoutAttributeCenterY) [attributes addObject:self.aView.centerY];
    
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:attributes.count];
    for (RTViewAttribute *attr in attributes) {
        [constraints addObject:[[RTViewConstraint alloc] initWithFirstViewAttribute:attr]];
    }
    
    RTCompositeConstraint *compositeConstraint = [[RTCompositeConstraint alloc] initWithConstraints:constraints];
    [self.constraints addObject:compositeConstraint];
    return compositeConstraint;
}

- (RTConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (RTConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (RTConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (RTConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (RTConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (RTConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (RTConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (RTConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (RTConstraint *)center {
    return [self addConstraintWithLayoutAttributes:RTLayoutAttributeCenterX | RTLayoutAttributeCenterY];
}

- (RTConstraint *)edges {
    return [self addConstraintWithLayoutAttributes:RTLayoutAttributeTop | RTLayoutAttributeLeft | RTLayoutAttributeBottom | RTLayoutAttributeRight];
}

- (RTConstraint *)size {
    return [self addConstraintWithLayoutAttributes:RTLayoutAttributeWidth | RTLayoutAttributeHeight];
}

@end
