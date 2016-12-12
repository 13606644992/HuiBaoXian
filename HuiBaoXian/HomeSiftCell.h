//
//  HomeSiftCell.h
//  HuiBaoXian
//
//  Created by 李阳 on 2016/12/12.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "HomeCellModel.h"

@interface HomeSiftCell : UITableViewCell
@property (nonatomic, strong) HomeCellModel *model;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) UILabel *fanLab;
@property (nonatomic, strong) UILabel *fanValueLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *amountKindLab;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
