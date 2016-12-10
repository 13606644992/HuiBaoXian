//
//  HomeCell.h
//  HuiBaoXian
//
//  Created by 李阳 on 2016/12/9.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface HomeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;

@end
