//
//  CityTableViewCell.m
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell

//初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _name =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 30)];
        _name.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:_name];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
