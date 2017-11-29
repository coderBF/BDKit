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

- (RTViewAttribute *)layout_top;
- (RTViewAttribute *)layout_bottom;
- (RTViewAttribute *)layout_left;
- (RTViewAttribute *)layout_right;

- (RTViewAttribute *)layout_width;
- (RTViewAttribute *)layout_height;

- (RTViewAttribute *)layout_centerX;
- (RTViewAttribute *)layout_centerY;


- (UIView *)filterCommonSuperView:(UIView *)view;
@end
