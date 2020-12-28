//
//  FYCountryDayOneAll.m
//  Ranker
//
//  Created by riceFun on 2020/11/12.
//

#import "FYCountryDayOneAll.h"
//#import "FYDataCenter.h"
//#import "FYCountry.h"

@implementation FYCountryDayOneAll

- (void)setCountry:(NSString *)Country {
    _Country = Country;
}

- (void)setCountryCode:(NSString *)CountryCode {
    _CountryCode = CountryCode;
//    if (CountryCode) {
//        FYCountryOtherData *OtherData = [FYDataCenter sharedInstance].countryOtherDataDic[CountryCode];
//        _name_chinese = OtherData.name_chinese;
//        _name_english = OtherData.name_english;
//    }
}

- (void)setDate:(NSString *)Date {
    _Date = Date;
    if (Date.length > 10) {
        //2020-01-22T00:00:00Z => 2020-01-22
        _Date_short = [Date substringWithRange:NSMakeRange(0, 10)];
    }
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_Country forKey:@"Country"];
    [coder encodeObject:_CountryCode forKey:@"CountryCode"];
    [coder encodeObject:_City forKey:@"City"];
    [coder encodeObject:_CityCode forKey:@"CityCode"];
    [coder encodeObject:_Lat forKey:@"Lat"];
    [coder encodeObject:_Lon forKey:@"Lon"];
    [coder encodeObject:_Confirmed forKey:@"Confirmed"];
    [coder encodeObject:_Deaths forKey:@"Deaths"];
    [coder encodeObject:_Active forKey:@"Active"];
    [coder encodeObject:_Date forKey:@"Date"];
    [coder encodeObject:_Date_short forKey:@"Date_short"];
    [coder encodeObject:_name_chinese forKey:@"name_chinese"];
    [coder encodeObject:_name_english forKey:@"name_english"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _Country = [coder decodeObjectForKey:@"Country"];
        _CountryCode = [coder decodeObjectForKey:@"CountryCode"];
        _City = [coder decodeObjectForKey:@"City"];
        _CityCode = [coder decodeObjectForKey:@"CityCode"];
        _Lat = [coder decodeObjectForKey:@"Lat"];
        _Lon = [coder decodeObjectForKey:@"Lon"];
        _Confirmed = [coder decodeObjectForKey:@"Confirmed"];
        _Deaths = [coder decodeObjectForKey:@"Deaths"];
        _Active = [coder decodeObjectForKey:@"Active"];
        _Date = [coder decodeObjectForKey:@"Date"];
        _Date_short = [coder decodeObjectForKey:@"Date_short"];
        _name_chinese = [coder decodeObjectForKey:@"name_chinese"];
        _name_english = [coder decodeObjectForKey:@"name_english"];
    }
    return self;
}

@end
