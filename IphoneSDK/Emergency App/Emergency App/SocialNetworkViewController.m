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
#import "TWAPIManager.h"
#import "TWSignedRequest.h"
#import <Social/Social.h>

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
    return (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded);
}
-(BOOL)verifyIfIsLoggedToTwitter
{
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    return (app.twSession != nil);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.
    [self.tblRedeSocial
     setSeparatorColor:[UIColor colorWithRed:198.0/255.0 green:0 blue:0 alpha:1]];
    
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
    text.textColor = [UIColor whiteColor];
    text.backgroundColor = [UIColor colorWithRed:1 green:27.0/255.0 blue:0.0 alpha:1];
    text.font = [UIFont boldSystemFontOfSize:17];
   
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
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:27.0/255.0 blue:0.0 alpha:1];
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



#pragma View Events

- (void)switchTwitter_ValueChanged:(id)sender {
    
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    
    if (self.switchTwitter.isOn)
    {
        ACAccountStore* store = [[ACAccountStore alloc] init];
        
        ACAccountType *twitterType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        ACAccountStoreRequestAccessCompletionHandler handler = ^(BOOL granted, NSError *error) {
            ACAccount* twAccount;
            UIAlertView *alert;
            
            if (granted)
            {
                NSArray *twAccounts = [store accountsWithAccountType:twitterType];
                if (twAccounts.count > 0)
                {
                    twAccount = [twAccounts objectAtIndex:0];
                    app.twSession = twAccount;
                }
                else
                {
                     alert = [[UIAlertView alloc] initWithTitle:@"Emergency Response" message:@"Por favor configure uma conta do twitter no iOS" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                
            }
            else
            {
                alert = [[UIAlertView alloc] initWithTitle:@"Emergency Response" message:@"O usuário não permitiu a acesso a conta do twitter pela aplicação emergency response" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        
        
        };
        if ([store respondsToSelector:@selector(requestAccessToAccountsWithType:options:completion:)])
        {
            [store requestAccessToAccountsWithType:twitterType options:nil completion:handler];
        }
    }
    else
    {
        app.twSession = nil;
    }
}

- (void)switchFacebook_ValueChanged:(id)sender {
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
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
        
    }
    
}


@end
