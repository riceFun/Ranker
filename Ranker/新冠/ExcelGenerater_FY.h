//
//  ExcelGenerater_FY.h
//  Ranker
//
//  Created by riceFun on 2020/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExcelGenerater_FY : NSObject
+ (ExcelGenerater_FY *)sharedInstance ;
//直接生成excel
- (void)generateWithArray:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
