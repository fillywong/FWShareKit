//
//  ShareImageProvider.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "ShareImageProvider.h"

@implementation ShareImageProvider

- (id)initWithShareImageProvider:(NSDictionary*)shareObj
{
    self = [super initWithPlaceholderItem:nil];
    if (self) {
        _shareObj = shareObj;
        
    }
    return self;
}

- (id)item
{
    if ([self.activityType isEqualToString:UIActivityTypeMail] || [self.activityType isEqualToString:UIActivityTypePostToTwitter] || [self.activityType isEqualToString:UIActivityTypePostToWeibo] || [self.activityType isEqualToString:UIActivityTypePostToFacebook] || [self.activityType isEqualToString:@"WeChat.share"]||[self.activityType isEqualToString:@"WeChat.shareTimeline"])
    {
        if ( [_shareObj objectForKey:@"images"]) {
                return [_shareObj objectForKey:@"images"];
        }
        return self.placeholderItem;
    }
    return self.placeholderItem;
}

@end
