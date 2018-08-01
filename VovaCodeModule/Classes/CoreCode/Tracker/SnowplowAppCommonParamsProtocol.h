//
//  SnowplowAppCommonParamsProtocol.h
//  ThemisGather
//
//  Created by Yongjian Ling on 31/7/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#ifndef SnowplowAppCommonParamsProtocol_h
#define SnowplowAppCommonParamsProtocol_h

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@protocol SnowplowAppCommonParamsProtocol <NSObject>

@required
@property (copy, nonatomic) NSString *app_version;
@property (copy, nonatomic) NSString *referrer;
@property (copy, nonatomic) NSString *uri;
@property (copy, nonatomic) NSString *page_code;
@property (copy, nonatomic) NSString *landing_page;
@property (copy, nonatomic) NSString *language;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *currency;

@end

#endif /* SnowplowAppCommonParamsProtocol_h */

//NS_ASSUME_NONNULL_END
