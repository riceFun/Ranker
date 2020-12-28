//
//  RankApi.h
//  Ranker
//
//  Created by riceFun on 2020/10/21.
//

#import <YTKNetwork/YTKNetwork.h>

typedef NS_ENUM(NSUInteger,Api_platform) {
    Api_platform_douyin = 0,
    Api_platform_kuaishou,
    Api_platform_bilibili,
    Api_platform_meipai,
    Api_platform_xigua
};

typedef NS_ENUM(NSUInteger,Api_category) {
    Api_category_不限 = 0,
    Api_category_颜值,
    Api_category_搞笑段子,
    Api_category_音乐,
    Api_category_舞蹈,
    Api_category_宠物,
    Api_category_美食,
    Api_category_美妆,
    Api_category_游戏,
    Api_category_情感,
    Api_category_运动,
    Api_category_旅行,
    Api_category_亲子,
    Api_category_时尚,
    Api_category_VLOG,
    Api_category_科技数码,
    Api_category_教育,
    Api_category_汽车,
    Api_category_生活方式,
    Api_category_政务,
    Api_category_文化艺术,
    Api_category_影视,
    Api_category_明星,
    Api_category_特效,
    Api_category_家具家装,
    Api_category_科普,
    Api_category_二次元,
    Api_category_三农
};

typedef NS_ENUM(NSUInteger,Api_period) {
    Api_period_month = 0,
    Api_period_week
};

NS_ASSUME_NONNULL_BEGIN

@interface RankApi : YTKRequest
- (id)initWithTime:(NSNumber *)time  platform:(Api_platform)platform category:(Api_category)category period:(Api_period)period page:(NSNumber *)page;


@end

NS_ASSUME_NONNULL_END
