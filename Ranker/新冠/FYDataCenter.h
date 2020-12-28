//
//  FYDataCenter.h
//  Ranker
//
//  Created by riceFun on 2020/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYDataCenter : NSObject
+ (FYDataCenter *)sharedInstance;

- (void)queryCountries;
- (void)queryCountriesDayOne;
@end

NS_ASSUME_NONNULL_END
