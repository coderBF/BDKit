// Copyright © 2017年 LEJU.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  RTLayoutToolKit
 * FILENAME:     ViewController.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2017/11/22
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//


#import "ViewController.h"

#import "RTLayoutHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [NSLayoutConstraint constraintWithItem:self.view
//                                 attribute:NSLayoutAttributeLeft
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:nil
//                                 attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1. constant:0];
    
    
    
    
    /**
     * tool.left ==> 创建constraint并缓存
     * equalTo ==> 创建attribute
     */
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    [redView layout_makeConstraints:^(RTLayoutToolKit *tool) {
//        tool.left.equalTo(self.view.left).offset(100);
//        tool.right.equalTo(self.view.right).offset(-100);
//        tool.top.equalTo(self.view.top).offset(100);
//        tool.bottom.equalTo(self.view.bottom).offset(-100);
//        tool.height.equalTo(100);
//        tool.top.equalTo(self.view.top).offset(100);
//        tool.top.equalTo(100);
//        tool.left.equalTo(30);
//        tool.right.equalTo(-30);
//        tool.height.equalTo(120);
//        tool.width.equalTo(120);
//        tool.centerY.equalTo(0);
//        tool.centerX.equalTo(0);
//        tool.top.equalTo(80);
        
//        tool.center.equalTo(self.view);
        tool.center.equalTo(0);
        
//        tool.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 100, -100, -100));
//        tool.size.equalTo(CGSizeMake(100, 100));
        tool.size.equalTo(self.view).size(CGSizeMake(-100, -100));
        
    }];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view.subviews.firstObject layout_remakeConstraints:^(RTLayoutToolKit *tool) {
        tool.top.equalTo(100);
        tool.left.equalTo(100);
        tool.size.equalTo(CGSizeMake(100, 100));
//        tool.width.equalTo(100);
//        tool.height.equalTo(self.view.subviews.firstObject.width).multipliedBy(2.);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.    
    
}


@end
