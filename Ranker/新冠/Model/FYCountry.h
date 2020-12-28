//
//  FYCountry.h
//  Ranker
//
//  Created by riceFun on 2020/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*国家对应表
https://blog.csdn.net/weixin_33834075/article/details/93689728
https://wenku.baidu.com/view/d196388d2bf90242a8956bec0975f46526d3a768.html
 */


@interface FYCountry : NSObject
@property (nonatomic,copy) NSString *Country;//国家
@property (nonatomic,copy) NSString *Slug;//用于请求的参数
@property (nonatomic,copy) NSString *ISO2;//国家缩写

@property (nonatomic,copy) NSString *Flag;//国旗

@end


@interface FYCountryOtherData : NSObject
@property (nonatomic,copy) NSString *code;//code
@property (nonatomic,copy) NSString *name_chinese;
@property (nonatomic,copy) NSString *name_english;
@property (nonatomic,copy) NSString *continent;//所属洲

//the key is code just FYCountry.ISO2
+ (NSDictionary *)getCountryOtherData;
@end



NS_ASSUME_NONNULL_END
