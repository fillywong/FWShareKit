//
//  ShareUrlProvider.h
//  FWShareKit
//
//  Created by Filly Wang on 29/9/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareUrlProvider : UIActivityItemProvider

@property (nonatomic, strong, readonly) NSDictionary *shareObj;

- (id)initWithShareUrlProvider:(NSDictionary*)shareObj;

@end
