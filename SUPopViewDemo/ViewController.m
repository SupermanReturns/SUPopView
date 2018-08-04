//
//  ViewController.m
//  SUPopViewDemo
//
//  Created by Superman on 2018/8/2.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "ViewController.h"
#import "SUPopView.h"

@interface ViewController ()<SUPopViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=CGRectMake(100, 200, 70, 30);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)clickAction{
    SUPopView *popView = [SUPopView popViewConfirmBtnTitle:@"确定" cancleBtnTitle:@"取消"];
    popView.delegate = self;
    [popView showInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
