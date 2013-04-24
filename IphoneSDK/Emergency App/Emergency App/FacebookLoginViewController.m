//
//  FacebookLoginViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 23/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "FacebookLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@interface FacebookLoginViewController ()

@end

@implementation FacebookLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FBLoginView* fbLogin = [[FBLoginView alloc] init];
   // fbLogin.frame = CGRectOffset(self.uiViewFaceBook.frame, 0, 0);
    fbLogin.delegate = self;
    
    [fbLogin sizeToFit];
    
    [self.uiViewFaceBook addSubview:fbLogin];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFechar_TouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma Fabebook Delegate
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
    self.rootController.switchFacebook.on = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.rootController.switchFacebook.on = NO;
}


@end
