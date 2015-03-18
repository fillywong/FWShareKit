//
//  FacebookActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "FacebookActivity.h"
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>
@implementation FacebookActivity

- (instancetype)initWithShareObj:(NSDictionary*)shareObj
{
    self = [super init];
    if (self)
    {
        _shareObj = shareObj;
    }
    return self;
}

+ (instancetype)proxyActivityIfNeeded {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        return nil;
    }
    return [self new];
}


- (NSString *)activityTitle
{
    return @"Facebook";
}

- (UIImage *)_activityImage
{
    return [UIImage imageNamed:@"facebook.png"];
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return @"com.facebook.katana";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSURL *imageUrl = nil;
//    if ( [_shareObj objectForKey:@"images"]) {
//        for (id image in [_shareObj objectForKey:@"images"]) {
//            if ( ![image objectForKey:@"default"]) continue ;
//            
//            if ( ![[image objectForKey:@"type"] isEqual:@"big"]) continue ;
//            
//            imageUrl = [NSURL URLWithString:[image objectForKey:@"url"]] ;
//            break;
//        }
//    }
    //UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]] ;
    
    FBLinkShareParams *shareParams = [[FBLinkShareParams alloc] init];
    shareParams.link = [_shareObj objectForKey:@"url"];
    shareParams.name = [_shareObj objectForKey:@"title"];
    shareParams.caption= [_shareObj objectForKey:@"description"];
    shareParams.linkDescription = [_shareObj objectForKey:@"title"];
    if (imageUrl != nil && imageUrl > 0) shareParams.picture = imageUrl;
    

    [self share:shareParams];
    
}

-(void)share:(FBLinkShareParams*)shareParams
{
    if ([FBDialogs canPresentShareDialogWithParams:shareParams])
    {
        [self shareShareDialog:shareParams];
    } else
    {
        [self shareFeedDialog:shareParams];
    }
}

-(void)shareShareDialog:(FBLinkShareParams*)params
{
     [FBDialogs presentShareDialogWithLink:params.link
             name:params.name
          caption:params.caption
      description:params.linkDescription
          picture:params.picture
      clientState:nil
          handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
              if(error) {
                  // An error occurred, we need to handle the error
                  // See: https://developers.facebook.com/docs/ios/errors
                  NSLog(@"%@",[NSString stringWithFormat:@"Error publishing story: %@", error.description]);
              } else {
                  // Success
                  NSLog(@"result %@", results);
              }
          }];
}

-(void)shareFeedDialog:(FBLinkShareParams*)shareParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   shareParams.name, @"name",
                                   shareParams.caption, @"caption",
                                   shareParams.name, @"description",
                                   [shareParams.link  absoluteString], @"link",
                                   [shareParams.picture absoluteString], @"picture",
                                   nil];
    
    [FBWebDialogs presentFeedDialogModallyWithSession:[FBSession activeSession] parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
     {
         if (error) {
             NSLog(@"%@",[NSString stringWithFormat:@"Error publishing story: %@", error.description]);
         } else
         {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 NSLog(@"User cancelled.");
             } else
             {
                 NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 if (![urlParams valueForKey:@"post_id"]) {
                     NSLog(@"User cancelled.");
                 } else {
                     // User clicked the Share button
                     NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                     NSLog(@"result %@", result);
                 }
             }
         }
     }];
}

// A function for parsing URL parameters
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1]
                         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}

@end
