//
//  CityModel.h
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property (copy,nonatomic)NSString * name;
@property (copy,nonatomic)NSString * spell;
@property (copy,nonatomic)NSString * adcode;
@property (copy,nonatomic)NSString * citycode;
@property (copy,nonatomic)NSString * latitude;
@property (copy,nonatomic)NSString * level;
@property (copy,nonatomic)NSString * longitude;
@property (copy,nonatomic)NSString * pinyin;
@end
