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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"Profile" ofType:@"plist"];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:bundle];
    
    
    self.txtNome.text = [dic objectForKey:@"Nome"];
    self.txtSobreNome.text = [dic objectForKey:@"SobreNome"];
    self.cellNascido.detailTextLabel.text = [dic objectForKey:@"DataNascimento"];
    self.cellTipoSanguineo.detailTextLabel.text = [dic objectForKey:@"TipoSanguineo"];
    self.txtAlergia.text = [dic objectForKey:@"Alergia"];
    self.txtPlanoSaude.text = [dic objectForKey:@"PlanoSaude"];
    self.txtObs.text = [dic objectForKey:@"Obs"];
    
    
}

- (IBAction)btnSalvar_TouchUpInside:(id)sender {
    
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"Profile" ofType:@"plist"];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:bundle];
    
    [dic setObject:self.txtNome.text forKey:@"Nome"];
    [dic setObject:self.txtSobreNome.text forKey:@"SobreNome"];
    [dic setObject:self.txtAlergia.text forKey:@"Alergia"];
    [dic setObject:self.txtPlanoSaude.text forKey:@"PlanoSaude"];
    [dic setObject:self.txtObs.text forKey:@"Obs"];
    [dic setObject:self.cellNascido.detailTextLabel.text forKey:@"DataNascimento"];
    [dic setObject:self.cellTipoSanguineo.detailTextLabel.text forKey:@"TipoSanguineo"];
    [dic writeToFile:bundle atomically:YES];
    
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

#pragma mark - Table view data source


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma UITextField Protocol

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextTextField = [self.view viewWithTag:textField.tag + 1];
    
    if (textField.tag == 1)
    {
        [nextTextField becomeFirstResponder];
    }
    else if (textField.tag == 2)
    {
        [nextTextField resignFirstResponder];
        [self.view endEditing:YES];
    }
    
    return YES;
    
}

#pragma UITextView Protocol
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [self.view endEditing:YES];
    }
    return YES;
}



#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2 && indexPath.section == 0)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"NascidoEm" sender:cell];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (indexPath.row == 3 && indexPath.section == 0)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"TipoSanguineo" sender:cell];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"NascidoEm"] || [segue.identifier isEqualToString:@"TipoSanguineo"])
    {
        UITableViewCell* cell = (UITableViewCell*)sender;
        
        NascidoViewController* destinationController = (NascidoViewController*) [segue destinationViewController];
        
        destinationController.cell = cell;
    }
    
    
}

#pragma UIAlert Protocol

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
