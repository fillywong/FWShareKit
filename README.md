# FWShareKit
Objective-c share kit for easy call share activity(facebook, wechat, line, whatsapp, twitter, weibo, googlePlus, copy link, email, sms )

# Screen shots

![alt tag](https://raw.githubusercontent.com/fillywong/FWShareKit/master/Assets/demo1.png)
![alt tag](https://raw.githubusercontent.com/fillywong/FWShareKit/master/Assets/demo2.png)

# Usage

``` ShareKit *shareKit = [ShareKit shareKitWithViewController:self];```
``` NSDictionary *shareEntry = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: [NSURL URLWithString: @"https://github.com/fillywong/FWShareKit" ], @"title", @"desc", [UIImage imageNamed:@"btn_player_sharevdo"] ,@"tttttitle",nil] forKeys:[NSArray arrayWithObjects:@"url", @"title", @"description", @"images",@"newstitle",nil]] ;```
``` [shareKit share:shareEntry];```

#Environment
Xcode Version 6.1.1 
Teting in ios8 & ios7

#Prepare For new project
1.Frmamework need to import<br>
libz.dylib<br>
libm.dylib<br>
libpthread.dylib<br>
SystemConfiguration.framework<br>
CFNetwork.framework<br>
AddressBook.framework<br>
Foundation.framework<br>
CoreMotion.framework<br>
CoreGraphics.framework<br>
CoreText.framework<br>
MediaPlayer.framework<br>
Security.framework<br>
AVFoundation.framework<br>
CoreMedia.framework<br>
Accounts.framework<br>
AssetsLibrary.framework<br>
CoreLocation.framework<br>
StoreKit.framework<br>
Social.framework<br>

2.Project setting
in build settings<br>
  Other Linker Flags :-ObjC<br>
in info<br>
  Set URL Types <br>
info.plist<br>
  set FacebookAppID<br>
  set FacebookDisplayName<br>

3.AppDelegate need to implement WXApiDelegate, GPPSignInDelegate

```- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {```
```    [self initGooglePlus];```
```    [self initWeChat];```
```    return YES;```
```}```
```
```- (void)initGooglePlus ```
```{
    [GPPSignIn sharedInstance].clientID = @"698755649817-rabvr3qlsnu2024s93ajtcb66it2hsh6.apps.googleusercontent.com";```
}

 -(void)initWeChat
{
    [WXApi registerApp:@"wxsdeeasaadddd22d6"];
}

 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}


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
}```
