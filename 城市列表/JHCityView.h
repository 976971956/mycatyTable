//
//  JHCityView.h
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHCityView : UIView
+(JHCityView *)shardManager;
-(instancetype)initWithController:(UIViewController *)cotroller form:(CGRect)form;
-(void)relouDad;//刷新tableview数据
-(void)shaheDatas;//刷新最近数据
@end
