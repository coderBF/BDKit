// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     UIView+Layout.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/23
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import <UIKit/UIKit.h>
#import "RTLayoutToolKit.h"
#import "RTViewAttribute.h"
#import "UIView+LayoutWrapper.h"

@interface UIView (Layout)

- (RTViewAttribute *)top;
- (RTViewAttribute *)bottom;
- (RTViewAttribute *)left;
- (RTViewAttribute *)right;

- (RTViewAttribute *)width;
- (RTViewAttribute *)height;

- (RTViewAttribute *)centerX;
- (RTViewAttribute *)centerY;


- (UIView *)filterCommonSuperView:(UIView *)view;
@end
