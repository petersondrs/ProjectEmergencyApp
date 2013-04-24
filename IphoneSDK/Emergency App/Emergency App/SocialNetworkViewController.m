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

-(BOOL)verifyIfIsLoggedToFacebook{
    
    return (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"facebookLogin"])
    {
        FacebookLoginViewController* facebook = (FacebookLoginViewController*) [segue destinationViewController];
        facebook.rootController = self;
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
    UISwitch*  switchNetwork = [[UISwitch alloc] initWithFrame:CGRectMake(231, 14, 79, 27)];
    
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    
    if (indexPath.row == 0)
    {
        switchNetwork.on = [self verifyIfIsLoggedToFacebook];
        
        [switchNetwork addTarget:self
                          action:@selector(switchFacebook_ValueChanged:)
                forControlEvents:UIControlEventValueChanged];
        
        cell.textLabel.text = @"Facebook";
        
        
        [cell.contentView addSubview:switchNetwork];
        
        self.switchFacebook = switchNetwork;
        
    }
    else
    {
        switchNetwork.on = [self verifyIfIsLoggedToFacebook];
        
        [switchNetwork addTarget:self
                          action:@selector(switchTwitter_ValueChanged:)
                forControlEvents:UIControlEventValueChanged];
        
        cell.textLabel.text = @"Twitter";
        
        [cell.contentView addSubview:switchNetwork];
        
        self.switchTwitter = switchNetwork;
        
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:27.0/255.0 blue:0.0 alpha:1];
    cell.textLabel.backgroundColor = [UIColor colorWithRed:1 green:27.0/255.0 blue:0.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tblRedeSocial setSeparatorColor:[UIColor colorWithRed:198.0/255.0 green:0 blue:0 alpha:1]];
    
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
            self.switchFacebook.on = NO;
        }
    }
    
}

- (IBAction)btnSalvar_TouchUpInside:(id)sender {
}
@end
