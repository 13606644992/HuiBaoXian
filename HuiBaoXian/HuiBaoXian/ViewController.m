//
//  ViewController.m
//  HuiBaoXian
//
//  Created by  admin on 2016/11/15.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor redColor];
}
+(void)setTabBarViewNav
{
    HomeController *balanceView = [[HomeController alloc] init];
    UINavigationController *balanceNav = [[UINavigationController alloc] initWithRootViewController:balanceView];
    balanceNav.tabBarItem.title = @"首页";
    balanceNav.tabBarItem.image = [UIImage imageNamed:@"icon@3x"];
    MallController *walletView = [[MallController alloc]init];
    UINavigationController *walletNav = [[UINavigationController alloc] initWithRootViewController:walletView];
    walletNav.tabBarItem.title = @"保险商城";
    walletNav.tabBarItem.image = [UIImage imageNamed:@"icon@3x"];
    RoomController *checkView = [[RoomController alloc]init];
    UINavigationController *checkNav = [[UINavigationController alloc] initWithRootViewController:checkView];
    checkNav.tabBarItem.title = @"保险课堂";
    checkNav.tabBarItem.image = [UIImage imageNamed:@"icon@3x"];
    ;
    MyController *myView = [[MyController alloc]init];
    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:myView];
    myNav.tabBarItem.title = @"我";
    myNav.tabBarItem.image = [UIImage imageNamed:@"icon@3x"];
    ;
    UITabBarController *tabBarControl =[[UITabBarController alloc]init];
    tabBarControl.tabBar.tintColor = [UIColor blueColor];
    tabBarControl.viewControllers = @[balanceNav,walletNav,checkNav,myNav];
    [[UITabBar appearance] setTintColor:UIColorRGBA(46, 206, 178, 1)];

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController =tabBarControl;
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
