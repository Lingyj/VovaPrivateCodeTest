//
//  DeviceID.m
//  FloryDay
//
//  Created by Demi on 11/3/16.
//  Copyright © 2016 FloryDay. All rights reserved.
//  获取当前设备系统信息

#import "SPDeviceID.h"
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import "UICKeyChainStore.h"

@implementation SPDeviceID

+ (NSString *)IDFA
{
    NSUUID *UUID = [ASIdentifierManager sharedManager].advertisingIdentifier;
    return UUID ? UUID.UUIDString : @"";
}

+ (NSString *)IDFV
{
    static NSString *IDFV = nil;
    if (!IDFV) {
        NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
        UICKeyChainStore *keyChain = [UICKeyChainStore keyChainStoreWithService:bundleIdentifier];
        NSString *IDFVFromKeyChain = keyChain[@"IDFV"];
        if (IDFVFromKeyChain == nil) {
            IDFVFromKeyChain = [[UIDevice currentDevice] identifierForVendor].UUIDString;
            keyChain[@"IDFV"] = IDFVFromKeyChain;
        } else {
            IDFV = IDFVFromKeyChain;
        }
    }
    return IDFV;
}

+ (NSString *)systemVersion
{
    //获取当前系统的版本——@"10.0"
    NSString * systemVersion = [[UIDevice currentDevice] systemVersion];
    return systemVersion ? systemVersion : @"";
}

+ (NSString *)deviceName
{
    // 获取移动设备名称
    NSString *deviceModel = [self deviceForName];
    return deviceModel ? deviceModel : @"";
}

// 2.获取方法
+ (NSString *)deviceForName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch";
    if ([deviceString isEqualToString:@"iPad6,11"])     return @"iPad 5Th";
    if ([deviceString isEqualToString:@"iPad6,12"])     return @"iPad 5Th";
    
    if ([deviceString isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9-inch 2nd";
    if ([deviceString isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch 2nd";
    if ([deviceString isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5-inch";
    if ([deviceString isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch";
    
    //AirPods
    if ([deviceString isEqualToString:@"AirPods1,1"])      return @"AirPods";
    
    //Apple TV
    if ([deviceString isEqualToString:@"AppleTV2,1"])      return @"AppleTV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])      return @"AppleTV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])      return @"AppleTV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])      return @"AppleTV 4";
    if ([deviceString isEqualToString:@"AppleTV6,2"])      return @"AppleTV 4K";
    
    //Apple Watch
    if ([deviceString isEqualToString:@"Watch1,1"])      return @"Apple Watch1";
    if ([deviceString isEqualToString:@"Watch1,2"])      return @"Apple Watch1";
    if ([deviceString isEqualToString:@"Watch2,6"])      return @"Apple Watch Series 1";
    if ([deviceString isEqualToString:@"Watch2,7"])      return @"Apple Watch Series 1";
    if ([deviceString isEqualToString:@"Watch2,3"])      return @"Apple Watch Series 2";
    if ([deviceString isEqualToString:@"Watch2,4"])      return @"Apple Watch Series 2";
    if ([deviceString isEqualToString:@"Watch3,1"])      return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,2"])      return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,3"])      return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,4"])      return @"Apple Watch Series 3";
    
    //HomePod
    if ([deviceString isEqualToString:@"AudioAccessory1,1"])      return @"HomePod";
    
    //模拟器
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

+ (NSDictionary *)serializeDeviceIDs
{
    return @{
             @"idfa": [self IDFA],
             @"idfv": [self IDFV],
             };
}

@end
