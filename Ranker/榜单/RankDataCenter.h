//
//  RankDataCenter.h
//  Ranker
//
//  Created by riceFun on 2020/10/26.
//

#import <Foundation/Foundation.h>
#import "RankApi.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(NSArray *dataArra, NSDictionary * _Nullable context);
typedef void(^FailBlock)(NSDictionary *context);

@interface RankDataCenter : NSObject

+ (RankDataCenter *)sharedInstance;
- (void)queryRankDataWithTimeType:(Api_period)timetype platform:(Api_platform)platform category:(Api_category)category successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

#pragma mark data save&&query
+ (void)saveDataToLocalWithArray:(NSArray *)array;
+ (NSArray *)queryDataFromLocal;

#pragma mark data sort
+ (NSArray *)sortWithDataArray:(NSArray *)dataArray top:(int)top;

//更换头像  由于有些头像的地址已经无效这里取最新的头像
+ (NSArray *)updateModelAvatar:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
