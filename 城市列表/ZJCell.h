//
//  ZJCell.h
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZJCell : UITableViewCell
@property(nonatomic,assign)BOOL Intger;
@property(nonatomic, strong)NSArray *array;
-(void)setArray:(NSArray *)array setInter:(BOOL)bol;
@end
