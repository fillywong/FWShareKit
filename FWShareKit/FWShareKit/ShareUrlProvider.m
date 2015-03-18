//
//  ShareUrlProvider.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "ShareUrlProvider.h"

@implementation ShareUrlProvider

- (id)initWithShareUrlProvider:(NSDictionary*)shareObj
{
    self = [super initWithPlaceholderItem:nil];
    if (self) {
        _shareObj = shareObj;
        
    }
    return self;
}

- (id)item
{
    if ([self.activityType isEqualToString:UIActivityTypePostToTwitter] || [self.activityType isEqualToString:@"WeChat.share"] ||[self.activityType isEqualToString:UIActivityTypePostToWeibo]||[self.activityType isEqualToString:@"WeChat.shareTimeline"]||[self.activityType isEqualToString:UIActivityTypePostToFacebook]   )
    {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@", [_shareObj objectForKey:@"url"]]];
    }
    return self.placeholderItem;
}

@end
