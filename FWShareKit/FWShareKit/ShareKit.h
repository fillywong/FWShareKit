//
//  ShareKit.h
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShareKit : NSObject

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) NSMutableArray *applicationActivities;
@property (nonatomic, strong) NSMutableArray *activityItems;
@property (nonatomic, strong) NSMutableArray *excludeActivities;
@property (nonatomic, strong) NSDictionary *shareObj;

+ (instancetype)shareKitWithViewController:(UIViewController*)viewController;
- (instancetype)initWithViewController:(UIViewController*)viewController;
- (void)share:(NSDictionary*)shareObj;

@end
