//
//  ZJCell.m
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import "ZJCell.h"
#import "JHHeader.h"
#define  WIDTHS [UIScreen mainScreen].bounds.size.width-20

@implementation ZJCell
{
    NSMutableArray *zuijinDatas;
    NSMutableArray *NextArr;
    BOOL bols;
}
//初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor =  COLOER(247, 247, 247, 1);
        
        
    }
    return self;
}
-(void)setIntger:(BOOL)Intger
{
}
-(void)setArray:(NSArray *)array setInter:(BOOL)bol
{
    zuijinDatas = [NSMutableArray array];
    bols= bol;
    //NextArr = array;
    
    NextArr = [[NSMutableArray alloc]initWithArray:array];
    
    int totalColumns = 3;
    CGFloat W = (WIDTHS-30)/3;
    CGFloat H = 20;
    CGFloat margin = (WIDTHS - totalColumns*W)/(totalColumns + 1);
    for (int i = 0; i < array.count; i++)
    {
        NSDictionary *dict =  array[array.count-1-i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor= [UIColor whiteColor];
        button.tag = 200+i;
        int row = i /totalColumns;
        int col = i %totalColumns;
        CGFloat X = margin + col *(W + margin);
        CGFloat Y =  10+row*(H + margin);
        button.frame = CGRectMake(X, 5+Y, W, H);
        UILabel *lables = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(button.frame), 20)];
        
        lables.text = dict[@"name"];
        lables.font = [UIFont systemFontOfSize:15];
        lables.textAlignment = NSTextAlignmentCenter;
        button.tag = 130+i;
        [button addTarget:self action:@selector(Nextcotroller:) forControlEvents:UIControlEventTouchUpInside];
        
        [button addSubview:lables];
        [self addSubview:button];
        
    }

}
-(void)Nextcotroller:(UIButton *)button
{
    int i = (int)button.tag-129;
    NextViewController *vc = [[NextViewController alloc]init];
    NSDictionary *dict = NextArr[NextArr.count-i];
    [self zuijinManager:dict];
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        NSLog(@"---%@",responder.class);
        
        if ([responder isKindOfClass:[UIViewController class]]) {
            
            UIViewController *nav = (UIViewController *)responder;
            vc.dict = dict;
            [nav presentViewController:vc animated:YES completion:nil];
                
        }
    }


}
//最近的排序的判断
-(void)zuijinManager:(NSDictionary *)dic
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:ShaHeKey];
    [zuijinDatas addObjectsFromArray:arr];
    if (bols) {
        if (zuijinDatas.count>=7) {
            [zuijinDatas removeObjectAtIndex:0];
        }
        for (int i=0; i<zuijinDatas.count; i++) {
            NSDictionary *dics = zuijinDatas[i];
            if ([dic[@"name"] isEqualToString:dics[@"name"]]) {
                
                [zuijinDatas removeObjectAtIndex:i];
                NSLog(@"最近的个数%ld",(unsigned long)NextArr.count);
            }
        }
        [zuijinDatas addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:zuijinDatas forKey:ShaHeKey];
        
    }else{
        if (NextArr.count>=7) {
            [NextArr removeObjectAtIndex:0];
        }
        for (int i=0; i<NextArr.count; i++) {
            NSDictionary *dics = NextArr[i];
            if ([dic[@"name"] isEqualToString:dics[@"name"]]) {
                
                [NextArr removeObjectAtIndex:i];
                NSLog(@"最近的个数%ld",(unsigned long)NextArr.count);
            }
            
            
        }
        
        [NextArr addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:NextArr forKey:ShaHeKey];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
