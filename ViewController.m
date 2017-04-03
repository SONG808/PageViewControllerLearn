//
//  ViewController.m
//  test
//
//  Created by 木木木公 on 2017/3/26.
//  Copyright © 2017年 木木木公. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "Test02ViewController.h"
#import "Test03ViewController.h"
#import <Masonry.h>

@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property(nonatomic, strong) UIPageViewController * pageViewController;
@property(nonatomic, strong) NSArray * viewControllers;
@property(nonatomic, assign) NSInteger  index;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化pagecontroller
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate   = self;
    self.pageViewController.dataSource = self;
    
    //设置page viewcontrollers
    TestViewController * vc1 = [[TestViewController alloc]init];
    Test02ViewController * vc2 = [[Test02ViewController alloc]init];
    Test03ViewController * vc3 = [[Test03ViewController alloc]init];
    self.viewControllers = @[vc1,vc2,vc3];
    self.index = 0;
    
    [self.pageViewController setViewControllers:@[vc1] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
    //添加page 到 self.view
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    //[self.pageViewController didMoveToParentViewController:self];
    
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (self.index == 0 || self.index == NSNotFound) {
        return nil;
    }
    
    self.index --;
    
    return self.viewControllers[self.index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (self.index == self.viewControllers.count -1 || self.index == NSNotFound) {
        return nil;
    }
    
    self.index++;
    
    return self.viewControllers[self.index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    self.index = [self.viewControllers indexOfObject:pageViewController.viewControllers[0]];
}


@end
