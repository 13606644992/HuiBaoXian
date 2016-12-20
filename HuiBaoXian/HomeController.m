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
#import "HomeSiftCell.h"
#import "HomeCellModel.h"

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
@property (nonatomic ,strong) UIImageView *HostImg;
@property (nonatomic ,strong) UILabel *footLab;
@property (nonatomic ,strong) UIButton *footBtn;

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
    [self.tabView.mj_header beginRefreshing];
}
//导航头
-(void)setViewHeader
{
    [self.navigationController.view addSubview:self.searchBtn];
    __weak UIView *topView = self.navigationController.view;
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (topView).with.offset(20);
        make.top.equalTo(topView).with.offset(25);
        make.right.equalTo(topView).with.offset(-50);
        make.height.equalTo(@(30));
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"messageCenter@3x"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"messageCenter@3x"] forState:UIControlStateNormal];
    //    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(0,0,25, 25);
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    // 添加角标
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //    [navLeftButton ];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @"5";
    self.navigationItem.rightBarButtonItem.badgeBGColor = UIColorRGBA(255, 118, 53, 1);
    self.navigationItem.rightBarButtonItem = navLeftButton;
}
#pragma mark -----MJRefresh----------
-(void)MJHeaderLoadTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)MJSetFooterTable
{
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2.0f];
}
-(void)endRefresh{
    [self.tabView.mj_header endRefreshing];
    [self.tabView.mj_footer endRefreshing];
}
#pragma mark -----消息中心----
-(void)buttonPress:(UIButton *)sender
{
    NSLog(@"----");
    SVProgress(@"消息中心");
    self.navigationItem.rightBarButtonItem.badgeValue = @"";
}
#pragma mark --------TableView-----------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1){
        return 3;
    }else if (section==2||section==3){
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        HomeCellModel *mode = [[HomeCellModel alloc] init];
        HomeCell *cell = [HomeCell cellWithTableView: tableView];
        cell.model = mode;
        return cell;
    }
    HomeCellModel *mode = [[HomeCellModel alloc] init];
    HomeSiftCell *cell = [HomeSiftCell cellWithTableView: tableView];
    cell.model = mode;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return ScreenWindowHeight/4+ScreenWindowHeight/6+60;
    }else if (section==1){
        return 60;
    }
    return ScreenWindowHeight/4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else if (section==1) {
        return 70;
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return [self setPlayerWithHeaderView];
    }else if (section==1){
        return [self setSectionOneHeaderView];
    }
    return [self setSectionOtherViewHeaderWithSection:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *footView = [self sectionOneView];
        return footView;
    }
    return nil;
}
-(UIView *)setSectionOneHeaderView
{
    UIView *HeaderView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWindowWidth-20, 60)];
    HeaderView2.backgroundColor = [UIColor whiteColor];
    [HeaderView2 addSubview:self.HostImg];
    __weak UIView *hView=HeaderView2;
    [self.HostImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(hView);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView2 addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(hView.mas_right).with.offset(-10);
        make.top.equalTo(hView).with.offset(12);
        make.bottom.equalTo(hView).with.offset(-12);
        make.width.equalTo(@(50));
    }];
    return HeaderView2;
}
-(UIView *)setSectionOtherViewHeaderWithSection:(NSInteger)section
{
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight/4)];
    HeaderView.backgroundColor = [UIColor whiteColor];
    UIButton *siftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [siftBtn1 addTarget:self action:@selector(siftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    siftBtn1.tag = section+1;
    [siftBtn1 sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"01.jpg"]];
    [HeaderView addSubview:siftBtn1];
    __weak UIView *hView=HeaderView;
    [siftBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hView).with.offset(10);
        make.top.equalTo(hView).with.offset(10);
        make.right.equalTo(hView).with.offset(-10);
        make.bottom.equalTo(hView).with.offset(-10);
    }];
    return HeaderView;
}
-(UIView *)sectionOneView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, 70)];
    UIView *WhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWindowWidth, 60)];
    WhiteView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:WhiteView];
    __weak UIView *view = WhiteView;
    [WhiteView addSubview:self.footLab];
    [self.footLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    [WhiteView addSubview:self.footBtn];
    [self.footBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view).with.offset(12);
        make.bottom.equalTo(view).with.offset(-12);
        make.width.equalTo(@(50));
    }];
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, ScreenWindowWidth, 1)];
    bgImg.backgroundColor = UIColorRGBA(228, 228, 228, 1);
    [footView addSubview:bgImg];
    return footView;
}
#pragma mark ----更多------------------
-(void)moreClick{
    
    NSLog(@"---更多");
    SVProgress(@"更多");
    
}
-(void)othermoreClick
{
    NSLog(@"--jingxuan-更多");
    
    SVProgress(@"精选加载更多");
    
}
#pragma mark -----ScrollViewDelegate---UADScroll------
-(UIView *)setPlayerWithHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight/3+ScreenWindowHeight/5+60)];
    AEImagePlayerView *playerView = [[AEImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWindowWidth, ScreenWindowHeight/4)];
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
        make.height.equalTo(@(ScreenWindowHeight/6));
    }];
    [self setFarViewWith:self.farView];
    
    [headerView addSubview:self.bulleView];
    [self.bulleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headerView).with.offset(10);
        make.top.mas_equalTo(self.farView.mas_bottom).with.offset(10);
        make.right.equalTo(headerView).with.offset(-10);
        make.height.equalTo(@(40));
    }];
    [self.bulleView addSubview:self.bulletinImg];

    [self.bulletinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bulleView).with.offset(5);
        make.top.equalTo(self.bulleView).with.offset(12.5);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.bulleView addSubview:self.bulletinLab];
    [self.bulletinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bulletinImg.mas_right).with.offset(5);
        make.top.equalTo(self.bulleView).with.offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(ScreenWindowWidth/5));
    }];
    CGFloat leftStart = 35 + ScreenWindowWidth/5+5;
    CGFloat kuan = ScreenWindowWidth-leftStart-20;
    UADScrollView *ccpView = [[UADScrollView alloc] initWithFrame:CGRectMake(leftStart, 0, kuan,40)];
    ccpView.titleArray = [NSArray arrayWithObjects:@"iPhone6s上线32G内存手机你怎么看？",@"亲爱的朋友们2016年还有100天就要过去了,2017年您准备好了吗?",@"今年双11您预算了几个月的工资？",@"高德与百度互掐，你更看好哪方？", nil];
    ccpView.titleFont = 13;
    ccpView.titleColor = [UIColor blackColor];
    ccpView.BGColor = [UIColor whiteColor];
    [ccpView clickTitleLabel:^(NSInteger index,NSString *titleString) {
        
        NSLog(@"%ld-----%@",index,titleString);
        
    }];
    [self.bulleView addSubview:ccpView];
    return headerView;
}
-(void)setFarViewWith:(UIView *)view{
    NSInteger count = 5;//设置一排view的个数
    NSInteger height = ScreenWindowHeight/6;//设置view的高度
    CGFloat kuan = (ScreenWindowWidth-20)/count;
    
    for (int i = 0; i < count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.farTitleArrays[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"ico@3x"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(ScreenWindowWidth/16, 10, 50, button.titleLabel.bounds.size.width);
        if (i==0) {
            button.imageEdgeInsets = UIEdgeInsetsMake(ScreenWindowWidth/16, 10, 50, button.titleLabel.bounds.size.width-15);
        }
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleEdgeInsets = UIEdgeInsetsMake(80, -button.titleLabel.bounds.size.width-30, 10, 0);
        button.tag = i+1;
        button.frame = CGRectMake(i*kuan, 0, kuan, height);
        [button addTarget:self action:@selector(farClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
}
-(void)siftBtnClick:(UIButton *)sender
{
    NSLog(@"----%ld",sender.tag);
    SVProgress(@"精选专题");
}
//快捷通道按钮
-(void)farClick:(UIButton *)sender
{
    NSLog(@"-----%ld",sender.tag-1);
    
    SVProgress(self.farTitleArrays[sender.tag-1]);
    
}
//图片轮播器代理
- (void)imagePlayerView:(AEImagePlayerView *)playerview didClickIndex:(long long)index{
//    NSLog(@"---%lld",index);
    NSString *str = [NSString stringWithFormat:@"第%lld张",index];
    
    SVProgress(str);
}
#pragma mark ----------Anything--------------------

-(UILabel *)footLab
{
    if (!_footLab) {
        _footLab = [[UILabel alloc] init];
        _footLab.text = @"精选专题";
        _footLab.textColor =[UIColor lightGrayColor];
        _footLab.font = [UIFont systemFontOfSize:15];
        _footLab.textAlignment = NSTextAlignmentCenter;
    }
    return _footLab;
}
-(UIButton *)footBtn
{
    if (!_footBtn) {
        _footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_footBtn setTitle:@"更多 >" forState:UIControlStateNormal];
        [_footBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _footBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_footBtn addTarget:self action:@selector(othermoreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footBtn;
}
-(UIImageView *)HostImg
{
    if (!_HostImg) {
        _HostImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"02"]];
    }
    return _HostImg;
}
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
        _searchBtn.layer.cornerRadius = 15.0f;
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
        _tabView.backgroundColor = UIColorRGBA(247, 247, 247, 1);
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.showsVerticalScrollIndicator = NO;
        _tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self MJHeaderLoadTable];
        }];
        _tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self MJSetFooterTable];
        }];
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
