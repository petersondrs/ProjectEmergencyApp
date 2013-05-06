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
-(AppDelegate*) getMainDelegate {
    
    return [[UIApplication sharedApplication] delegate];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (appDelegate.fbSession.isOpen)
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
    
    AppDelegate* appDelegate = [self getMainDelegate];
    
    NSMutableDictionary* dic = [appDelegate getDictionaryBundleProfile];
    
    
    
    //Se a sessão do facebook não está logado, logar no facebook
    
    if (!appDelegate.fbSession.isOpen)
    {
        //Criar uma sessão nova
        appDelegate.fbSession = [[FBSession alloc]init];
       
        [FBSession setActiveSession:appDelegate.fbSession];
        
        [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions",@"publish_checkins"]
                                           defaultAudience:FBSessionDefaultAudienceFriends
                                              allowLoginUI:YES
                                         completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
        {
            
            if (!error)
            {
                
                [self.btnLogar setTitle:@"Log out" forState:UIControlStateNormal];
                self.rootController.switchFacebook.on = YES;
                
                [dic setObject:@"1" forKey:@"Facebook"];
                [appDelegate saveDictionaryBundleProfile:dic];
            }
        }];
              
    }
    else
    {
        [appDelegate.fbSession closeAndClearTokenInformation];
        [self.btnLogar setTitle:@"Log in" forState:UIControlStateNormal];
        self.rootController.switchFacebook.on = NO;
        [dic setObject:@"0" forKey:@"Facebook"];
        [appDelegate saveDictionaryBundleProfile:dic];
        
    }
    
   
}


@end
