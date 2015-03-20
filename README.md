# FWShareKit
Objective-c share kit for easy call share activity(facebook, wechat, line, whatsapp, twitter, weibo, googlePlus, copy link, email, sms )

# Screen shots

![alt tag](https://raw.githubusercontent.com/fillywong/FWShareKit/master/Assets/demo1.png)
![alt tag](https://raw.githubusercontent.com/fillywong/FWShareKit/master/Assets/demo2.png)

# Usage

``` ShareKit *shareKit = [ShareKit shareKitWithViewController:self];```
``` NSDictionary *shareEntry = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: [NSURL URLWithString: @"https://github.com/fillywong/FWShareKit" ], @"title", @"desc", [UIImage imageNamed:@"btn_player_sharevdo"] ,@"tttttitle",nil] forKeys:[NSArray arrayWithObjects:@"url", @"title", @"description", @"images",@"newstitle",nil]] ;```
``` [shareKit share:shareEntry];```
