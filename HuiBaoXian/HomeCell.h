//
//  HomeCell.h
//  HuiBaoXian
//
//  Created by 李阳 on 2016/12/9.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "HomeCellModel.h"

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) HomeCellModel *model;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UIImageView *hotImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UILabel *fanLab;
@property (nonatomic, strong) UILabel *amountLab;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
