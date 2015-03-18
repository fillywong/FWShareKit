//
//  FacebookActivity.h
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookActivity : UIActivity
@property (nonatomic, strong) NSDictionary *shareObj;
- (instancetype)initWithShareObj:(NSDictionary*)shareObj ;
+ (instancetype)proxyActivityIfNeeded;
@end
