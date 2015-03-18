//
//  ShareKit.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "ShareKit.h"
#import "ShareProvider.h"
#import "ShareImageProvider.h"
#import "ShareUrlProvider.h"
#import "LineActivity.h"
#import "WhatsappActivity.h"
#import "TwitterActivity.h"
#import "WeiboActivity.h"
#import "FacebookActivity.h"
#import "GooglePlusActivity.h"
#import "WeixinTimelineActivity.h"
#import "WeixinSessionActivity.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation ShareKit

+ (instancetype)shareKitWithViewController:(UIViewController*)viewController
{
    return [[ShareKit alloc] initWithViewController:viewController];
}

- (instancetype)initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if (self)
    {
        self.viewController = viewController;
        self.applicationActivities = [NSMutableArray array];
        self.activityItems = [NSMutableArray array];
        self.excludeActivities = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Share

- (void)share:(NSDictionary*)shareObj
{
    self.shareObj = shareObj;
    
    ShareProvider *temp = [[ShareProvider alloc]initWithShareProvider:shareObj];
    ShareImageProvider *imageTemp = [[ShareImageProvider alloc]initWithShareImageProvider:shareObj];
    ShareUrlProvider *urlTemp = [[ShareUrlProvider alloc]initWithShareUrlProvider:shareObj];
    self.activityItems = [@[temp,imageTemp,urlTemp] mutableCopy];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        [self.excludeActivities addObject:UIActivityTypeAddToReadingList];
    }
    //whatsapp
    [self.applicationActivities addObject:[[WhatsappActivity alloc] init]];
    //line
    [self.applicationActivities addObject:[[LineActivity alloc] init]];
    //weChat
    [self.applicationActivities addObject:[[WeixinSessionActivity alloc] init]];
    [self.applicationActivities addObject:[[WeixinTimelineActivity alloc] init]];
    //facebook
    FacebookActivity *facebookActivity = [FacebookActivity proxyActivityIfNeeded];
    if (facebookActivity) [self.applicationActivities addObject:facebookActivity];
    facebookActivity.shareObj = shareObj;
    //twitter
    TwitterActivity *twitterActivity = [TwitterActivity proxyActivityIfNeeded];
    if (twitterActivity)  [self.applicationActivities addObject:twitterActivity];
    
    //Weibo
    WeiboActivity *weiboActivity = [WeiboActivity proxyActivityIfNeeded];
    if (weiboActivity) [self.applicationActivities addObject:weiboActivity];
    
    
    //google+
    [self.activityItems addObject:[self shareBuilder]];
    [self.applicationActivities addObject:[[GooglePlusActivity alloc] init]];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:self.activityItems applicationActivities:self.applicationActivities];
    
    
    [activityController setValue:[shareObj objectForKey:@"title"] forKey:@"subject"];
    activityController.excludedActivityTypes = self.excludeActivities;
    
    [self.viewController presentViewController:activityController animated:YES completion:nil];
}

- (id<GPPShareBuilder>)shareBuilder {
    BOOL useNativeSharebox = YES;
    
    if (![GPPSignIn sharedInstance].authentication ||
        ![[GPPSignIn sharedInstance].scopes containsObject:
          kGTLAuthScopePlusLogin]) {
            useNativeSharebox = NO;
        } else {
            useNativeSharebox = YES;
        }
    
    [GPPSignIn sharedInstance].shouldFetchGooglePlusUser = YES;
    
    // Create the share builder instance.
    id<GPPShareBuilder> shareBuilderInstance = useNativeSharebox ?
    [[GPPShare sharedInstance] nativeShareDialog] :
    [[GPPShare sharedInstance] shareDialog];
    
    NSURL *urlToShare = [self.shareObj objectForKey:@"url"];
    if (urlToShare) {
        [shareBuilderInstance setURLToShare:urlToShare];
    }
    
    NSString *inputText = [self.shareObj objectForKey:@"description"];
    NSString *text = [inputText length] ? inputText : nil;
    if (text) {
        [shareBuilderInstance setPrefillText:text];
    }
    
    // Attach media if we are using the native sharebox and have selected a media element.,
    if (useNativeSharebox) {
        if ( [_shareObj objectForKey:@"images"]) {
                [(id<GPPNativeShareBuilder>)shareBuilderInstance attachImage:[_shareObj objectForKey:@"images"]];
        }
    }

    
    return shareBuilderInstance;
}


@end
