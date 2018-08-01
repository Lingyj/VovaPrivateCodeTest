//
//  DeviceID.h
//  FloryDay
//
//  Created by Demi on 11/3/16.
//  Copyright © 2016 FloryDay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPDeviceID : NSObject

+ (NSString *)IDFA;

// 该IDFV，经过Keychain的优化。
// 第一次获取IDFV时，将其存入Keychain。
// 此后，均从Keychain中获取IDFV，以保证其唯一性。
+ (NSString *)IDFV;

+ (NSDictionary *)serializeDeviceIDs;

//获取当前系统的版本
+ (NSString *)systemVersion;

// 获取移动设备名称
+ (NSString *)deviceName;

@end

NS_ASSUME_NONNULL_END
