//
//  TwitterActivity.h
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterActivity : UIActivity
@property (nonatomic, strong) NSArray *items;
+ (instancetype)proxyActivityIfNeeded;
@end
