// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTConstraint.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/24
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "RTConstraint.h"


@implementation RTConstraint

- (RTConstraint *(^)(UIEdgeInsets))insets {
    return ^id(UIEdgeInsets insets) {
        self.insets = insets;
        return self;
    };
}

- (RTConstraint *(^)(CGSize))size {
    return ^id(CGSize size) {
        [self setSize:size];
        return self;
    };
}

- (RTConstraint *(^)(id))equalTo {
    return ^id(id attr) {
        return self.equalToWithRelation(attr, NSLayoutRelationEqual);
    };
}

- (RTConstraint *(^)(id))greaterThanOrEqualTo {
    return ^id(id attr) {
        return self.equalToWithRelation(attr, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (RTConstraint *(^)(id))lessThanOrEqualTo {
    return ^id(id attr) {
        return self.equalToWithRelation(attr, NSLayoutRelationLessThanOrEqual);
    };
}

- (RTConstraint *(^)(CGFloat))offset {
    return ^id(CGFloat offset) {
        self.offset = offset;
        return self;
    };
}

- (RTConstraint *(^)(void))priorityLow {
    return ^id(void) {
        return self.priority(UILayoutPriorityDefaultLow);
    };
}

- (RTConstraint *(^)(void))priorityHigh {
    return ^id(void) {
        return self.priority(UILayoutPriorityDefaultHigh);
    };
}

- (RTConstraint *(^)(void))priorityFittingSizeLevel {
    return ^id(void) {
        return self.priority(UILayoutPriorityFittingSizeLevel);
    };
}


- (RTConstraint *(^)(id, NSLayoutRelation))equalToWithRelation {
    return nil;
}

- (RTConstraint *(^)(CGFloat))multipliedBy {
    return nil;
}

- (RTConstraint *(^)(UILayoutPriority))priority {
    return nil;
}

- (void)setOffset:(CGFloat)offset {}
- (void)setInsets:(UIEdgeInsets)insets {}
- (void)setSize:(CGSize)size {}


- (void)install {}
- (void)uninstall {}

@end
