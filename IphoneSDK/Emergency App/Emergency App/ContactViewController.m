//
//  ContactViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "ContactViewController.h"
#import "AddContactViewController.h"
#import "EditContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

@synthesize contatos;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadData
{
    //Carrega os contato já gravados
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"Contatos" ofType:@"plist"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithContentsOfFile:bundle];
    
    //Le o array ja gravado para se manter os antigos registros
    contatos = [dic valueForKey:@"Contato"];
}

- (void)gravaListaContatos
{
    //grava a alteração na plist
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"Contatos" ofType:@"plist"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithContentsOfFile:bundle];
    [dic setObject:contatos forKey:@"Contato"];
    [dic writeToFile:bundle atomically:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma UITableViewController Protocol

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Done"
                                              style:(UIBarButtonItemStyleDone)
                                              target:self action:@selector(cancelTableEdit)];
}
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self cancelTableEdit];
    
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [contatos removeObjectAtIndex:indexPath.row];
        
        [self gravaListaContatos];

        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
      
        [tableView endUpdates];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [self loadData];
    
    return [contatos count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellContato"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:@"cellContato"];
    }
    
    NSMutableArray* detailContato = (NSMutableArray*)[contatos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = (NSString*)[detailContato objectAtIndex:0];
    cell.detailTextLabel.text = (NSString*)[detailContato objectAtIndex:1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"EditContact" sender:indexPath];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelTableEdit{
    self.tableView.editing = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                              action:@selector(btnAddContact_TouchUpInside:)];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"AddContact"])
    {
        AddContactViewController* destination = (AddContactViewController*)[segue destinationViewController];
        destination.tableContato = self.tableView;
    }
    else if ([segue.identifier isEqualToString:@"EditContact"])
    {
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        
        EditContactViewController* destination = (EditContactViewController*)[segue destinationViewController];
        destination.tableContato = self.tableView;
        destination.editRow = indexPath.row;
        destination.detailContato = [contatos objectAtIndex:indexPath.row];
    }
    
}

- (IBAction)btnAddContact_TouchUpInside:(id)sender {
    
    [self performSegueWithIdentifier:@"AddContact" sender:self];
}
@end
