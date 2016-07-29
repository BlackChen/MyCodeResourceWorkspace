//
//  ViewController.m
//  OtherDemoList
//
//  Created by 陈黔 on 16/7/29.
//  Copyright © 2016年 BlackChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIViewController *vc1,*vc2,*vc3,*vc4;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    [self setVC];
}

- (void)setVC{
    vc1 = [[UIViewController alloc]init];
    vc1.title = @"Demo";
    vc2 = [[UIViewController alloc]init];
    vc2.title = @"书籍";
    vc3 = [[UIViewController alloc]init];
    vc3.title = @"博客";
    vc4 = [[UIViewController alloc]init];
    vc4.title = @"其他";

    UINavigationController *nv1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    UINavigationController *nv2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    UINavigationController *nv3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    UINavigationController *nv4 = [[UINavigationController alloc]initWithRootViewController:vc4];

    [self setViewControllers:@[nv1,nv2,nv3,nv4]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
