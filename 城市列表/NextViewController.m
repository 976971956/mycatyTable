//
//  NextViewController.m
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()
@property (weak, nonatomic) IBOutlet UILabel *CityLable;
- (IBAction)fanhui:(UIButton *)sender;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _CityLable.text = _dict[@"name"];
    
    NSLog(@"%@",_dict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fanhui:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
