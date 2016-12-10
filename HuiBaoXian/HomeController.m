//
//  HomeController.m
//  HuiBaoXian
//
//  Created by 李阳 on 2016/12/6.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import "HomeController.h"
#import "Header.h"
#import "HomeCell.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,AEImagePlayerViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
@property (nonatomic ,strong) UITableView *tabView;
/** 存放所有cell的高度 */
@property (strong, nonatomic) NSMutableDictionary *heights;
@property (nonatomic, weak)AEImagePlayerView *playerView;//图片轮播器
@property (nonatomic, strong)NSMutableArray *locaImages;//图片
@property (nonatomic ,strong) UIButton *searchBtn;
@property (nonatomic ,strong) UILabel *bulletinLab;
@property (nonatomic ,strong) UIImageView *bulletinImg;
@property (nonatomic ,strong) UIView *bulleView;
@property (nonatomic ,strong) UIView *farView;
@property (nonatomic, strong)NSArray *farTitleArrays;//
@property (nonatomic, strong)NSArray *farImgArrays;//


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = UIColorRGBA(255, 211, 118, 1);
    [self.view addSubview:self.tabView];
    [self setViewHeader];

    
    
}
#pragma mark --------TableView-----------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.heights[@(indexPath.row)] floatValue];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [HomeCell cellWithTableView: tableView];
    // 获取高度
    CGFloat tmpHeight = [cell cellHeight];
    
    [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];

    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 600;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 200)];
    [self setPlayerWithHeaderView:HeaderView];
    return HeaderView;
}
-(void)setViewHeader
{
    
    [self.navigationController.view addSubview:self.searchBtn];
    
    __weak UIView *topView = self.navigationController.view;
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (topView).with.offset(20);
        make.top.equalTo(topView).with.offset(20);
        make.right.equalTo(topView).with.offset(-70);
        make.height.equalTo(@(40));
        
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"00"] forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(0,0,50, 40);
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    
    // 添加角标
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    [navLeftButton ];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @"5";
    self.navigationItem.rightBarButtonItem.badgeBGColor = UIColorRGBA(255, 118, 53, 1);
    self.navigationItem.rightBarButtonItem = navLeftButton;
}
-(void)buttonPress:(UIButton *)sender
{
    NSLog(@"----");
    self.navigationItem.rightBarButtonItem.badgeValue = @"";
}
#pragma mark -----ScrollViewDelegate---UADScroll------
-(void)setPlayerWithHeaderView:(UIView *)headerView
{
    AEImagePlayerView *playerView = [[AEImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 200)];
    _playerView = playerView;
    playerView.images = self.locaImages;//设置默认图片
    playerView.delegate = self;
    playerView.pageLocation = AEPageViewLocationLeft;
    [headerView addSubview:playerView];
    [headerView addSubview:self.farView];
    [self.farView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headerView).with.offset(10);
        make.top.mas_equalTo(playerView.mas_bottom).with.offset(10);
        make.right.equalTo(headerView).with.offset(-10);
        make.height.equalTo(@(120));
    }];
    [self setFarViewWith:self.farView];
    
    [headerView addSubview:self.bulleView];
    [self.bulleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headerView).with.offset(10);
        make.top.mas_equalTo(self.farView.mas_bottom).with.offset(10);
        make.right.equalTo(headerView).with.offset(-10);
        make.height.equalTo(@(40));
    }];
    [headerView addSubview:self.bulletinImg];

    [self.bulletinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).with.offset(15);
        make.top.mas_equalTo(self.farView.mas_bottom).with.offset(22.5);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [headerView addSubview:self.bulletinLab];
    [self.bulletinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bulletinImg.mas_right).with.offset(5);
        make.top.mas_equalTo(self.farView.mas_bottom).with.offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(ScreenWindowWidth/5));
    }];
    CGFloat leftStart = 35 + ScreenWindowWidth/5+5;
    CGFloat kuan = ScreenWindowWidth-leftStart-15;
    UADScrollView *ccpView = [[UADScrollView alloc] initWithFrame:CGRectMake(leftStart, 340, kuan,40)];
    ccpView.titleArray = [NSArray arrayWithObjects:@"iPhone6s上线32G内存手机你怎么看？",@"亲爱的朋友们2016年还有100天就要过去了,2017年您准备好了吗?",@"今年双11您预算了几个月的工资？",@"高德与百度互掐，你更看好哪方？", nil];
    
    ccpView.titleFont = 13;
    
    ccpView.titleColor = [UIColor blackColor];
    
    ccpView.BGColor = [UIColor whiteColor];
    
    [ccpView clickTitleLabel:^(NSInteger index,NSString *titleString) {
        
        NSLog(@"%ld-----%@",index,titleString);
        
    }];
    [headerView addSubview:ccpView];
}
-(void)setFarViewWith:(UIView *)view{
    NSInteger count = 5;//设置一排view的个数
    NSInteger height = 120;//设置view的高度
    CGFloat kuan = (ScreenWindowWidth-20)/count;
    
    for (int i = 0; i < count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.farTitleArrays[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon@3x"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(20, 10, 60, button.titleLabel.bounds.size.width);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleEdgeInsets = UIEdgeInsetsMake(80, -button.titleLabel.bounds.size.width-30, 10, 0);
        button.tag = i+1;
        button.frame = CGRectMake(i*kuan, 0, kuan, height);
        
        [button addTarget:self action:@selector(farClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
        
}
-(void)farClick:(UIButton *)sender
{
    NSLog(@"-----%ld",sender.tag);
}
//图片轮播器代理
- (void)imagePlayerView:(AEImagePlayerView *)playerview didClickIndex:(long long)index{
    NSLog(@"---%lld",index);
    
    
}
#pragma mark ----------Anything--------------------
-(UIImageView *)bulletinImg
{
    if (!_bulletinImg) {
        _bulletinImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"00"]];
    }
    
    return _bulletinImg;
}
-(UILabel *)bulletinLab
{
    if (!_bulletinLab) {
        _bulletinLab = [[UILabel alloc] init];
        _bulletinLab.backgroundColor = [UIColor whiteColor];
        _bulletinLab.textColor = UIColorRGBA(49, 202, 172, 1);
        _bulletinLab.font = [UIFont fontWithName:JiaCu size:14];
        _bulletinLab.text = @"小汇快报:";
        _bulletinLab.textAlignment = NSTextAlignmentCenter;
    }
    return _bulletinLab;
}
-(UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setBackgroundColor:[UIColor whiteColor]];
        [_searchBtn setTitle:@"🔍 搜索产品" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _searchBtn.layer.cornerRadius = 20.0f;
        _searchBtn.clipsToBounds = YES;
        _searchBtn.alpha = 0.8;
    }
    
    return _searchBtn;
}
-(NSMutableArray *)locaImages
{
    if (!_locaImages) {
        
        _locaImages = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"01.jpg"],[UIImage imageNamed:@"01.jpg"],[UIImage imageNamed:@"01.jpg"],[UIImage imageNamed:@"01.jpg"], nil];
        
    }
    return _locaImages;
}
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight) style:UITableViewStyleGrouped];
//        _tabView.backgroundColor = UIColorRGBA(247, 247, 247, 1);
        _tabView.delegate = self;
        _tabView.dataSource = self;
    }
    return _tabView;
}
- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}
-(UIView *)bulleView
{
    if (!_bulleView) {
        _bulleView = [[UIView alloc] init];
        _bulleView.backgroundColor = [UIColor whiteColor];
    }
    return _bulleView;
}
-(UIView *)farView
{
    if (!_farView) {
        _farView = [[UIView alloc] init];
        _farView.backgroundColor = [UIColor whiteColor];
    }
    return _farView;
}
-(NSArray *)farTitleArrays
{
    if (!_farTitleArrays) {
        _farTitleArrays = @[@"车险",@"人寿险",@"健康险",@"意外险",@"财产险"];
    }
    return _farTitleArrays;
}
-(NSArray *)farImgArrays
{
    if (!_farImgArrays) {
        _farImgArrays = @[];
    }
    return _farImgArrays;
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
