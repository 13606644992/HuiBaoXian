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
        [cell initAnyThingWith:cell];
    }
    return cell;
}
-(void)initAnyThingWith:(HomeCell *)cell
{
    __weak HomeCell *view= cell;
    
    [cell.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(10);
        make.top.equalTo(view).with.offset(20);
        make.bottom.equalTo(view).with.offset(-20);
        make.width.equalTo(@(ScreenWindowWidth/3-10));
    }];
    [cell.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleImg.mas_right).with.offset(15);
        make.top.equalTo(self.titleImg);
        make.height.equalTo(@(27));
        make.width.equalTo(@(100));
    }];
    [cell.contentView addSubview:self.hotImg];
    [self.hotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).with.offset(10);
        make.top.equalTo(self.titleImg);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    [cell.contentView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom);
        make.width.equalTo(@(100));
        make.height.equalTo(@(18));
    }];
    [cell.contentView addSubview:self.fanLab];
    [self.fanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.desLab.mas_right).with.offset(2);
        make.top.equalTo(self.desLab);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [cell.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.mas_equalTo(self.desLab.mas_bottom).with.offset(5);
        make.width.equalTo(@(200));
        make.height.equalTo(@(30));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
-(void)setModel:(HomeCellModel *)model
{
    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"01.jpg"]];
    
    CGRect tempRect = [self.titleLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-ScreenWindowWidth/3-65,25)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}context:nil];
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tempRect.size.width+10));
    }];
    CGRect desRect = [self.desLab.text   boundingRectWithSize:CGSizeMake(ScreenWindowWidth-ScreenWindowWidth/3-85,25)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}context:nil];
    [self.desLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(desRect.size.width+10));
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
-(UIImageView *)hotImg
{
    if (!_hotImg) {
        _hotImg = [[UIImageView alloc] init];
    }
    return _hotImg;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.text = @"保骉车险(按月付)🔥";
    }
    return _titleLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab =[[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:11];
        _desLab.textColor = [UIColor lightGrayColor];
        _desLab.text = @"0首付0利息/三号车主得";
    }
    return _desLab;
}
-(UILabel *)fanLab
{
    if (!_fanLab) {
        _fanLab =[[UILabel alloc] init];
        _fanLab.font = [UIFont systemFontOfSize:11];
        _fanLab.textColor = [UIColor orangeColor];
        _fanLab.text = @"36% 返利";
    }
    return _fanLab;
}
-(UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab =[[UILabel alloc] init];
        _amountLab.font = [UIFont systemFontOfSize:17];
        _amountLab.textColor = UIColorRGBA(46, 206, 178, 1);
        _amountLab.text = @"¥ 15元";
    }
    return _amountLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
