//
//  FacebookLoginViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 23/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SocialNetworkViewController.h"

@interface FacebookLoginViewController : UIViewController

- (IBAction)btnFechar_TouchUpInside:(id)sender;

- (IBAction)btnLogarFB_TouchUpInside:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnLogar;

@property (weak,nonatomic) SocialNetworkViewController* rootController;


@end
