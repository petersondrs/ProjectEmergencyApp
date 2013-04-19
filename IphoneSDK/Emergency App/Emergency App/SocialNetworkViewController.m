//
//  SocialNetworkViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 18/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "SocialNetworkViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface SocialNetworkViewController ()

@end

@implementation SocialNetworkViewController

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
    
    
    FBLoginView* fbloginView = [[FBLoginView alloc] init];
    fbloginView.frame = CGRectOffset(fbloginView.frame, 5, 5);
    fbloginView.delegate = self;
    fbloginView.publishPermissions = @[@"publish_actions"];
    fbloginView.defaultAudience = FBSessionDefaultAudienceEveryone;
    [fbloginView sizeToFit];
    
    
    [self.view addSubview:fbloginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginFacebook_TouchUpInside:(id)sender {
}

- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        if (error.fberrorShouldNotifyUser ||
            error.fberrorCategory == FBErrorCategoryPermissions ||
            error.fberrorCategory == FBErrorCategoryAuthenticationReopenSession) {
            alertMsg = error.fberrorUserMessage;
        } else {
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        alertTitle = @"Success";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)btnPostStatus_TouchUpInside:(id)sender {
     [self performPublishAction:^{
        NSString *message = [NSString stringWithFormat:@"Integrando no iOS em %@", [NSDate date]];
        
        [FBRequestConnection startForPostStatusUpdate:message
                                    completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                        [self showAlert:message result:result error:error];
                                    }];
       
    }];

}

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceEveryone
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                }
                                                //For this example, ignore errors (such as if user cancels).
                                            }];
    } else {
        action();
    }
    
}


#pragma FbLoginViewDelegate
-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    
    self.btnPostStatus.enabled = NO;
}
-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    
    NSLog(@"%@",error);
}
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    
}
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
    self.btnPostStatus.enabled = YES;
    self.lblLogIn.text = @"Você está logado no facebook";
    
    
}

@end
