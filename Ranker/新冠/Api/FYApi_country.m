//
//  FYApi_country.m
//  Ranker
//
//  Created by riceFun on 2020/11/11.
//

#import "FYApi_country.h"

@implementation FYApi_country

- (NSString *)requestUrl {
    return @"https://api.covid19api.com/countries";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


- (id)requestArgument {
    return nil;
}




@end
