//
//  WeiboActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "WeiboActivity.h"
#import <Social/Social.h>
@implementation WeiboActivity

+ (instancetype)proxyActivityIfNeeded {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        return nil;
    }
    return [self new];
}

- (NSString *)activityTitle
{
    return @"Sina Weibo";
}

- (UIImage *)_activityImage
{
    return [UIImage imageNamed:@"SinaWeibo"];
}

- (NSString *)activityType
{
    return UIActivityTypePostToWeibo;
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
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功分享" message:@"成功分享至Sina Weibo." delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [alert show];
        }
        [self activityDidFinish:YES];
    };
    SLComposeViewController *aSinaWeiboComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    for (id item in self.items) {
        if ([item isKindOfClass:[NSString class]]) {
            [aSinaWeiboComposeViewController setInitialText:item];
        } else if ([item isKindOfClass:[UIImage class]]) {
            [aSinaWeiboComposeViewController addImage:item];
        } else if ([item isKindOfClass:[NSURL class]]) {
            [aSinaWeiboComposeViewController addURL:item];
        }
    }
    [aSinaWeiboComposeViewController setCompletionHandler:aComposeViewControllerCompletionHandler];
    return aSinaWeiboComposeViewController;
}

@end
