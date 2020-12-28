//
//  RankModel.m
//  Ranker
//
//  Created by riceFun on 2020/10/23.
//

#import "RankModel.h"

@implementation RankModel

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_author_id forKey:@"author_id"];
    [coder encodeObject:_avatar forKey:@"avatar"];
    [coder encodeObject:_category forKey:@"category"];
    [coder encodeObject:_episode_avg_comments forKey:@"episode_avg_comments"];
    [coder encodeObject:_episode_avg_played forKey:@"episode_avg_played"];
    [coder encodeObject:_episode_avg_thumbs forKey:@"episode_avg_thumbs"];
    [coder encodeObject:_fans forKey:@"fans"];
    [coder encodeObject:_interactive_incr forKey:@"interactive_incr"];
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_platform forKey:@"platform"];
    [coder encodeObject:_pt forKey:@"pt"];
    [coder encodeObject:_rank forKey:@"rank"];
    [coder encodeObject:_score forKey:@"score"];
    [coder encodeObject:_updown forKey:@"updown"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    
    if (self = [super init]) {
        _author_id = [coder decodeObjectForKey:@"author_id"];
        _avatar = [coder decodeObjectForKey:@"avatar"];
        _category = [coder decodeObjectForKey:@"category"];
        _episode_avg_comments = [coder decodeObjectForKey:@"episode_avg_comments"];
        _episode_avg_played = [coder decodeObjectForKey:@"episode_avg_played"];
        _episode_avg_thumbs = [coder decodeObjectForKey:@"episode_avg_thumbs"];
        _fans = [coder decodeObjectForKey:@"fans"];
        _interactive_incr = [coder decodeObjectForKey:@"interactive_incr"];
        _name = [coder decodeObjectForKey:@"name"];
        _platform = [coder decodeObjectForKey:@"platform"];
        _pt = [coder decodeObjectForKey:@"pt"];
        _rank = [coder decodeObjectForKey:@"rank"];
        _score = [coder decodeObjectForKey:@"score"];
        _updown = [coder decodeObjectForKey:@"updown"];
    }
    return self;
}

@end
