//
//  FYCountryDayOneChina.h
//  Ranker
//
//  Created by riceFun on 2020/11/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Total;
@interface FYCountryDayOneChina : NSObject

@property (nonatomic,copy) NSString *date;
@property (nonatomic,strong) Total *total;
@end

@interface Total : NSObject

@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *confirm;
@property (nonatomic,copy) NSString *suspect;
@property (nonatomic,copy) NSString *heal;//恢复健康人数
@property (nonatomic,copy) NSString *dead;
@property (nonatomic,copy) NSString *severe;
@property (nonatomic,copy) NSString *input;
@property (nonatomic,copy) NSString *storeConfirm;

@end






/*
 date: "2020-03-12",
 today: {
 confirm: 11,
 suspect: 33,
 heal: 0,
 dead: 0,
 severe: null,
 storeConfirm: 0,
 input: 3
 },
 total: {
 confirm: 81003,
 suspect: 0,
 heal: 64216,
 dead: 3180,
 severe: null,
 input: 88,
 storeConfirm: 13607
 },
 extData: null,
 lastUpdateTime: null
 */


NS_ASSUME_NONNULL_END
