

//
//  RankViewController.m
//  Ranker
//
//  Created by riceFun on 2020/10/21.
//

#import "RankViewController.h"
#import <YTKNetwork/YTKNetwork.h>
#import <YYModel/YYModel.h>
#import <SDWebImage/SDWebImage.h>
#import "RankApi.h"
#import "RankBigModel.h"
#import "RankDataCenter.h"
#import "ExcelGenerater.h"


#define K_ScreenFrame [[UIScreen mainScreen] bounds]
#define K_ScreenWidth K_ScreenFrame.size.width
#define K_ScreenHeight K_ScreenFrame.size.height

//颜色
#define K_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]      // RGB颜色值（带透明度）
#define K_RGB(r,g,b) K_RGBA(r,g,b,1.0f)     // RGB颜色值（不透明
#define K_Color_MainBg K_RGB(242, 242, 242) //主背景颜色

@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *totalRank;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"榜单";
    
    [self.view addSubview:self.tableView];
    //1. 先打开这个  下载数据
//    [self _queryNetData];
    //2.关闭上面的再打开这个
    [self _generatorExcel];
}

- (void)_generatorExcel {
    NSArray *localDataArray = [RankDataCenter queryDataFromLocal];
    localDataArray = [RankDataCenter updateModelAvatar:localDataArray];
    
    //数组反转
    NSArray *dataArray = [[localDataArray reverseObjectEnumerator] allObjects];
    [[ExcelGenerater sharedInstance] generateWithDataArray:dataArray top:10];
}

- (void)_queryData {
    //    self.totalRank = [RankDataCenter queryDataFromLocal];
    //    if (self.totalRank.count > 0) {
    //        [self sort];
    //        [self.tableView reloadData];
    //    } else {
    [self _queryNetData];
//        }
}

- (void)_queryNetData {
    [[RankDataCenter sharedInstance] queryRankDataWithTimeType:Api_period_month platform:Api_platform_xigua category:Api_category_不限 successBlock:^(NSArray * _Nonnull dataArra, NSDictionary * _Nonnull context) {
        self.totalRank = dataArra;
        [self sort];
        [self.tableView reloadData];
    } failBlock:^(NSDictionary * _Nonnull context) {
    }];
}

#pragma mark lazyload
-(UITableView*)tableView{
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
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.totalRank.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kkk"];
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kkk" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"kkk"];
    }
    
    RankBigModel *bigModel = self.totalRank[indexPath.section];
    RankModel *model = bigModel.list[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.textLabel.text = [NSString stringWithFormat:@"排名 %ld %@",indexPath.row+1,model.name];
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"粉丝数： %@ 点赞数：@",model.fans ,model.];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"粉丝数： %@",model.fans ];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    RankBigModel *bigModel = self.totalRank[section];
    return  [NSString stringWithFormat:@"%@",bigModel.updated];
}

- (void)sort{
    for (RankBigModel *bigModel in self.totalRank) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:[bigModel.list copy]];
        
        [temp sortUsingComparator:^NSComparisonResult(RankModel *obj1, RankModel *obj2) {
            return [obj2.fans compare:obj1.fans];
        }];
        bigModel.list = [temp copy];
    }
}





@end

