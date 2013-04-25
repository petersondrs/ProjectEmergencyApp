//
//  FacebookLoginViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 23/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "FacebookLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

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
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (appDelegate.session.isOpen)
    {
        [self.btnLogar setTitle:@"Log out" forState:UIControlStateNormal];
    }
    else
    {
        [self.btnLogar setTitle:@"Log in" forState:UIControlStateNormal];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFechar_TouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnLogarFB_TouchUpInside:(id)sender {
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    //Se a sessão do facebook não está logado, logar no facebook
    
    if (!appDelegate.session.isOpen)
    {
        //Criar uma sessão nova
        appDelegate.session = [[FBSession alloc]init];
        
        
        [appDelegate.session openWithCompletionHandler:
         ^(FBSession *session, FBSessionState status, NSError *error)
        {
            [self.btnLogar setTitle:@"Log out" forState:UIControlStateNormal];
             self.rootController.switchFacebook.on = YES;
        }];
    }
    else
    {
        [appDelegate.session closeAndClearTokenInformation];
        [self.btnLogar setTitle:@"Log in" forState:UIControlStateNormal];
        self.rootController.switchFacebook.on = NO;
        
    }
    
}


@end
