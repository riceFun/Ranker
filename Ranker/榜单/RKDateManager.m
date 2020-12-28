//
//  RKDateManager.m
//  Ranker
//
//  Created by riceFun on 2020/11/2.
//

#import "RKDateManager.h"


@interface RKDateManager()
@property (nonatomic,assign) NSInteger monthType_year;
@property (nonatomic,assign) NSInteger monthType_month;

@property (nonatomic,assign) NSInteger weekType_year;
@property (nonatomic,assign) NSInteger weekType_week;

@property (nonatomic,assign) BOOL isFirst;

@end

@implementation RKDateManager

+ (NSString *)dateWithType:(Api_period)type {
    return [[RKDateManager sharedInstance] _dateWithType:type];
}

+ (void)reset {
    return [[RKDateManager sharedInstance] _resetDate];
}

+ (RKDateManager *)sharedInstance {
    static RKDateManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RKDateManager alloc]init];
        [instance _resetDate];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)_resetDate {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitMonth |NSCalendarUnitWeekOfYear| NSCalendarUnitYear fromDate:[[NSDate alloc] init]];
    _weekType_week = [components weekOfYear];
    _monthType_month = [components month];
    _weekType_year = self.monthType_year = [components year];
    _isFirst = YES;
    NSLog(@"week:%ld,month:%ld,year:%ld",(long)_weekType_week,(long)_monthType_month,(long)_monthType_year);
}

- (NSString *)_dateWithType:(Api_period)type {
    if (type == Api_period_month) {
        return [self _month];
    } else if (type == Api_period_week) {
        return [self _week];
    }
    return nil;
}

- (NSString *)_month {
    if (_isFirst == YES) {
        _isFirst = NO;
        return [NSString stringWithFormat:@"%ld%02ld",(long)_monthType_year,(long)_monthType_month];
    } else {
        _monthType_month -= 1;
        if (_monthType_month == 0) {
            _monthType_year -= 1;
            _monthType_month = 12;
            return [NSString stringWithFormat:@"%ld%02ld",(long)_monthType_year,(long)_monthType_month];
        } else {
            return [NSString stringWithFormat:@"%ld%02ld",(long)_monthType_year,(long)_monthType_month];
        }
    }
}

- (NSString *)_week {
    if (_isFirst == YES) {
        _isFirst = NO;
        return [NSString stringWithFormat:@"%ld%02ld",(long)_weekType_year,(long)_weekType_week];
    } else {
        _weekType_week -= 1;
        if (_weekType_week == 0) {
            _weekType_year -= 1;
            _weekType_week = 52;
            return [NSString stringWithFormat:@"%ld%02ld",(long)_weekType_year,(long)_weekType_week];
        } else {
            return [NSString stringWithFormat:@"%ld%02ld",(long)_weekType_year,(long)_weekType_week];
        }
    }
}


/**
 for (int i = 1; i < 100; i++) {
 //        [ViewController backToPassedTimeWithMonthNumber:i];
     [ViewController backToPassedTimeWithWeekNumber:i calendar:nil];
 }
 //月
 + (NSString *)backToPassedTimeWithMonthNumber:(NSInteger)number {
     NSCalendar *cal = [NSCalendar currentCalendar];
     NSDateComponents *components = [cal components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[[NSDate alloc] init]];
     [components setMonth:[components month] - number];
     NSDate *monthDate = [cal dateFromComponents:components];
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"yyyyMM"];
     [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zn_CN"]];
     NSLog(@"%@",[formatter stringFromDate:monthDate]);
     return [formatter stringFromDate:monthDate];
 }

 //周  未完成
 + (NSString *)backToPassedTimeWithWeekNumber:(NSInteger)number calendar:(NSCalendar *)cal {
     if (cal == nil) {
         cal = [NSCalendar currentCalendar];
     }
     
     NSDateComponents *components = [cal components:NSCalendarUnitWeekOfYear | NSCalendarUnitYear fromDate:[[NSDate alloc] init]];
     //    [components setWeek:[components week] - number];
     [components setWeekOfYear:[components weekOfYear] - number];
 //    NSDate *weekDate = [cal dateFromComponents:components];
     NSInteger week = [components weekOfYear]; // 今年的第几周
     NSInteger year = [components year];
     if (week == 0) {
         [components setYear:[components year] - 1];
 //        number

         return  [];
     }
     
     NSLog(@"%ld - %02ld",(long)year,(long)week);
     return [NSString stringWithFormat:@"%ld%2ld",(long)week,(long)year];

 */


@end
