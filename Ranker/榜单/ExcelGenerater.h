//
//  ExcelGenerater.h
//  Ranker
//
//  Created by riceFun on 2020/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExcelGenerater : NSObject
+ (ExcelGenerater *)sharedInstance;
//取前几的数据生成excel
- (void)generateWithDataArray:(NSArray *)dataArray top:(int)top;
- (void)generateWithArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
