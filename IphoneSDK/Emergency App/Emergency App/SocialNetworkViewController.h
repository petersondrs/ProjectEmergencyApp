//
//  SocialNetworkViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 18/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface SocialNetworkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) UISwitch *switchFacebook;

@property (weak, nonatomic) UISwitch *switchTwitter;
@property (weak, nonatomic) IBOutlet UITableView *tblRedeSocial;

@end
