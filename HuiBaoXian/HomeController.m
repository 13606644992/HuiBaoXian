//
//  HomeController.m
//  HuiBaoXian
//
//  Created by 李阳 on 2016/12/6.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import "HomeController.h"
#import "Header.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tabView;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    [self.view addSubview:self.tabView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
    }
    return _tabView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
