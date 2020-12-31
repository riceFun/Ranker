//
//  ExcelGenerater_FY.h
//  Ranker
//
//  Created by riceFun on 2020/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ExcelGenerater_FYType) {
    ExcelGenerater_FYType_Confirmed,//确诊数
    ExcelGenerater_FYType_Death//死亡数
};


@interface ExcelGenerater_FY : NSObject
+ (ExcelGenerater_FY *)sharedInstance ;
//直接生成excel
- (void)generateWithArray:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
