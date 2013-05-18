//
//  AppDelegate.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 05/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "SA_OAuthTwitterEngine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

-(NSMutableDictionary*)getDictionaryBundleProfile;
-(void)saveDictionaryBundleProfile : (NSMutableDictionary*) dic;
-(NSMutableDictionary*) getDictionaryBundleContatos;
-(void)saveDictionaryBundleContatos: (NSMutableDictionary*) dic;


@property (strong, nonatomic) UIWindow *window;


@property (strong, retain) FBSession* fbSession;
//@property (strong, retain) ACAccount* twSession;
@property (strong, retain) SA_OAuthTwitterEngine* twSession;
@end
