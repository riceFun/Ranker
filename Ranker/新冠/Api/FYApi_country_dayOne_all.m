//
//  FYApi_country_dayOne_all.m
//  Ranker
//
//  Created by riceFun on 2020/11/12.
//

#import "FYApi_country_dayOne_all.h"
@interface FYApi_country_dayOne_all()
@property (nonatomic,copy) NSString *country;

@end

@implementation FYApi_country_dayOne_all

- (instancetype)initWithCountry:(NSString *)country {
    if (self = [super init]) {
        _country = country;
    }
    return self;
}

- (NSString *)requestUrl {
    NSString *url = [NSString stringWithFormat:@"https://api.covid19api.com/total/dayone/country/%@",self.country];
    if (url == nil) {
        int a;
    }
    return url;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return nil;
}


@end
