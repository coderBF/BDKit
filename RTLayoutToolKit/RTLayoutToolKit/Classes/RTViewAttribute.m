// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     RTViewAttribute.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/24
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "RTViewAttribute.h"

@implementation RTViewAttribute

- (instancetype)initWithView:(UIView *)view layoutAttribute:(NSLayoutAttribute)attr {
    if (self = [super init]) {
        _view = view;
        _item = view;
        _layoutAttribute = attr;
    }
    return self;
}

- (BOOL)isSizeAttribute {
    return self.layoutAttribute == NSLayoutAttributeWidth ||
    self.layoutAttribute == NSLayoutAttributeHeight;
}

@end
