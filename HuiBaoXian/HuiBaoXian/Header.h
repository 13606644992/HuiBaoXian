//首页
#import "HomeController.h"
//保险商城
#import "MallController.h"
//保险课堂
#import "RoomController.h"
//我
#import "MyController.h"



#pragma mark ----TheThird---------------
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry.h>
#import <MJRefresh.h>

#pragma mark ----Controller---------------

#import "AppDelegate.h"
#import "ViewController.h"
//广播
#import "UADScrollView.h"
//轮播
#import "AEImagePlayerView.h"
#import "AEPageView.h"

#import "UIBarButtonItem+Badge.h"




#pragma mark ----Anything---------------

//RGB色彩
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//屏幕宽度
#define ScreenWindowWidth                        [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define ScreenWindowHeight                       [[UIScreen mainScreen] bounds].size.height
//加载等待
#define SVProgressWait       [SVProgressHUD showWithStatus:@"加载中，请稍后。。。"]
//加载结束
#define SVProgressStop              [SVProgressHUD dismiss]
//字体加粗
#define JiaCu  @"Helvetica-Bold"
//请求时间
#define waitTime   10.0f;

#define SVProgress(AnyThing)      [SVProgressHUD showSuccessWithStatus:AnyThing];
