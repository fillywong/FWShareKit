//
//  AppDelegate.m
//  FWShareKit
//
//  Created by Filly Wang on 18/3/15.
//  Copyright (c) 2015 Filly Wang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initGooglePlus];
    [self initWeChat];
    return YES;
}

-(void)initGooglePlus
{
    [GPPSignIn sharedInstance].clientID = @"asdfasdfasdfasdfasdfasdfsdf.apps.googleusercontent.com";
}

-(void)initWeChat
{
    [WXApi registerApp:@"wxsdeeasaadddd22d6"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - FBSession Delegate
// Pre 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

// For 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if([[url absoluteString] rangeOfString:@"fb"].location != NSNotFound)
    {
        return [FBAppCall handleOpenURL:url
                      sourceApplication:sourceApplication
                        fallbackHandler:^(FBAppCall *call) {
                            NSLog(@"Unhandled deep link: %@", url);
                        }];
    }
    else if ([[url absoluteString] rangeOfString:@"com"].location != NSNotFound)
    {
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return NO;
}

//google+
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
}

@end
