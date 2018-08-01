//
//  SnowplowCommonParamsProtocol.h
//  ThemisGather
//
//  Created by Yongjian Ling on 31/7/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#ifndef SnowplowCommonParamsProtocol_h
#define SnowplowCommonParamsProtocol_h

@protocol SnowplowCommonParamsProtocol <NSObject>

@required
@property (copy, nonatomic) NSString *page_code;
@property (copy, nonatomic) NSString *language;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *currency;

@end

#endif /* SnowplowCommonParamsProtocol_h */
