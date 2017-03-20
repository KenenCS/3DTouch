//
//  ViewController.m
//  3DTouch
//
//  Created by kenen on 2017/3/20.
//  Copyright © 2017年 kenen. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>

@interface ViewController ()<UIViewControllerPreviewingDelegate> {
    UILabel *label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)loadView
{
    [super loadView];
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"我的微博";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    //注册代理
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}

#pragma mark----PreviewingDelegate
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    //固定这么写
    [self showViewController:viewControllerToCommit sender:self];
}

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //location就是重压点坐标,如果按压点在label上执行以下方法
    if (location.x > 100 && location.x < 200 && location.y > 100 && location.y < 200) {
        SFSafariViewController *mySV = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        //第一次按压时,弹出的窗口尺寸,再次按压则跳转到mySV
        mySV.preferredContentSize = CGSizeMake(0, 400);
        previewingContext.sourceRect = label.frame;//设置高亮区域
        return mySV;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
