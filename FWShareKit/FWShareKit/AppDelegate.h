//
//  AppDelegate.h
//  FWShareKit
//
//  Created by Filly Wang on 18/3/15.
//  Copyright (c) 2015 Filly Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <GooglePlus/GooglePlus.h>
#import <FacebookSDK/FacebookSDK.h>
@interface AppDelegate : UIResponder  <UIApplicationDelegate,WXApiDelegate,GPPSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

