//
//  ViewController.m
//  FWShareKit
//
//  Created by Filly Wang on 18/3/15.
//  Copyright (c) 2015 Filly Wang. All rights reserved.
//

#import "ViewController.h"
#import "ShareKit.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareBtnOnClick:(id)sender {
    ShareKit *shareKit = [ShareKit shareKitWithViewController:self];
    NSDictionary *shareEntry = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: [NSURL URLWithString: @"https://github.com/fillywong/FWShareKit" ], @"title", @"desc", [UIImage imageNamed:@"btn_player_sharevdo"] ,@"tttttitle",nil] forKeys:[NSArray arrayWithObjects:@"url", @"title", @"description", @"images",@"newstitle",nil]] ;
    [shareKit share:shareEntry];
}

@end
