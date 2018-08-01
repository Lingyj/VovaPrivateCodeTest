//
//  SnowplowScreenViewParamsProtocol.h
//  ThemisGather
//
//  Created by Yongjian Ling on 31/7/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#ifndef SnowplowScreenViewParamsProtocol_h
#define SnowplowScreenViewParamsProtocol_h

#import "SnowplowAppCommonParamsProtocol.h"
#import "SnowplowCommonParamsProtocol.h"

@protocol SnowplowScreenViewParamsProtocol <NSObject>

@required
@property (copy, nonatomic) NSString *uri;
@property (copy, nonatomic) NSString *page_code;

@property (strong, nonatomic) id <SnowplowAppCommonParamsProtocol> appCommonParams;
@property (strong, nonatomic) id <SnowplowCommonParamsProtocol> commonParams;

@end


#endif /* SnowplowScreenViewParamsProtocol_h */
