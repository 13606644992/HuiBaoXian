//
//  HomeSiftCell.m
//  HuiBaoXian
//
//  Created by 李阳 on 2016/12/12.
//  Copyright © 2016年 baobao. All rights reserved.
//

#import "HomeSiftCell.h"

@implementation HomeSiftCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeSiftCell";
    HomeSiftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        [cell initAnyThingWith:cell];
    }
    return cell;
}
-(void)initAnyThingWith:(HomeSiftCell *)cell
{
    __weak HomeSiftCell *view= cell;
    
    [cell.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).with.offset(-10);
        make.top.equalTo(view).with.offset(20);
        make.bottom.equalTo(view).with.offset(-20);
        make.width.equalTo(@(ScreenWindowWidth*2/5));
    }];
    [cell.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(15);
        make.right.mas_equalTo(self.titleImg.mas_left).with.offset(-10);
        make.top.equalTo(self.titleImg).with.offset(10);
        make.height.equalTo(@(25));
    }];
    [cell.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(2.5);
        make.right.mas_equalTo(self.titleImg.mas_left).with.offset(-10);
        make.height.equalTo(@(15));
    }];
    [cell.contentView addSubview:self.amountKindLab];
    [self.amountKindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 18));
    }];
    [cell.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountKindLab.mas_right);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(5);
        make.width.equalTo(@(100));
        make.height.equalTo(@(25));
    }];
    [cell.contentView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLab.mas_right).with.offset(5);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(26, 18));
    }];
    [cell.contentView addSubview:self.fanValueLab];
    [self.fanValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fanLab.mas_right).with.offset(0);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(5);
        make.right.mas_equalTo(self.titleImg.mas_left).with.offset(-10);
        make.height.equalTo(@(25));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HomeCellModel *)model
{
    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"01.jpg"]];
    
    CGRect tempRect = [self.amountLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-ScreenWindowWidth/3-65,25)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}context:nil];
    [self.amountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+5));
    }];
    [self layoutIfNeeded];
    
}
#pragma mark  -------Controller
-(UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.jpg"]];
    }
    return _titleImg;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.text = @"少儿意外医疗险";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab =[[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:11];
        _desLab.textColor = [UIColor lightGrayColor];
        _desLab.text = @"5万人身意外，5千医疗保障";
    }
    return _desLab;
}
-(UILabel *)fanLab
{
    if (!_fanLab) {
        _fanLab =[[UILabel alloc] init];
        _fanLab.font = [UIFont systemFontOfSize:11];
        _fanLab.textColor = [UIColor orangeColor];
        _fanLab.text = @"返利";
    }
    return _fanLab;
}
-(UILabel *)fanValueLab
{
    if (!_fanValueLab) {
        _fanValueLab =[[UILabel alloc] init];
        _fanValueLab.font = [UIFont systemFontOfSize:14];
        _fanValueLab.textColor = [UIColor orangeColor];
        _fanValueLab.text = @"36%";
    }
    return _fanValueLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab =[[UILabel alloc] init];
        _amountLab.font = [UIFont systemFontOfSize:17];
        _amountLab.textColor = UIColorRGBA(46, 206, 178, 1);
        _amountLab.text = @"15元";
    }
    return _amountLab;
}
-(UILabel *)amountKindLab
{
    if (!_amountKindLab) {
        _amountKindLab =[[UILabel alloc] init];
        _amountKindLab.font = [UIFont systemFontOfSize:14];
        _amountKindLab.textColor = UIColorRGBA(46, 206, 178, 1);
        _amountKindLab.text = @"¥";
    }
    return _amountKindLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
