//
//  ShareProvider.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "ShareProvider.h"

@implementation ShareProvider

- (id)initWithShareProvider:(NSDictionary*)shareObj
{
    self = [super initWithPlaceholderItem:[shareObj objectForKey:@"title"]];
    if (self) {
        _title = [shareObj objectForKey:@"title"];
        _shareObj = shareObj;
    }
    return self;
}

- (id)item
{
    NSString *shareText = nil;
    if([[_shareObj objectForKey:@"description"]rangeOfString:@"null"].location == NSNotFound)
    {
        int descriptionLength = [[_shareObj objectForKey:@"description"] length]>26?26:(int)[[_shareObj objectForKey:@"description"] length];
        shareText = [NSString stringWithFormat:@"%@\n%@...", [_shareObj objectForKey:@"title"], [[_shareObj objectForKey:@"description"] substringWithRange:NSMakeRange(0, descriptionLength)]];
    }
    else
    {
        shareText = [NSString stringWithFormat:@"%@", [_shareObj objectForKey:@"title"]];
    }
    shareText = [shareText stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
   // NSString *titleWithCategory = [_shareObj objectForKey:@"newstitle"];
    
    if ([self.activityType isEqualToString:UIActivityTypePostToFacebook]) {
        
        return shareText;
    }
    else if([self.activityType isEqualToString:UIActivityTypeCopyToPasteboard])
    {
        
        return [_shareObj objectForKey:@"url"];
    }
    else if([self.activityType isEqualToString:UIActivityTypeMail])
    {
        
        NSString *emailBody = [NSString stringWithFormat:@"<html><body>%@<br/><a href='%@'> %@</a></body></html>",  [_shareObj objectForKey:@"title"],[_shareObj objectForKey:@"url"], [_shareObj objectForKey:@"url"]];
        return emailBody;
    }
    else if([self.activityType isEqualToString:UIActivityTypeMessage])
    {
        
        shareText = [NSString stringWithFormat:@"%@\n%@", [_shareObj objectForKey:@"title"],[[_shareObj objectForKey:@"url"] absoluteString]];
        return shareText;
    }
    else if([self.activityType isEqualToString:UIActivityTypePostToTwitter])
    {
        
        return shareText;
    }
    else if([self.activityType isEqualToString:UIActivityTypePostToWeibo])
    {
        return shareText;
    }
    else if([self.activityType isEqualToString:@"jp.naver.LINEActivity"])
    {
        
        shareText = [NSString stringWithFormat:@"%@\n%@", [_shareObj objectForKey:@"title"],[[_shareObj objectForKey:@"url"] absoluteString]];
        return shareText;
    }
    else if([self.activityType isEqualToString:@"com.whatsapp"])
    {
        
        shareText = [NSString stringWithFormat:@"%@\n%@", [_shareObj objectForKey:@"title"],[[_shareObj objectForKey:@"url"] absoluteString]];
        return shareText;
    }
    else if([self.activityType isEqualToString:@"googleplus.share"])
    {
        
        return shareText;
    }
    else if([self.activityType isEqualToString:@"WeChat.share"])
    {
        
        return shareText;
    }
    else if([self.activityType isEqualToString:@"WeChat.shareTimeline"])
    {
        
        return shareText;
    }
    else {
        return shareText;
    }
}

@end
