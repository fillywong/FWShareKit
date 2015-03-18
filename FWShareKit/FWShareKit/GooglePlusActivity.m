//
//  GooglePlusActivity.m
//  FWShareKit
//
//  Created by Filly Wang on 3/10/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import "GooglePlusActivity.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>

@interface GooglePlusActivity ()

// The prefilled GPPShareBuilder object.
@property(nonatomic, strong) id<GPPShareBuilder> builder;

@end

@implementation GooglePlusActivity


- (NSString *)activityType {
    return @"googleplus.share";
}

- (NSString *)activityTitle {
    return @"Google+";
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (UIImage *)_activityImage {
    return [UIImage imageNamed:@"google+"];
}

// In the minimum case, we can still present an empty share box.
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (NSObject *item in activityItems) {
        if ([item conformsToProtocol:@protocol(GPPShareBuilder)]) {
            self.builder = (id<GPPShareBuilder>)item;
        }
    }
}

- (void)performActivity {
    [self activityDidFinish:YES];
    if (![self.builder open]) {
        GTMLoggerError(@"Status: Error (see console).");
    }
}


@end
