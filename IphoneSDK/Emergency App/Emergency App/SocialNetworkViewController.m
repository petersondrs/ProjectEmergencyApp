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
        
        //switchNetwork.on = [self verifyIfIsLoggedToFacebook];
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
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(9, 0, tableView.bounds.size.width, 12)];
    
    label.textColor = [UIColor colorWithRed:1 green:27/255 blue:0 alpha:1];
    label.text = @"CONECTAR";
    label.font = [UIFont boldSystemFontOfSize:17];
    
    [headerView addSubview:label];
    
    return headerView;
}



#pragma View Events

- (void)switchTwitter_ValueChanged:(id)sender {
    
    
    
}

- (void)switchFacebook_ValueChanged:(id)sender {
    
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
    }
    
}

- (IBAction)btnSalvar_TouchUpInside:(id)sender {
}
@end
