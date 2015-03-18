//
//  WeChatActivity.h
//  FWShareKit
//
//  Created by Filly Wang on 3/10/14.
//  Copyright (c) 2014 Filly Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
@interface WeChatActivity : UIActivity
{
    NSString *title;
    UIImage *image;
    NSURL *url;
    enum WXScene scene;
}
@end
