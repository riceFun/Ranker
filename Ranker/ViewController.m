//
//  ViewController.m
//  Ranker
//
//  Created by riceFun on 2020/10/21.
//

#import "ViewController.h"
#import <YTKNetwork/YTKNetwork.h>
#import <YYModel/YYModel.h>
#import <SDWebImage/SDWebImage.h>
#import "RankApi.h"
#import "RankBigModel.h"
#import "RankDataCenter.h"
#import "ExcelGenerater.h"

#import "RankViewController.h"
#import "FYViewController.h"

#import "FYDataCenter.h"



#define K_ScreenFrame [[UIScreen mainScreen] bounds]
#define K_ScreenWidth K_ScreenFrame.size.width
#define K_ScreenHeight K_ScreenFrame.size.height

//颜色
#define K_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]      // RGB颜色值（带透明度）
#define K_RGB(r,g,b) K_RGBA(r,g,b,1.0f)     // RGB颜色值（不透明
#define K_Color_MainBg K_RGB(242, 242, 242) //主背景颜色

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.tableView];
//    [self _configData];
    
//    [FYCountryCode handle];
    
    [[FYDataCenter sharedInstance] queryCountries];

//    [[FYDataCenter sharedInstance] queryCountriesDayOne];
    
}

- (void)_configData {
    self.dataArray = @[@"榜单",@"新冠"];
}

#pragma mark lazyload
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, K_ScreenWidth, K_ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = K_Color_MainBg;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kkk"];
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kkk" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"kkk"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[RankViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[FYViewController new] animated:YES];
    }
    
    
}


@end
