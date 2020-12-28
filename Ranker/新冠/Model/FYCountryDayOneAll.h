//
//  FYCountryDayOneAll.h
//  Ranker
//
//  Created by riceFun on 2020/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYCountryDayOneAll : NSObject
@property (nonatomic,copy) NSString *Country;
@property (nonatomic,copy) NSString *CountryCode;
@property (nonatomic,copy) NSString *City;
@property (nonatomic,copy) NSString *CityCode;
@property (nonatomic,copy) NSString *Lat;
@property (nonatomic,copy) NSString *Lon;
@property (nonatomic,copy) NSString *Confirmed;
@property (nonatomic,copy) NSString *Deaths;
@property (nonatomic,copy) NSString *Active;
@property (nonatomic,copy) NSString *Date;

@property (nonatomic,copy) NSString *Date_short;
@property (nonatomic,copy) NSString *name_chinese;
@property (nonatomic,copy) NSString *name_english;
@property (nonatomic,copy) NSString *Flag;
@property (nonatomic,copy) NSString *ISO2;//其实就是 CountryCode


@end

NS_ASSUME_NONNULL_END
