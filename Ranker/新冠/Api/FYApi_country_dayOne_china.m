//
//  FYApi_country_dayOne_china.m
//  Ranker
//
//  Created by riceFun on 2020/11/15.
//

#import "FYApi_country_dayOne_china.h"

@implementation FYApi_country_dayOne_china

- (NSString *)requestUrl {
    return @"https://c.m.163.com/ug/api/wuhan/app/data/list-total";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return nil;
}
@end
