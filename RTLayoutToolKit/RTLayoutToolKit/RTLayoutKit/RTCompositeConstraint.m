// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTCompositeConstraint.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/27
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "RTCompositeConstraint.h"

@interface RTCompositeConstraint ()

@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@implementation RTCompositeConstraint

- (instancetype)initWithConstraints:(NSArray *)constraints {
    if (self = [super init]) {
        _childConstraints = [constraints mutableCopy];
    }
    return self;
}

- (RTConstraint *(^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attr, NSLayoutRelation relation) {
        for (RTConstraint *constraint in _childConstraints.copy) {
            constraint.equalToWithRelation(attr, relation);
        }
        return self;
    };
}

- (RTConstraint *(^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (RTConstraint *constraint in _childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}

- (RTConstraint *(^)(UILayoutPriority))priority {
    return ^(UILayoutPriority priority) {
        for (RTConstraint *constraint in _childConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}

- (void)install {
    for (RTConstraint *constraint in _childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}

- (void)uninstall {
    for (RTConstraint *constraint in _childConstraints) {
        [constraint uninstall];
    }
}

- (void)setInsets:(UIEdgeInsets)insets {
    for (RTConstraint *constraint in _childConstraints) {
        [constraint setInsets:insets];
    }
}

- (void)setSize:(CGSize)size {
    for (RTConstraint *constraint in _childConstraints) {
        [constraint setSize:size];
    }
}

@end
