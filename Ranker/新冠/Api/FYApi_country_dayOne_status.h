//
//  FYApi_country_dayOne_status.h
//  Ranker
//
//  Created by riceFun on 2020/11/12.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,FYApi_status) {
    FYApi_status_confirmed = 0,
    FYApi_status_deaths,
    FYApi_status_recovered,
    FYApi_status_active
};

@interface FYApi_country_dayOne_status : YTKRequest
- (instancetype)initWithCountry:(NSString *)country status:(FYApi_status)status;

@end

NS_ASSUME_NONNULL_END
