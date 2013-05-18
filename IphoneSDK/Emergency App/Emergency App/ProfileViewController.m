//
//  ProfileViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 14/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NascidoViewController.h"
#import "AppDelegate.h"
#import "TipoSanguineoViewController.h"
#import "ProfileEditNomeViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    
    NSMutableDictionary* dic = [[self getMainDelegate] getDictionaryBundleProfile];
    
    
    self.cellNome.detailTextLabel.text = [dic objectForKey:@"Nome"];
    self.cellNascido.detailTextLabel.text = [dic objectForKey:@"DataNascimento"];
    self.cellTipoSanguineo.detailTextLabel.text = [dic objectForKey:@"TipoSanguineo"];
    self.txtAlergia.text = [dic objectForKey:@"Alergia"];
    self.txtPlanoSaude.text = [dic objectForKey:@"PlanoSaude"];
    self.txtObs.text = [dic objectForKey:@"Obs"];
    
    
}

- (IBAction)btnSalvar_TouchUpInside:(id)sender {
    
    NSMutableDictionary* dic = [[self getMainDelegate] getDictionaryBundleProfile];
    
    [dic setObject:self.cellNome.detailTextLabel.text forKey:@"Nome"];
    [dic setObject:self.txtAlergia.text forKey:@"Alergia"];
    [dic setObject:self.txtPlanoSaude.text forKey:@"PlanoSaude"];
    [dic setObject:self.txtObs.text forKey:@"Obs"];
    [dic setObject:self.cellNascido.detailTextLabel.text forKey:@"DataNascimento"];
    [dic setObject:self.cellTipoSanguineo.detailTextLabel.text forKey:@"TipoSanguineo"];
   
    
    [[self getMainDelegate] saveDictionaryBundleProfile:dic];
    
  
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                    message:@"Dados Salvos"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 && indexPath.section == 0)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"Nome" sender:cell];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.row == 1 && indexPath.section == 0)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"NascidoEm" sender:cell];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.row == 2 && indexPath.section == 0)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"TipoSanguineo" sender:cell];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UITableViewCell* cell;
    
    
    if ([segue.identifier isEqualToString:@"NascidoEm"])
    {
        cell = (UITableViewCell*)sender;
        
        NascidoViewController* destinationController = (NascidoViewController*) [segue destinationViewController];
        
        destinationController.cell = cell;
    }
    else if ([segue.identifier isEqualToString:@"TipoSanguineo"])
    {
        cell = (UITableViewCell*)sender;
        
        TipoSanguineoViewController* destinationController = (TipoSanguineoViewController*) [segue destinationViewController];
        
        destinationController.cell = cell;
    }
    else if ([segue.identifier isEqualToString:@"Nome"])
    {
        cell = (UITableViewCell*)sender;
        
        ProfileEditNomeViewController* destinationController = (ProfileEditNomeViewController*) [segue destinationViewController];
        
        destinationController.cellNome = cell;
    }
    
    
    
}

#pragma UIAlert Protocol

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
