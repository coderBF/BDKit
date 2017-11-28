// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTViewAttribute.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/24
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import <Foundation/Foundation.h>
@import UIKit;

@interface RTViewAttribute : NSObject

@property (nonatomic, weak, readonly) UIView * view;

@property (nonatomic, weak, readonly) id item;

@property (nonatomic, assign, readonly) NSLayoutAttribute layoutAttribute;

- (instancetype)initWithView:(UIView *)view layoutAttribute:(NSLayoutAttribute)attr;

- (BOOL)isSizeAttribute;

@end
