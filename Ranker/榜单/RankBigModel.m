//
//  RankBigModel.m
//  Ranker
//
//  Created by riceFun on 2020/10/25.
//

#import "RankBigModel.h"

@implementation RankBigModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : RankModel.class};
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_limit forKey:@"limit"];
    [coder encodeObject:_list forKey:@"list"];
    [coder encodeObject:_show forKey:@"show"];
    [coder encodeObject:_total forKey:@"total"];
    [coder encodeObject:_updated forKey:@"updated"];
    [coder encodeObject:_timeType forKey:@"timeType"];
    
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _limit = [coder decodeObjectForKey:@"limit"];
        _list = [coder decodeObjectForKey:@"list"];
        _show = [coder decodeObjectForKey:@"show"];
        _total = [coder decodeObjectForKey:@"total"];
        _updated = [coder decodeObjectForKey:@"updated"];
        _timeType = [coder decodeObjectForKey:@"timeType"];
    }
    return self;
}


@end
