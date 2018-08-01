//
//  SnowPlowAgent.h
//  ThemisGather
//
//  Created by Yongjian Ling on 31/7/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnowplowScreenViewParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SnowPlowAgent : NSObject

+ (instancetype)share;

+ (void)initTrackerWithHost:(NSString *)host
                        uid:(NSString *)uid
                  namespace:(NSString *)nameSpace
                      appId:(NSString *)appId;

+ (void)postScreenViewEventWithUri:(NSString *)uri
                          pageCode:(NSString *)pageCode
                         appCommon:(NSDictionary *)appCommon
                            common:(NSDictionary *)common;

//+ (void)postScreenName:(id <SnowplowScreenViewParamsProtocol>)params;

@end

NS_ASSUME_NONNULL_END
