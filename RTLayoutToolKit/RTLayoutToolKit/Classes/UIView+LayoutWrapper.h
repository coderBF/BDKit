// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     UIView+LayoutWrapper.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/27
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import <UIKit/UIKit.h>

@interface UIView ()

- (void)layout_makeConstraints:(void(^)(RTLayoutToolKit *tool))block;
- (void)layout_updateConstraints:(void(^)(RTLayoutToolKit *tool))block;
- (void)layout_remakeConstraints:(void(^)(RTLayoutToolKit *tool))block;

@end
