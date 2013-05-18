//
//  SocialNetworkViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 18/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "SocialNetworkViewController.h"
#import "FacebookLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "OAuth+Additions.h"
#import <Social/Social.h>
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"

#define kOAuthConsumerKey			@"2he1EcnaiXTEVzVG4OTw"
#define kOAuthConsumerSecret		@"zgvXmagwdieHIN9kr5uy5b37JIfOLdecjOwkWTnLw0"

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

-(BOOL)verifyIfIsLoggedToFacebook
{
    return [[FBSession activeSession] isOpen];
}
-(BOOL)verifyIfIsLoggedToTwitter
{
    //AppDelegate* app = [[UIApplication sharedApplication] delegate];
    SA_OAuthTwitterEngine* twitter_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
    twitter_engine.consumerKey = kOAuthConsumerKey;
    twitter_engine.consumerSecret = kOAuthConsumerSecret;
    
    return [twitter_engine isAuthorized];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.
    [self.tblRedeSocial
     setSeparatorColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"facebookLogin"])
    {
        UINavigationController* navCtrl = (UINavigationController*) [segue destinationViewController];
        
        FacebookLoginViewController* facebook = (FacebookLoginViewController*) [navCtrl.viewControllers objectAtIndex:0];
        
        facebook.rootController = self;
        self.switchFacebook.on = NO;

    }
    
}


- (void)twitterAccountMessage: (NSString*) message{
    UIAlertView *alertViewTwitter = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                               message:message
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
    
    [alertViewTwitter show];
}

#pragma UiTableViewDataSource Protocol

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    
    //configura os objetos comuns label, switch, image...
    
    //configura a view ui como conteiner de objetos
    UIView* viewCell = [[UIView alloc] initWithFrame:cell.frame];
    
    //Configura o label
    UILabel* text = [[UILabel alloc]initWithFrame:CGRectMake(50, 11, 100 , 30)];
    text.textColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1];
    text.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    text.font = [UIFont boldSystemFontOfSize:15];
   
    //Configura o switch
    UISwitch*  switchNetwork = [[UISwitch alloc] initWithFrame:CGRectMake(231, 13, 79, 27)];
    
    //Configura a imagem
    UIImageView* viewImage = nil;
    UIImage* img = nil;
    
    if (indexPath.row == 0)
    {
        //Criar a view de imagem
        img = [UIImage imageNamed:@"logoFbShareScreen.png"];
        viewImage = [[UIImageView alloc] initWithImage:img];
        
        //Adiciono o UILabel
        text.text = @"FACEBOOK";
        [viewCell addSubview:text];
        
        switchNetwork.on = [self verifyIfIsLoggedToFacebook];
        [switchNetwork addTarget:self
                          action:@selector(switchFacebook_ValueChanged:)
                forControlEvents:UIControlEventValueChanged];
        
        self.switchFacebook = switchNetwork;
    
    }
    else
    {
        
        //Criar a view de imagem
        img = [UIImage imageNamed:@"logoTwitterShareScreen.png"];
        viewImage = [[UIImageView alloc] initWithImage:img];
        
        
        //Adiciono o UILabel
        text.text = @"TWITTER";
        
        switchNetwork.on = [self verifyIfIsLoggedToTwitter];
        [switchNetwork addTarget:self
                          action:@selector(switchTwitter_ValueChanged:)
                forControlEvents:UIControlEventValueChanged];
        self.switchTwitter = switchNetwork;
        
    }
    
    //Configura o frame da view
    viewImage.frame = CGRectMake(6, 9, img.size.width, img.size.height);
    
    //Adiciona a img
    [viewCell addSubview:viewImage];
    
    //Adicionando a label
    [viewCell addSubview:text];
    //Adicionando o switch
    [viewCell addSubview:switchNetwork];
    
    //Cria a view na cell
    [cell.contentView addSubview:viewCell];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(9, 0, tableView.bounds.size.width, 0)];
    
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(9, 0, tableView.bounds.size.width, 13)];
    
    label.textColor = [UIColor colorWithRed:1 green:27/255 blue:0 alpha:1];
    label.text = @"CONECTAR";
    label.font = [UIFont boldSystemFontOfSize:17];
    
    [headerView addSubview:label];
    
    return headerView;
}

#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}


#pragma View Events

- (void)switchTwitter_ValueChanged:(id)sender {
    
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    SA_OAuthTwitterEngine* twitter_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
    twitter_engine.consumerKey = kOAuthConsumerKey;
    twitter_engine.consumerSecret = kOAuthConsumerSecret;
    
   
    NSMutableDictionary* dic = [app getDictionaryBundleProfile];
    
    if (self.switchTwitter.isOn)
    {
        if (![twitter_engine isAuthorized])
        {
            UIViewController *controller = [SA_OAuthTwitterController
                                            controllerToEnterCredentialsWithTwitterEngine: twitter_engine
                                            delegate: self];
            
            [controller setTitle:@"teste"];
            
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        
        
        [dic setObject:@"1" forKey:@"Twitter"];
        [app saveDictionaryBundleProfile:dic];
    }
    else
    {
         NSMutableDictionary* dic = [app getDictionaryBundleProfile];
        [dic setObject:@"0" forKey:@"Twitter"];
        [app saveDictionaryBundleProfile:dic];
        
        NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"authData"];
        
        [twitter_engine clearAccessToken];
    }
}

- (void)switchFacebook_ValueChanged:(id)sender {
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    
   NSMutableDictionary* dic = [app getDictionaryBundleProfile];
    
    if (self.switchFacebook.isOn)
    {
        if (![self verifyIfIsLoggedToFacebook])
        {
            [self performSegueWithIdentifier:@"facebookLogin" sender:self];
        }
    }
    else
    {
        [[FBSession activeSession] closeAndClearTokenInformation];
        [app.fbSession closeAndClearTokenInformation];
        app.fbSession = nil;
        self.switchFacebook.on = NO;
        
        [dic setObject:@"0" forKey:@"Facebook"];
        [app saveDictionaryBundleProfile:dic];
        
    }
    
}

#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	self.switchTwitter.on = NO;
}
- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	self.switchTwitter.on = NO;
}


@end
