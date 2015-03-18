//
//  WhatsappActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "WhatsappActivity.h"

@implementation WhatsappActivity

- (NSString*)activityType
{
    return @"com.whatsapp";
}

- (UIImage *)_activityImage
{
    return [UIImage imageNamed:@"whatsapp"];
}

- (NSString *)activityTitle
{
    return @"WhatsApp";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isUsableWhatsApp
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"whatsapp://"]];
}

- (void)openWhatsAppOnITunes
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/hk/app/whatsapp-messenger/id310633997?mt=8"]];
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([self openWhatsAppWithItem:activityItem])
            break;
    }
}

- (BOOL)openWhatsAppWithItem:(id)item
{
    if (![self isUsableWhatsApp])
    {
        [self openWhatsAppOnITunes];
        return NO;
    }
    
    NSString *WHATSAPPURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        NSString *urlEncodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL, (CFStringRef)item, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
        WHATSAPPURLString = [NSString stringWithFormat:@"whatsapp://send?text=%@", urlEncodeString];
    } else {
        return NO;
    }
    
    NSURL *WHATSAPPURL = [NSURL URLWithString:WHATSAPPURLString];
    [[UIApplication sharedApplication] openURL:WHATSAPPURL];
    return YES;
    
}

@end
