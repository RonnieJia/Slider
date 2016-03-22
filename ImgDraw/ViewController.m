//
//  ViewController.m
//  ImgDraw
//
//  Created by HuaoEAge on 16/3/22.
//  Copyright © 2016年 HuaoEAge. All rights reserved.
//

#import "ViewController.h"
#import "RJSilder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RJSilder *slider = [[RJSilder alloc] initWithFrame:CGRectMake(0, 60, 320, 320)];
    slider.center = self.view.center;
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
