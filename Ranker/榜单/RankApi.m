//
//  RankApi.m
//  Ranker
//
//  Created by riceFun on 2020/10/21.
//

#import "RankApi.h"

#define K_baseUrl @"http://www.starrank.com/api/v2/rank/author"

@interface RankApi()
@property (nonatomic,copy) NSString *platform;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,assign) NSNumber *pt;
@property (nonatomic,copy) NSString *period;
@property (nonatomic,assign) NSNumber *page;
@property (nonatomic,copy) NSString *starTime;
 
@end

@implementation RankApi

- (id)initWithTime:(NSNumber *)time platform:(Api_platform)platform category:(Api_category)category period:(Api_period)period page:(NSNumber *)page {
    if (self = [super init]) {
        _pt = time;
        _platform = [RankApi _pApi_platform:platform];
        _category = [RankApi _pApi_category:category];
        _period = [RankApi _pApi_period:period];
        _page = page;
//        _starTime =
    }
    return self;
}

- (NSString *)requestUrl {
    //在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return K_baseUrl;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


- (id)requestArgument {
    return @{
        @"platform": _platform,
        @"category":_category,
        @"pt":_pt,
        @"period":_period,
        @"page":_page
    };
}

+ (NSString *)_pApi_platform:(Api_platform)platform {
    switch (platform) {
        case Api_platform_douyin:
            return @"douyin";
            break;
        case Api_platform_kuaishou:
            return @"kuaishou";
            break;
        case Api_platform_bilibili:
            return @"bilibili";
            break;
        case Api_platform_meipai:
            return @"meipai";
            break;
        case Api_platform_xigua:
            return @"xigua";
            break;
        default:
            return @"douyin";
            break;
    }
}

+ (NSString *)_pApi_category:(Api_category)category {    
    switch (category) {
        case Api_category_不限:
            return @"不限";
            break;
        case Api_category_颜值:
            return @"颜值";
            break;
        case Api_category_搞笑段子:
            return @"搞笑段子";
            break;
        case Api_category_音乐:
            return @"音乐";
            break;
        case Api_category_舞蹈:
            return @"舞蹈";
            break;
        case Api_category_宠物:
            return @"宠物";
            break;
        case Api_category_美食:
            return @"美食";
            break;
        case Api_category_美妆:
            return @"美妆";
            break;
        case Api_category_游戏:
            return @"游戏";
            break;
        case Api_category_情感:
            return @"情感";
            break;
        case Api_category_运动:
            return @"运动";
            break;
        case Api_category_旅行:
            return @"旅行";
            break;
        case Api_category_亲子:
            return @"亲子";
            break;
        case Api_category_时尚:
            return @"时尚";
            break;
        case Api_category_VLOG:
            return @"VLOG";
            break;
        case Api_category_科技数码:
            return @"科技数码";
            break;
        case Api_category_教育:
            return @"教育";
            break;
        case Api_category_汽车:
            return @"汽车";
            break;
        case Api_category_生活方式:
            return @"生活方式";
            break;
        case Api_category_政务:
            return @"政务";
            break;
        case Api_category_文化艺术:
            return @"文化艺术";
            break;
        case Api_category_影视:
            return @"影视";
            break;
        case Api_category_明星:
            return @"明星";
            break;
        case Api_category_特效:
            return @"特效";
            break;
        case Api_category_家具家装:
            return @"家具家装";
            break;
        case Api_category_科普:
            return @"科普";
            break;
        case Api_category_二次元:
            return @"二次元";
            break;
        case Api_category_三农:
            return @"三农";
            break;
        default:
            return @"不限";
            break;
    }
}

+ (NSString *)_pApi_period:(Api_period)period {
    switch (period) {
        case Api_period_week:
            return @"week";
            break;
        case Api_period_month:
            return @"month";
            break;
        default:
            return @"month";
            break;
    }
}








@end
