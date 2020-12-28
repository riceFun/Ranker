//
//  RankBigModel.h
//  Ranker
//
//  Created by riceFun on 2020/10/25.
//

#import <Foundation/Foundation.h>
#import "RankModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface RankBigModel : NSObject<NSCoding>

@property (nonatomic,assign) NSNumber *limit;
@property (nonatomic,copy) NSArray<RankModel *> *list;
@property (nonatomic,copy) NSString *show;
@property (nonatomic,assign) NSNumber *total;
@property (nonatomic,assign) NSNumber *updated;

@property (nonatomic,copy) NSString *timeType;//self add; only  month or week; 

@end

//limit = 100;
//list =     (
//
//);
//show = "<null>";
//total = 100;
//updated = 202009;

NS_ASSUME_NONNULL_END
