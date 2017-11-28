// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTLayoutToolKit.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/22
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import <Foundation/Foundation.h>
#import "RTConstraint.h"
@import UIKit;

typedef NS_OPTIONS(NSInteger, RTLayoutAttribute) {
    RTLayoutAttributeLeft = 1 << NSLayoutAttributeLeft,
    RTLayoutAttributeRight = 1 << NSLayoutAttributeRight,
    RTLayoutAttributeTop = 1 << NSLayoutAttributeTop,
    RTLayoutAttributeBottom = 1 << NSLayoutAttributeBottom,
    
    RTLayoutAttributeWidth = 1 << NSLayoutAttributeWidth,
    RTLayoutAttributeHeight = 1 << NSLayoutAttributeHeight,
    
    RTLayoutAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    RTLayoutAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    
};


@interface RTLayoutToolKit : NSObject

@property (nonatomic, strong) NSMutableArray *constraints;

- (instancetype)initWithView:(UIView *)aView;
@property (nonatomic, weak, readonly) UIView *aView;

- (void(^)(void))install;

@property (nonatomic, strong, readonly) RTConstraint *top;
@property (nonatomic, strong, readonly) RTConstraint *bottom;
@property (nonatomic, strong, readonly) RTConstraint *left;
@property (nonatomic, strong, readonly) RTConstraint *right;

@property (nonatomic, strong, readonly) RTConstraint *width;
@property (nonatomic, strong, readonly) RTConstraint *height;

@property (nonatomic, strong, readonly) RTConstraint *center;
@property (nonatomic, strong, readonly) RTConstraint *centerX;
@property (nonatomic, strong, readonly) RTConstraint *centerY;

@property (nonatomic, assign, readonly) RTConstraint *edges;

@property (nonatomic, strong, readonly) RTConstraint *size;

@property (nonatomic, assign) BOOL updateExisting;
@property (nonatomic, assign) BOOL removeExisting;

@end
