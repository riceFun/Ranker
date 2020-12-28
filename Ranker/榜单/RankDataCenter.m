//
//  RankDataCenter.m
//  Ranker
//
//  Created by riceFun on 2020/10/26.
//

#import "RankDataCenter.h"
#import "RankApi.h"
#import "RankBigModel.h"
#import "RKDateManager.h"
#import <YYModel/YYModel.h>




@interface RankDataCenter()
@property (nonatomic,assign) Api_period timetype;
@property (nonatomic,assign) Api_platform platform;
@property (nonatomic,assign) Api_category category;

@property (nonatomic,copy) SuccessBlock successBlock;
@property (nonatomic,copy) FailBlock failBlock;

@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign) int currentTime;

@property (nonatomic,strong) NSMutableArray *totalRank;
@property (nonatomic,strong) RankBigModel *singleTimeRank;

@property (nonatomic,strong) NSDictionary *manualAvatarDic;

@end

@implementation RankDataCenter

+ (RankDataCenter *)sharedInstance {
    static RankDataCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RankDataCenter alloc]init];
        
        instance.currentPage = 1;
        instance.timetype = Api_period_week;
        instance.platform = Api_platform_douyin;
        instance.category = Api_category_不限;
        
        YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//        config.baseUrl = K_baseUrl;
    });
    return instance;
}

- (void)queryRankDataWithTimeType:(Api_period)timetype platform:(Api_platform)platform category:(Api_category)category successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock {
    self.timetype = timetype;
    self.platform = platform;
    self.category = category;
    
    //获取当前时间，每调用一次，日期就会-1
    [self _pCurrentTime];
    
    self.successBlock = successBlock;
    self.failBlock = failBlock;
    
    [self _queryRankData];
}

- (void)_pCurrentTime {
    _currentTime = [[RKDateManager dateWithType:self.timetype] intValue];
    //    NSLog(@"llll,%d",_currentTime);
}

- (void)_queryRankData {
    NSNumber *timeNumber = [NSNumber numberWithInt:_currentTime];
    NSLog(@"time:%d,page:%d",_currentTime,_currentPage);
    RankApi *api = [[RankApi alloc] initWithTime:timeNumber platform:self.platform category:self.category period:self.timetype page:[NSNumber numberWithInt:_currentPage]];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request.responseObject == nil) {
            return;
        }
        NSDictionary *responseObjectDic = (NSDictionary *)request.responseObject;
        NSNumber *code = (NSNumber *)responseObjectDic[@"code"];
        
        if (code != [NSNumber numberWithLong:0]) {
            NSLog(@"code = 0");
            return;
        }
        
        RankBigModel *bigModel = [RankBigModel yy_modelWithJSON:responseObjectDic[@"data"]];
        if (bigModel.list.count == 0) {
            //下一个日期
            if (self.singleTimeRank) {
                [self.totalRank addObject:self.singleTimeRank];
                self.singleTimeRank = nil;
            }
            
            
//            int endtime = 202035;
            int endtime = 201803;
            if (self->_currentTime < endtime) {
                if (self.totalRank.count > 0) {
                    [RankDataCenter saveDataToLocalWithArray:[self.totalRank copy]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.successBlock([self.totalRank copy], nil);
                    NSLog(@"全部数据已加载，请求结束");
                });
                return;
            }
            
            [self _pCurrentTime];//time - 1
            self.currentPage = 1;
            [self _queryRankData];
        }
        else {
            NSMutableArray *tempRank = [NSMutableArray arrayWithArray:self.singleTimeRank.list];
            [tempRank addObjectsFromArray:bigModel.list];
            self.singleTimeRank = bigModel;
            self.singleTimeRank.list = [tempRank copy];
            
            self.currentPage += 1;
            [self _queryRankData];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (self.totalRank.count > 0) {
            [RankDataCenter saveDataToLocalWithArray:[self.totalRank copy]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successBlock([self.totalRank copy], nil);
            NSLog(@"全部数据已失败，请求结束");
        });
        NSLog(@"请求失败");
    }];
}


#pragma mark data save&&query
+ (void)saveDataToLocalWithArray:(NSArray *)array{
    NSData *dataArray = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"K_totalRank"];
}

+ (NSArray *)queryDataFromLocal {
    NSData *pdata = [[NSUserDefaults standardUserDefaults] valueForKey:@"K_totalRank"];
    if (pdata) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:pdata];
    }
    return nil;
}

#pragma mark data sort
+ (NSArray *)sortWithDataArray:(NSArray *)dataArray top:(int)top {
    if (dataArray == nil) {
        NSLog(@"数据为空 不能排序");
        return nil;
    }
    
    if (top == 0) {
        top = INT_MAX;
    }
    
    for (RankBigModel *bigModel in dataArray) {
        //内部数据数量小于 top量,直接不排列
        if (bigModel.list.count <= top) {
            //跳出本次循环
            continue;
        }
        
        NSMutableArray *temp = [NSMutableArray arrayWithArray:[bigModel.list copy]];
        [temp sortUsingComparator:^NSComparisonResult(RankModel *obj1, RankModel *obj2) {
            return [obj2.fans compare:obj1.fans];
        }];
        bigModel.list = [[temp subarrayWithRange: NSMakeRange(0, top)] copy];
    }
    return dataArray;
}

//更换头像  由于有些头像的地址已经无效这里取最新的头像
+ (NSArray *)updateModelAvatar:(NSArray *)dataArray {
    NSMutableDictionary *mDic_avatar = [NSMutableDictionary dictionaryWithCapacity:100];
    for (RankBigModel *bigModel in dataArray) {
        for (RankModel *model in bigModel.list) {
            
            //这个地址的图片是打不开的
            if ([model.avatar hasPrefix:@"http://1zhen-picture"]) {
                if ([RankDataCenter sharedInstance].manualAvatarDic[model.name]) {
                    model.avatar = [RankDataCenter sharedInstance].manualAvatarDic[model.name];
                    continue;
                }
            }
            
            if (mDic_avatar[model.author_id] == nil) {
                mDic_avatar[model.author_id] = model.avatar;
            } else {
                model.avatar = mDic_avatar[model.author_id];
            }
        }
    }
    
    return dataArray;
}


//+ (NSDictionary *)manualChangeAvatarWithAccountName:(NSString *)accountName {
//    NSDictionary
//}

#pragma mark lazyload
- (NSMutableArray *)totalRank {
    if (!_totalRank) {
        _totalRank = [NSMutableArray arrayWithCapacity:5];
    }
    return _totalRank;
}

- (NSDictionary *)manualAvatarDic {
    if (!_manualAvatarDic) {
        _manualAvatarDic = @{
            @"张欣尧":@"https://p6-dy-ipv6.byteimg.com/aweme/720x720/2f72100058a7ffe0a4eb9.jpeg?from=4010531038",
            @"大头大头下雨不愁":@"https://p3-dy-ipv6.byteimg.com/aweme/720x720/38cc000f77bcb49ef7f2.jpeg?from=4010531038",
            @"天天笑园":@"https://p3-dy-ipv6.byteimg.com/tos-cn-avt-0015/4ecba308425d340fed3d17b90fa91de6~tplv-dy-shrink:188:188.jpeg?from=2956013662&s=PackSourceEnum_USER_PROFILE&se=true&sh=188_188&sc=avatar&l=202011071252040102040560122B4C6B6F",
            @"裴佳欣":@"https://p3-dy-ipv6.byteimg.com/aweme/720x720/23f8a0002bcc12cd1aa17.jpeg?from=4010531038",
            @"一婷呦you":@"http://img2.feigua.cn/aweme/720x720/1cae90002aa544ad83415.jpeg?from=4010531038-thumb",
            @"莉哥o3o":@"http://img2.feigua.cn/aweme/720x720/2f6d90003a44866af9c7f.jpeg?from=4010531038-thumb",
            @"何炅":@"http://img2.feigua.cn/aweme/720x720/6719002c9346c7840eaa.jpeg?from=4010531038-thumb",
        };
    }
    return _manualAvatarDic;
}

//    NSData *data = [NSPropertyListSerialization dataFromPropertyList:self.totalRank format:NSPropertyListBinaryFormat_v1_0 errorDescription:&error];
@end
