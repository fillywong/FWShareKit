//
//  TwitterActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "TwitterActivity.h"
#import <Social/Social.h>

@implementation TwitterActivity

+ (instancetype)proxyActivityIfNeeded {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        return nil;
    }
    return [self new];
}

- (NSString *)activityTitle
{
    return @"Twitter";
}

- (UIImage *)_activityImage
{
    return [UIImage imageNamed:@"twitter"];
}

- (NSString *)activityType
{
    return UIActivityTypePostToTwitter;
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[UIImage class]] || [activityItem isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    self.items = activityItems;
}


- (UIViewController *)activityViewController
{
    SLComposeViewControllerCompletionHandler aComposeViewControllerCompletionHandler = ^(SLComposeViewControllerResult result)
    {
        if(result == SLComposeViewControllerResultDone) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功分享" message:@"成功分享至Twitter." delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [alert show];
        }
        [self activityDidFinish:YES];
    };
    
    SLComposeViewController *aTwitterComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    for (id item in self.items)
    {
        if ([item isKindOfClass:[NSString class]])
        {
            [aTwitterComposeViewController setInitialText:item];
        }
        else if ([item isKindOfClass:[UIImage class]])
        {
            [aTwitterComposeViewController addImage:item];
        }
    }
    
    [aTwitterComposeViewController setCompletionHandler:aComposeViewControllerCompletionHandler];
    return aTwitterComposeViewController;

}
@end
