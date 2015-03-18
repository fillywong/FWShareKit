//
//  WeixinTimelineActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 3/10/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "WeixinTimelineActivity.h"

@implementation WeixinTimelineActivity
- (id)init
{
    self = [super init];
    if (self) {
        scene = WXSceneTimeline;
    }
    return self;
}

- (NSString *)activityType
{
    return @"WeChat.shareTimeline";
}

- (UIImage *)_activityImage
{
    return [UIImage imageNamed:@"wechat-timeline"];
}

- (NSString *)activityTitle
{
    return @"微信朋友圈";
}
@end
