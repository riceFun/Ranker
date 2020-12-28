//
//  FYApi_country_dayOne_status.m
//  Ranker
//
//  Created by riceFun on 2020/11/12.
//

#import "FYApi_country_dayOne_status.h"

@interface FYApi_country_dayOne_status()
@property (nonatomic,copy) NSString *country;
@property (nonatomic,assign) FYApi_status status;

@end

@implementation FYApi_country_dayOne_status

- (instancetype)initWithCountry:(NSString *)country status:(FYApi_status)status {
    if (self = [super init]) {
        _country = country;
_status = status;
    }
    return self;
}

- (NSString *)requestUrl {
    
    NSString *pStatus;
    switch (self.status) {
        case FYApi_status_confirmed:
            pStatus = @"confirmed";
            break;
        case FYApi_status_deaths:
            pStatus = @"deaths";
            break;
        case FYApi_status_recovered:
            pStatus = @"recovered";
            break;
       
        case FYApi_status_active:
            pStatus = @"active";
            break;
        default:
            pStatus = @"confirmed";
            break;
    }
    NSString *url = [NSString stringWithFormat:@"https://api.covid19api.com/dayone/country/%@/status/%@",self.country,pStatus];
    return url;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return nil;
}
@end
