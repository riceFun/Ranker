//
//  RankModel.h
//  Ranker
//
//  Created by riceFun on 2020/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankModel : NSObject<NSCoding>
@property (nonatomic,copy) NSString *author_id;
@property (nonatomic,copy) NSString *avatar;//头像

@property (nonatomic,copy) NSString *category;
@property (nonatomic,assign) NSNumber *episode_avg_comments;
@property (nonatomic,assign) NSNumber *episode_avg_played;

@property (nonatomic,assign) NSNumber *episode_avg_thumbs;
@property (nonatomic,assign) NSNumber *fans;//粉丝数
@property (nonatomic,assign) NSNumber *interactive_incr;

@property (nonatomic,copy) NSString *name;//姓名
@property (nonatomic,copy) NSString *platform;
@property (nonatomic,copy) NSString *pt;

@property (nonatomic,copy) NSString *rank;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *updown;




@end



NS_ASSUME_NONNULL_END
