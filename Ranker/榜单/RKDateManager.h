//
//  RKDateManager.h
//  Ranker
//
//  Created by riceFun on 2020/11/2.
//

#import <Foundation/Foundation.h>
#import "RankApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RKDateManager : NSObject

+ (NSString *)dateWithType:(Api_period)type;
+ (void)reset;
@end

NS_ASSUME_NONNULL_END
