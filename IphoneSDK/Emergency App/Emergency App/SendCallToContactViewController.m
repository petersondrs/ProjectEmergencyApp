//
//  SendCallToContactViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 14/05/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "SendCallToContactViewController.h"
#import "AppDelegate.h"

@interface SendCallToContactViewController ()

@end

@implementation SendCallToContactViewController
{
    NSMutableArray* arrayPhone;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(AppDelegate*) getMainAppDelegate {
    return [[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Carrega os contatos e os sms;
    [self carregaPhone];

    
}
- (void)carregaPhone
{
    arrayPhone = [[NSMutableArray alloc] init];
    
    NSMutableDictionary* dicInformation = [[self getMainAppDelegate] getDictionaryBundleContatos];
    
    NSMutableArray* contatosArray = [dicInformation objectForKey:@"Contato"];
    
    for (int i =0; i< [contatosArray count]; i++)
    {
        NSMutableArray* contato = [contatosArray objectAtIndex:i];
        
        if ([[contato objectAtIndex:2] intValue] == 1)
        {
            [arrayPhone addObject:contato];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrayPhone count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray* detailContato = (NSMutableArray*)[arrayPhone objectAtIndex:indexPath.row];
    
    cell.textLabel.text = (NSString*)[detailContato objectAtIndex:0];
    cell.detailTextLabel.text = (NSString*)[detailContato objectAtIndex:1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray* detailContato = (NSMutableArray*)[arrayPhone objectAtIndex:indexPath.row];
    NSString* phoneNumber = (NSString*)[detailContato objectAtIndex:1];
    
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    
    [[UIApplication sharedApplication] openURL:telURL];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (IBAction)btnCancel_TouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
