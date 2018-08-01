//
//  SnowPlowAgent.m
//  ThemisGather
//
//  Created by Yongjian Ling on 31/7/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "SnowPlowAgent.h"
//#import <SnowplowTracker/Snowplow.h>
//#import <SnowplowTracker/SPEmitter.h>
//#import <SnowplowTracker/SPSubject.h>
//#import <SnowplowTracker/SPTracker.h>
//#import <SnowplowTracker/SPSelfDescribingJson.h>
//#import <SnowplowTracker/SPEvent.h>
#import <UIKit/UIKit.h>
#import "SPDeviceID.h"
#import "Snowplow.h"
#import "SPEmitter.h"
#import "SPSubject.h"
#import "SPTracker.h"
#import "SPSelfDescribingJson.h"
#import "SPEvent.h"


static NSString *const kVendor             = @"com.artemis";
static NSString *const kCommonName         = @"common";
static NSString *const kAppCommonName      = @"app_common";
static NSString *const kFormat             = @"jsonschema";
static NSString *const kCommonVersion      = @"1-0-1";
static NSString *const kAppCommonVersion   = @"1-0-0";

@interface SnowPlowAgent () <SPRequestCallback>
@property (nonatomic, strong) SPTracker *tracker;
@end

@implementation SnowPlowAgent

+ (instancetype)share
{
    static SnowPlowAgent *shareSnowPlowAgent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareSnowPlowAgent = [[self alloc] init];
    });
    return shareSnowPlowAgent;
}

+ (void)initTrackerWithHost:(NSString *)host
                        uid:(NSString *)uid
                  namespace:(NSString *)nameSpace
                      appId:(NSString *)appId
{
    if ([SnowPlowAgent share].tracker) {
        return;
    }
    
    SPEmitter *emitter = [SPEmitter build:^(id<SPEmitterBuilder> builder) {
        [builder setUrlEndpoint:host];
        [builder setHttpMethod:SPRequestPost];
        [builder setProtocol:SPHttps];
        [builder setEmitThreadPoolSize:20];
        [builder setCallback:[SnowPlowAgent share]];
    }];

    CGSize size = [self resolutionScreenSize];
    SPSubject *subject = [[SPSubject alloc] initWithPlatformContext:YES andGeoContext:NO];
    [subject setUserId:uid];
    [subject setResolutionWithWidth:(int)size.width andHeight:(int)size.height];
    [subject setDomainUserId:[self _domainUserId]];
    
    [SnowPlowAgent share].tracker = [SPTracker build:^(id<SPTrackerBuilder> builder) {
        [builder setEmitter:emitter];
        [builder setBase64Encoded:NO];
        [builder setSubject:subject];
        [builder setSessionContext:YES];
        [builder setAppId:appId];
        [builder setTrackerNamespace:nameSpace];
    }];
}

+ (void)postScreenViewEventWithUri:(NSString *)uri
                          pageCode:(NSString *)pageCode
                         appCommon:(NSDictionary *)appCommon
                            common:(NSDictionary *)common
{
    SPSelfDescribingJson *commonObject = [self getCommonContext:common];
    SPSelfDescribingJson *appCommonObject = [self getAppCommonContext:appCommon];
    NSMutableArray *contexts = [NSMutableArray array];
    [contexts addObject:commonObject];
    [contexts addObject:appCommonObject];
    SPScreenView *event = [SPScreenView build:^(id<SPScreenViewBuilder> builder) {
        [builder setName:uri];
        [builder setId:pageCode];
        [builder setContexts:contexts];
    }];
    [[SnowPlowAgent share].tracker trackScreenViewEvent:event];
}

#pragma mark - SPRequestCallback
- (void)onSuccessWithCount:(NSInteger)successCount
{
    NSLog(@"------ %@", @(successCount));
}

- (void)onFailureWithCount:(NSInteger)failureCount successCount:(NSInteger)successCount
{
    NSLog(@"------success %@ ------fail %@", @(successCount), @(failureCount));
}

#pragma mark - custom
+ (SPSelfDescribingJson *)getCommonContext:(NSDictionary *)common
{
    NSString *schema = [NSString stringWithFormat:@"iglu:%@/%@/%@/%@", kVendor, kCommonName, kFormat, kCommonVersion];
    SPSelfDescribingJson *context = [[SPSelfDescribingJson alloc] initWithSchema:schema andData:common];
    return context;
}

+ (SPSelfDescribingJson *)getAppCommonContext:(NSDictionary *)common
{
    NSString *schema = [NSString stringWithFormat:@"iglu:%@/%@/%@/%@", kVendor, kAppCommonName, kFormat, kAppCommonVersion];
    NSMutableDictionary *commonDic = [NSMutableDictionary dictionaryWithDictionary:common];
    [commonDic setValue:[SPDeviceID IDFV] forKey:@"idfv"];
    [commonDic setValue:[SPDeviceID IDFA] forKey:@"idfa"];
    [commonDic setValue:@"" forKey:@"android_id"];
    [commonDic setValue:@"" forKey:@"imei"];
    [commonDic setValue:[SPDeviceID deviceName] forKey:@"device_model"];

    SPSelfDescribingJson *context = [[SPSelfDescribingJson alloc] initWithSchema:schema andData:commonDic];
    return context;
}

#pragma mark - utils
+ (NSString *)_domainUserId
{
    NSString *domainUserId = [[NSUserDefaults standardUserDefaults] stringForKey:@"ThemisGather_domainUserId"];
    if (!domainUserId) {
        domainUserId = [self _generalRandomString];
        [[NSUserDefaults standardUserDefaults] setValue:domainUserId forKey:@"ThemisGather_domainUserId"];
    }
    return domainUserId;
}

+ (NSString *)_generalRandomString
{
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
    uint32_t randomValue = arc4random() % 10000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f%4u", timestamp, randomValue];
    return timeString;
}

+ (CGSize)resolutionScreenSize
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenRect.size;
    return CGSizeMake(screenSize.width * scale , screenSize.height * scale);
}

@end
