//
//  FYDataCenter.m
//  Ranker
//
//  Created by riceFun on 2020/11/11.
//

//Attempting to store >= 4194304 bytes of data in CFPreferences/NSUserDefaults on this platform is invalid. This is a bug in Ranker or a library it uses

#import "FYDataCenter.h"
#import "FYApi_country.h"
#import "FYApi_country_dayOne_all.h"
#import "FYApi_country_dayOne_status.h"
#import "FYApi_country_dayOne_china.h"


#import <YYModel/YYModel.h>
#import "FYCountry.h"
#import "FYCountryDayOneAll.h"
#import "FYCountryDayOneChina.h"

#import "ExcelGenerater_FY.h"

@interface FYDataCenter()
@property (nonatomic,strong) NSArray *countries;//所有国家 数组形式
@property (nonatomic,strong) NSMutableDictionary *mDicCountry;// 所有国家 dic形式 便于查找

@property (nonatomic,strong) NSMutableDictionary *mDicDayOneAllCountryFYData;//网络请求后得到dayone结果
@property (nonatomic,strong) NSArray *pDayOneArray;//最终数据
@property (nonatomic,strong) NSArray *onlyChinaDayOneArray;//只要中国的数据

@property (nonatomic,strong) NSDictionary *exceptDic;
@property (nonatomic,strong) NSDictionary *courntryOtherDataDic;

@property (nonatomic,assign) NSInteger endInt;//用于判断某一轮for in 请求是否全部都完成 （成功加失败）
@property (nonatomic,strong) NSMutableArray *mArrayRemain;//剩余未请求的国家；

@end

@implementation FYDataCenter

+ (FYDataCenter *)sharedInstance {
    static FYDataCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FYDataCenter alloc]init];
    });
    return instance;
}

- (void)queryCountries {
    NSArray *countrys = [FYDataCenter queryCountrysFromLocal];
    if (countrys) {
        self.countries = countrys;
        //1.先请求这个  完成后
//        [self _pQueryAllDataWithCountries:self.countries isFirst:YES];
//        2. 重启应用 请求这个
        [self _queryChinaDayOne];
    } else {
        K_Weakself
        FYApi_country *api = [[FYApi_country alloc] init];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            if (request.responseObject == nil) {
                return;
            }
            K_Strongself
            NSArray *responseObjectArray = (NSArray *)request.responseObject;
            NSArray *countrys = [NSArray yy_modelArrayWithClass:[FYCountry class] json:responseObjectArray];
            //除去请求不到的数据 非常重要
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (FYCountry *country in countrys) {
                if (strongSelf.exceptDic[country.Slug]) {
                } else {
                    [mutableArray addObject:country];
                }
            }
            strongSelf.countries = countrys = [mutableArray copy];
            //存到本地
            [FYDataCenter saveCountrysToLocalWithArray:[countrys copy]];
            
//            [self _queryChinaDayOne];
            NSLog(@"国家 请求成功");
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"国家 请求失败");
            K_Strongself
            [strongSelf queryCountries];
        }];
    }
}

- (void)queryCountriesDayOne {
    FYApi_country_dayOne_all *api = [[FYApi_country_dayOne_all alloc] initWithCountry:@"saint-barthélemy"];//united-states  saint-barthélemy china
    //    FYApi_country_dayOne_status *api = [[FYApi_country_dayOne_status alloc] initWithCountry:@"united-states" status:FYApi_status_confirmed];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request.responseObject == nil) {
            return;
        }
        NSArray *responseObjectArray = (NSArray *)request.responseObject;
        NSArray *CountryDayOneAll = [NSArray yy_modelArrayWithClass:[FYCountryDayOneAll class] json:responseObjectArray];
        NSLog(@"国家 请求成功");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"国家每日数据 请求失败");
    }];
}

- (void)_queryChinaDayOne {
    K_Weakself
    FYApi_country_dayOne_china *api = [[FYApi_country_dayOne_china alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request.responseObject == nil ) {
            return;
        }
        
        K_Strongself
        NSDictionary *repsoneDic = request.responseObject;
        NSDictionary *dataDic = repsoneDic[@"data"];
        NSArray *dayOneList = dataDic[@"chinaDayList"];
        
        strongSelf.onlyChinaDayOneArray = [NSArray yy_modelArrayWithClass:[FYCountryDayOneChina class] json:dayOneList];
        [strongSelf _queryDayOne];
        NSLog(@"中国每日 请求成功");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"国家每日数据 请求失败");
    }];
}

//- (void)_handleCoutrys:(NSArray *)counrtyArray {
//    //用国家的名字作为 key 将 counrtyArray 转化为 countrDic，后面在请求完成所有数据后，将 中文 英文 国旗 等数据写到 FYCountryDayOneAll 中
//    for (FYCountry *country in counrtyArray) {
//        _mDicCountry[country.Country] = country;
//    }
//
//    [self _pQueryAllDataWithCountries:counrtyArray];
//}



- (void)_queryDayOne {
    NSMutableDictionary *mlocalDataDic = [NSMutableDictionary dictionaryWithDictionary:[FYDataCenter queryDayOneFromLocal]];
    if (mlocalDataDic == nil) {
        return;
    }
    
    NSArray *chinaArray = mlocalDataDic[@"CN"];
    if (chinaArray.count == 0) {
        return;
    }
    
    NSMutableArray *mArrayChina = [NSMutableArray array];
    FYCountryDayOneAll *dayOnedata = chinaArray[0];
    for (FYCountryDayOneChina *chinaDayone in self.onlyChinaDayOneArray) {
        FYCountryDayOneAll *subDayOne = [[FYCountryDayOneAll alloc] init];
//        subDayOne = dayOnedata;
        subDayOne.Country = @"China";
        subDayOne.Date =  [NSString stringWithFormat:@"%@T00:00:00Z",chinaDayone.date];
        subDayOne.Date_short = chinaDayone.date;
        subDayOne.Active = chinaDayone.total.heal;
        subDayOne.Confirmed = chinaDayone.total.confirm;
        subDayOne.Deaths = chinaDayone.total.dead;
        [mArrayChina addObject:subDayOne];
    }
    mlocalDataDic[@"CN"] = [mArrayChina copy];
    NSDictionary *localDataDic = [mlocalDataDic copy];
    
    if (localDataDic) {
        //先赋值 mDicCountry
        for (FYCountry *country in self.countries) {
            self.mDicCountry[country.Country] = country;
        }
        
        NSMutableArray *mArray = [NSMutableArray array];
        // 处理本地数据  例如加上中文和国旗
        // 遍历dayonedic 获取每个国家dayone 数组
        for (NSString *key in localDataDic) {//key is country.Slug
            //获取每个国家dayone 数组
            NSArray *countryOneDayArray = localDataDic[key];
            if (countryOneDayArray.count == 0) {
                //这个国家没有Day数据
                continue;
            }
            for (FYCountryDayOneAll *dayOnedata in countryOneDayArray) {
                FYCountry *country = self.mDicCountry[dayOnedata.Country];
                if (country) {
                    dayOnedata.Flag = country.Flag;
                    dayOnedata.ISO2 = country.ISO2;
                    FYCountryOtherData *otherData = self.courntryOtherDataDic[country.ISO2];
                    if (otherData) {
                        dayOnedata.name_chinese = otherData.name_chinese;
                        dayOnedata.name_english = otherData.name_english;
                    }
                }
            }
            [mArray addObject:countryOneDayArray];
        }
        self.pDayOneArray = [mArray copy];
        [[ExcelGenerater_FY sharedInstance] generateWithArray:self.pDayOneArray];
    } else {
        //请求网络数据
        [self _pQueryAllDataWithCountries:self.countries isFirst:YES];
    }
}

- (void)_pQueryAllDataWithCountries:(NSArray *)counrtyArray isFirst:(BOOL)isFirst {
    //加上isFirst 判断是否是递归调用。外面第一次调用时
    if (counrtyArray.count == 0 && isFirst == NO) {
        //NSLog(@"国家为空");
        NSLog(@"全部请求结束");
        [FYDataCenter saveDayOneToLocalWithDic:[self.mDicDayOneAllCountryFYData copy]];
        return;
    }
    
    if (counrtyArray.count == 0) {
        NSLog(@"第一次请求 counrtyArray 数据为空");
        return;
    }
    
    self.mArrayRemain = [NSMutableArray arrayWithArray:counrtyArray];
    self.endInt = self.mArrayRemain.count;
    
    //并发队列 同时请求多个http任务
    dispatch_queue_t concurrent_queue = dispatch_queue_create("Dan——CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < self.mArrayRemain.count ; i++) {
        FYCountry *country = self.mArrayRemain[i];
        //先排除一些不支持的 国家
        if (self.exceptDic[country.Slug]) {
            @synchronized (self) {
                [self.mArrayRemain removeObject:country];
                self.endInt --;
                NSLog(@"endInt = %ld  exceptDic",(long)self.endInt);
            }
            continue;
        }
        
        //从 mArrayDayOneAllCountry 找那个查下有没有这个国家的数据，有的话就不再请求
        if (self.mDicDayOneAllCountryFYData[country.ISO2]) {
            @synchronized (self) {
                [self.mArrayRemain removeObject:country];
                self.endInt --;
                NSLog(@"endInt = %ld  mDicDayOneAllCountryFYData",(long)self.endInt);
            }
            continue;
        }
        
        dispatch_async(concurrent_queue, ^{
            K_Weakself
            FYApi_country_dayOne_all *api = [[FYApi_country_dayOne_all alloc] initWithCountry:country.Slug];
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                K_Strongself
                if (request.responseObject == nil) {
                    return;
                }
                NSArray *responseObjectArray = (NSArray *)request.responseObject;
                NSArray *CountryDayOneAll = [NSArray yy_modelArrayWithClass:[FYCountryDayOneAll class] json:responseObjectArray];
                
                //将当前国家的数据 用字典的形式存起来
                strongSelf.mDicDayOneAllCountryFYData[country.ISO2] = CountryDayOneAll;
                NSLog(@"成功 --       %3d - %@",i,country.Slug);
                @synchronized (strongSelf) {
                    [strongSelf.mArrayRemain removeObject:country];
                    strongSelf.endInt --;
                    NSLog(@"endInt = %ld",(long)strongSelf.endInt);
                }
                
                if (strongSelf.endInt <= 0) {
                    NSLog(@"本轮请求结束");
                    //重新再请求一次
                    [strongSelf _pQueryAllDataWithCountries:strongSelf.mArrayRemain isFirst:NO];
                }
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                NSLog(@"失败 --       %3d - %@",i,country.Slug);
                K_Strongself
                @synchronized (strongSelf) {
                    strongSelf.endInt --;
                    NSLog(@"endInt = %ld",(long)strongSelf.endInt);
                }
                if (strongSelf.endInt <= 0) {
                    NSLog(@"本轮请求结束");
                    //重新再请求一次
                    [strongSelf _pQueryAllDataWithCountries:strongSelf.mArrayRemain isFirst:NO];
                }
            }];
        });
    }
}

- (void)_forinQueryCountriesDayOneWithCountrySlug:(NSString *)Slug currentIndex:(int)currentIndex {
    K_Weakself
    FYApi_country_dayOne_all *api = [[FYApi_country_dayOne_all alloc] initWithCountry:Slug];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        K_Strongself
        if (request.responseObject == nil) {
            return;
        }
        NSArray *responseObjectArray = (NSArray *)request.responseObject;
        NSArray *CountryDayOneAll = [NSArray yy_modelArrayWithClass:[FYCountryDayOneAll class] json:responseObjectArray];
        
        NSLog(@"第%d请求成功",currentIndex);
        //            NSLog(@"国家 请求成功");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"国家每日数据 请求失败,currentIndex");
    }];
    
    //    for (FYCountry *country in _countries) {
    //        FYApi_country_dayOne_all *api = [[FYApi_country_dayOne_all alloc] initWithCountry:country.Country];
    //        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
    //            if (request.responseObject == nil) {
    //                return;
    //            }
    //            NSArray *responseObjectArray = (NSArray *)request.responseObject;
    //            NSArray *CountryDayOneAll = [NSArray yy_modelArrayWithClass:[FYCountryDayOneAll class] json:responseObjectArray];
    //            [_mArrayDayOneAllCountry addObject:CountryDayOneAll];
    //
    //
    //            NSLog(@"国家 请求成功");
    //        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    //            NSLog(@"国家每日数据 请求失败");
    //        }];
    //    }
    
    NSLog(@"结束");
}

+ (NSDictionary *)quearyCountryDic {
    return [FYDataCenter sharedInstance].mDicCountry;
}

#pragma mark 本地化
+ (void)saveDayOneToLocalWithDic:(NSDictionary *)dic{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"K_totalDayOne"];
}

+ (NSDictionary *)queryDayOneFromLocal {
    NSData *pdata = [[NSUserDefaults standardUserDefaults] valueForKey:@"K_totalDayOne"];
    if (pdata) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:pdata];
    }
    return nil;
}


+ (void)saveCountrysToLocalWithArray:(NSArray *)dataArray{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"K_totalCountry"];
}

+ (NSArray *)queryCountrysFromLocal {
    NSData *pdata = [[NSUserDefaults standardUserDefaults] valueForKey:@"K_totalCountry"];
    if (pdata) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:pdata];
    }
    return nil;
}

#pragma mark lazyload
- (NSDictionary *)exceptDic {
    if (!_exceptDic) {
        _exceptDic = @{
            @"saint-barthélemy":@"1",
            @"réunion":@"1",
        };
    }
    return _exceptDic;
}



- (NSDictionary *)courntryOtherDataDic {
    if (!_courntryOtherDataDic) {
        _courntryOtherDataDic = [FYCountryOtherData getCountryOtherData];
    }
    return _courntryOtherDataDic;
}

- (NSMutableDictionary *)mDicCountry {
    if (!_mDicCountry) {
        _mDicCountry = [NSMutableDictionary dictionary];
    }
    return _mDicCountry;
}

- (NSMutableDictionary *)mDicDayOneAllCountryFYData {
    if (!_mDicDayOneAllCountryFYData) {
        _mDicDayOneAllCountryFYData = [[NSMutableDictionary alloc] init];
    }
    return _mDicDayOneAllCountryFYData;
}

- (NSMutableArray *)mArrayRemain {
    if (!_mArrayRemain) {
        _mArrayRemain = [[NSMutableArray alloc] init];
    }
    return _mArrayRemain;
}



@end
