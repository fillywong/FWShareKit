//
//  LineActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "LineActivity.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
@implementation LineActivity

- (NSString *)activityType {
    return @"jp.naver.LINEActivity";
}

- (UIImage *)_activityImage
{
    return [UIImage imageNamed:@"line.png"];
}

- (NSString *)activityTitle
{
    return @"LINE";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([self openLINEWithItem:activityItem])
            break;
    }
}

- (BOOL)isUsableLINE
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]];
}

- (void)openLINEOnITunes
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/jp/app/line/id443904275?ls=1&mt=8"]];
}

- (BOOL)openLINEWithItem:(id)item
{
    if (![self isUsableLINE]) {
        [self openLINEOnITunes];
        return NO;
    }
    
    NSString *LINEURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        NSString *urlEncodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL, (CFStringRef)item, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
        LINEURLString = [NSString stringWithFormat:@"line://msg/text/%@", urlEncodeString];
    } else if ([item isKindOfClass:[UIImage class]]) {
        UIPasteboard *pasteboard = [UIPasteboard pasteboardWithUniqueName];
        [pasteboard setData:UIImagePNGRepresentation(item) forPasteboardType:@"無線新聞.png"];
        LINEURLString = [NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name];
    } else {
        return NO;
    }
    
    NSURL *LINEURL = [NSURL URLWithString:LINEURLString];
    [[UIApplication sharedApplication] openURL:LINEURL];
    return YES;
}
@end
