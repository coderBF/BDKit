// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     UIView+Layout.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/23
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "UIView+Layout.h"

@implementation UIView (Layout)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)layout_makeConstraints:(void (^)(RTLayoutToolKit *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    RTLayoutToolKit *layout = [[RTLayoutToolKit alloc] initWithView:self];
    block(layout);
    layout.install();
}

- (void)layout_updateConstraints:(void (^)(RTLayoutToolKit *))block {
    RTLayoutToolKit *layout = [[RTLayoutToolKit alloc] initWithView:self];
    layout.updateExisting = YES;
    block(layout);
    layout.install();
}

- (void)layout_remakeConstraints:(void (^)(RTLayoutToolKit *))block {
    RTLayoutToolKit *layout = [[RTLayoutToolKit alloc] initWithView:self];
    layout.removeExisting = YES;
    block(layout);
    layout.install();
}

#pragma clang diagnostic pop

#pragma mark -
- (RTViewAttribute *)top {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (RTViewAttribute *)bottom {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (RTViewAttribute *)left {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (RTViewAttribute *)right {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (RTViewAttribute *)width {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (RTViewAttribute *)height {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (RTViewAttribute *)centerX {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (RTViewAttribute *)centerY {
    return [[RTViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

#pragma mark -
- (UIView *)filterCommonSuperView:(UIView *)view {
    UIView *commonSuperview = nil;
    UIView *secondSuperview = view;
    while (!commonSuperview && secondSuperview) {
        UIView *firstSuperview = self;
        while (!commonSuperview && firstSuperview) {
            if (secondSuperview == firstSuperview) {
                commonSuperview = secondSuperview;
            }
            firstSuperview = firstSuperview.superview;
        }
        secondSuperview = secondSuperview.superview;
    }
    return commonSuperview;
}

@end
