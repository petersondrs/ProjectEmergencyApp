//
//  SocialNetworkViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 18/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface SocialNetworkViewController : UIViewController<FBLoginViewDelegate>
- (IBAction)btnPostStatus_TouchUpInside:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPostStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblLogIn;

@end
