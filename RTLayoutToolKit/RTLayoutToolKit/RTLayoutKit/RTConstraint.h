// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTConstraint.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/24
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//




#import <Foundation/Foundation.h>
#import "RTHandler.h"
@import UIKit;

#define equalTo(...)  equalTo(RTBValue((__VA_ARGS__)))
#define greaterThanOrEqualTo(...) greaterThanOrEqualTo(RTBValue((__VA_ARGS__)))
#define lessThanOrEqualTo(...) lessThanOrEqualTo(RTBValue((__VA_ARGS__)))

@interface RTConstraint : NSObject

@property (nonatomic, assign) BOOL updateExisting;

- (RTConstraint *(^)(UIEdgeInsets insets))insets;

- (RTConstraint *(^)(CGSize size))size;

- (RTConstraint *(^)(CGFloat offset))offset;

- (RTConstraint *(^)(CGFloat multiplier))multipliedBy;

- (RTConstraint *(^)(id attr))equalTo;
- (RTConstraint *(^)(id attr))greaterThanOrEqualTo;
- (RTConstraint *(^)(id attr))lessThanOrEqualTo;

- (RTConstraint *(^)(UILayoutPriority priority))priority;
- (RTConstraint *(^)(void))priorityLow;
- (RTConstraint *(^)(void))priorityHigh;
- (RTConstraint *(^)(void))priorityFittingSizeLevel;

- (RTConstraint *(^)(id, NSLayoutRelation))equalToWithRelation;

- (void)setOffset:(CGFloat)offset;
- (void)setInsets:(UIEdgeInsets)insets;
- (void)setSize:(CGSize)size;

- (void)install;
- (void)uninstall;

@end


