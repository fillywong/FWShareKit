//
//  WeixinSessionActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 3/10/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "WeixinSessionActivity.h"
@implementation WeixinSessionActivity
- (UIImage *)_activityImage
{
    return [UIImage imageNamed:@"wechat"];
}

- (NSString *)activityType
{
    return @"WeChat.share";
}

- (NSString *)activityTitle
{
    return @"微信好友";
}


@end
