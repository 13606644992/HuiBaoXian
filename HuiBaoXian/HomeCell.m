//
//  HomeCell.m
//  HuiBaoXian
//
//  Created by 李阳 on 2016/12/9.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return  40;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
