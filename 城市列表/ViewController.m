//
//  ViewController.m
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import "ViewController.h"
#import "JHHeader.h"
#define PATH @"/Users/liyijia/Desktop/JH/练习/城市列表/城市列表/MyPlists.plist"
#import "JHCityView.h"
@interface ViewController ()
{
    JHCityView *city;
}
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    [city relouDad];
    [city shaheDatas];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
//    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
//
//    NSError *error;
//    NSArray *arrays = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//    
//    if (error) {
//        NSLog(@"%@",error);
//    }
//    NSMutableArray *Zongsj = [NSMutableArray array];
//    NSString *luin = [[NSBundle mainBundle] pathForResource:@"MyPlist" ofType:@"plist"];
//
//    NSMutableArray *date = [[NSMutableArray alloc] initWithContentsOfFile:luin];
//    NSMutableArray *mutarr = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
//    for (int j = 0; j<mutarr.count; j++) {
//        NSMutableArray *mutArray = [NSMutableArray array];
//
//        NSMutableDictionary *mutdict = [NSMutableDictionary dictionary];
//        [mutdict setObject:mutarr[j] forKey:@"paixu"];
//        char q = [mutarr[j] characterAtIndex:0];
//        for (int i =0 ; i<date.count; i++) {
//            NSDictionary *dict = date[i];
//           char p = [dict[@"pinyin"] characterAtIndex:0];
//            if (p ==q+32) {
//                [mutArray addObject:dict];
//            }
//        }
//        [mutdict setObject:mutArray forKey:@"city"];
//        [Zongsj addObject:mutdict];
//    }
//    NSArray*zhongshuju = [NSArray array];
//    zhongshuju = Zongsj;
//    NSLog(@"%@",zhongshuju);
//    NSString *lujin = [[NSBundle mainBundle] pathForResource:@"MyPlists" ofType:@"plist"];
//    BOOL bol = [zhongshuju writeToFile:PATH atomically:YES];
//    if (bol) {
//        NSLog(@"写入成功");
//    }else{
//        NSLog(@"写入失败");
//    }
    self.view.backgroundColor= [UIColor orangeColor];
    city = [[JHCityView alloc]initWithController:self form:CGRectMake(0, 64, WIDTH, HEIGHT)];
    [self.view addSubview:city];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
