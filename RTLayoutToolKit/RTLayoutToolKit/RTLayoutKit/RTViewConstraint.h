// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTViewConstraint.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/24
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "RTConstraint.h"
#import "RTViewAttribute.h"

@interface RTViewConstraint : RTConstraint

@property (nonatomic, strong, readonly) RTViewAttribute *firstViewAttribute;

@property (nonatomic, strong, readonly) RTViewAttribute *secondViewAttribute;

- (instancetype)initWithFirstViewAttribute:(RTViewAttribute *)firstViewAttribute;

+ (NSArray *)installConstraintsForView:(UIView *)aView;
@end
