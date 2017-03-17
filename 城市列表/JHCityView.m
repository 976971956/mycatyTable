//
//  JHCityView.m
//  城市列表
//
//  Created by 李贻佳 on 16/6/30.
//  Copyright © 2016年 jianghu. All rights reserved.
//

#import "JHCityView.h"
#import "JHHeader.h"


@interface JHCityView()
<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>
{
    UITableView *_table;
    BOOL _isSeach; //是否在搜索
    UISearchController *_search; //搜索控制器
    NSMutableArray *_dataArray;//搜索的数据
    NSMutableArray *_sectionData;//组头的数据
    NSMutableArray *array;//城市信息数据
    
    NSMutableArray *zuijinDatas;//最近数据
    NSMutableArray *remenDatas;//热门数据
    
}
//@property(nonatomic,weak)UITableView *table;
@end

@implementation JHCityView


+(JHCityView *)shardManager
{
    static JHCityView *jhcity = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        jhcity = [[self alloc] init];
    });
    return jhcity;
}
//重新刷新数据
-(void)relouDad
{
    [_table reloadData];
}
-(instancetype)initWithController:(UIViewController *)cotroller form:(CGRect)form
{
    if (self = [super initWithFrame:form]) {
       
        
        zuijinDatas = [NSMutableArray new];
        remenDatas = [NSMutableArray new];
        
        _dataArray = [NSMutableArray array];
        _sectionData = [NSMutableArray array];
        array = [NSMutableArray array];
        //        获取沙盒中的最近数据
        [self shaheDatas];
        [self initDatas];
        [self seach];
        [self initTableView];
        
    }
    return self;
}
-(void)shaheDatas
{
    [zuijinDatas removeAllObjects];
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:ShaHeKey];
    [zuijinDatas addObjectsFromArray:arr];
}
//创建Tableview
-(void)initTableView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, -35, WIDTH, 30)];
    lable.text = @"城市列表";
    lable.textAlignment = NSTextAlignmentCenter ;
    lable.font = [UIFont systemFontOfSize:20 weight:20];
    lable.textColor = [UIColor whiteColor];
    [self addSubview:lable];
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT-108) style:UITableViewStylePlain];
    _table.dataSource =self;
    _table.delegate =self;
    //        _table.tableHeaderView = _search.searchBar;
    
    [self addSubview:_search.searchBar];
    
    _table.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [self addSubview:_table];
    [_table registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"jianghu"];
    [_table registerClass:[ZJCell class] forCellReuseIdentifier:@"zuijin"];
    _table.sectionIndexBackgroundColor = COLOER(247, 247, 247, 1);//右边索引颜色

}
//搜索
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arrays = [NSMutableArray array];
    for (NSString *dict in _sectionData) {
        [arrays addObject:dict];
    }
    return arrays;
}
-(void)seach
{
    _search = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _search.dimsBackgroundDuringPresentation=NO;
    _search.delegate =self;
    
    _search.searchResultsUpdater=self;
    [_search.searchBar sizeToFit];//搜索框的一个固定大小
    _search.searchBar.placeholder = @"请输入城市名或或拼音";
    _search.searchBar.barTintColor = [UIColor colorWithRed:208/255.0 green:203/255.0 blue:201/255.0 alpha:1];//设置搜索框颜色
    _search.searchBar.showsCancelButton = NO;
    _dataArray = [[NSMutableArray alloc]init];
    
}

-(void)initDatas
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    
    NSError *error;
    NSArray *arrays = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    for (int i=0; i<7; i++) {
        NSDictionary *dict = arrays[i];
        [remenDatas addObject:dict];
    }
    if (error) {
        NSLog(@"%@",error);
    }
    NSMutableArray *Zongsj = [NSMutableArray array];
    
    NSString *luin = [[NSBundle mainBundle] pathForResource:@"MyPlist" ofType:@"plist"];
    
    NSMutableArray *date = [[NSMutableArray alloc] initWithContentsOfFile:luin];

    //    加入简拼
    NSMutableArray *DATA = [NSMutableArray array];
    for (NSDictionary *dict in date) {
        NSMutableDictionary *mutdic =[NSMutableDictionary dictionaryWithDictionary:dict];
        NSString *piny = [[self firstCharactor:dict[@"name"]]lowercaseString];
        [mutdic setObject:piny forKey:@"PY"];
        [DATA addObject:mutdic];
        
    }
    
    NSMutableArray *mutarr = [NSMutableArray arrayWithObjects:@"最近",@"热门",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    for (int j = 0; j<mutarr.count; j++) {
        NSMutableArray *mutArray = [NSMutableArray array];
        
        NSMutableDictionary *mutdict = [NSMutableDictionary dictionary];
        [mutdict setObject:mutarr[j] forKey:@"paixu"];
        char q = [mutarr[j] characterAtIndex:0];
        for (int i =0 ; i<DATA.count; i++) {
            NSDictionary *dict = DATA[i];
            char p = [dict[@"pinyin"] characterAtIndex:0];
            if (p == q+32) {
                [mutArray addObject:dict];
            }
        }
        [mutdict setObject:mutArray forKey:@"city"];
        [Zongsj addObject:mutdict];
    }
            NSArray*zhongshuju = [NSArray array];
    
            zhongshuju = Zongsj;
            NSString *lujin = [[NSBundle mainBundle] pathForResource:@"MyPlists" ofType:@"plist"];
            BOOL bol = [zhongshuju writeToFile:lujin atomically:YES];
            if (bol) {
                NSLog(@"写入成功");
            }else{
                NSLog(@"写入失败");
            }
    NSMutableArray *mut = [NSMutableArray array];
    for (NSDictionary *dict in Zongsj) {
        [_sectionData addObject:dict[@"paixu"]];
//        for (NSDictionary *dicts in dict[@"city"]) {
//            [mutarrs addObject:dicts];
//        }
        [mut addObject:dict[@"city"]];
    }
    array = mut;
    

}
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    NSArray *array = [pinYin componentsSeparatedByString:@" "];
    NSMutableString *mutstr =[NSMutableString string];
    for (NSString *str in array) {
        [mutstr appendString:[str substringToIndex:1]];
    }
    //获取并返回首字母
    return mutstr;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_isSeach) {
        return nil;
    }
    return _sectionData[section];
}
//设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (_isSeach) {
        return _dataArray.count;
        
    }else{
        if (section==0||section==1) {
            return 1;
        }
    }
    return [array[section] count];
}
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSeach) {
        return 1;
    }
    return _sectionData.count;
}
//设置行的宽度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSeach) {
        return 40;

    }else{
        if (indexPath.section==0||indexPath.section==1) {
            return 70;
        }
    }
    return 40;
}
//进入下一个界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NextViewController *vc = [[NextViewController alloc]init];

    if (_isSeach) {
        NSDictionary *dic = _dataArray[indexPath.row];
        [self zuijinManager:dic];
        vc.dict = dic;
    }else{
        if (indexPath.section==1||indexPath.section==0) {
        }else{
        NSDictionary *dic = array[indexPath.section][indexPath.row];
        
        [self zuijinManager:dic];
        vc.dict = dic;
        }
    }
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            
            UIViewController *nav = (UIViewController *)responder;
            if (_isSeach) {
                [_search dismissViewControllerAnimated:YES completion:nil];
                _isSeach= NO;
                
                [nav presentViewController:vc animated:YES completion:nil];
            }else{
                [nav presentViewController:vc animated:YES completion:nil];
                
            }
        }
    }
    
}
//最近的排序的判断
-(void)zuijinManager:(NSDictionary *)dic
{
    if (zuijinDatas.count>=6) {
        [zuijinDatas removeObjectAtIndex:0];
    }
    for (int i=0; i<zuijinDatas.count; i++) {
        NSDictionary *dics = zuijinDatas[i];
        if ([dic[@"name"] isEqualToString:dics[@"name"]]) {
            
            [zuijinDatas removeObjectAtIndex:i];
            NSLog(@"最近的个数%ld",(unsigned long)zuijinDatas.count);
        }
        
        
    }
    
    [zuijinDatas addObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:zuijinDatas forKey:ShaHeKey];

}
//主要部分。自定义继承UITableViewCell的类更改数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isSeach) {
        if (indexPath.section==0) {
            ZJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zuijin"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell setArray:zuijinDatas setInter:NO];
            return cell;
        }
        if(indexPath.section ==1){
            ZJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zuijin"];
            [self shaheDatas];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell setArray:remenDatas setInter:YES];
            return cell;
        }
    }
    
    CityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"jianghu"];
//    UIView *view1 = [[UIView alloc]init];
//    view1.backgroundColor =[UIColor yellowColor];
//    //    设置颜色。bag
//    cell.selectedBackgroundView =view1;
    //    获取对象的数据
    NSString *per =[NSString string];
    if (_isSeach) {
        per = _dataArray[indexPath.row][@"name"];
    }else{
        NSDictionary *dict = array[indexPath.section][indexPath.row];
        per = dict[@"name"];
    }
    cell.name.text =per;
    
    return cell;
}
//开关控制搜索，获取搜索数据
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

    NSLog(@"------");
    _isSeach = YES;
    NSString *searchstr =searchController.searchBar.text;
    searchstr = searchstr.lowercaseString;
    [_dataArray removeAllObjects];
    for (NSArray *dict in array) {
//        for (NSDictionary *dicts in dict) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinyin contains %@ or PY contains %@", searchstr, searchstr,searchstr];
        NSArray *arrar = [NSArray array];
            arrar = [dict filteredArrayUsingPredicate:predicate];
//        }
        [_dataArray addObjectsFromArray:arrar];
    }
    [_table reloadData];
}


//关闭搜索。返回原始数据深圳
-(void)didDismissSearchController:(UISearchController *)searchController
{
    _isSeach=NO;
    [_table reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;
}


@end
