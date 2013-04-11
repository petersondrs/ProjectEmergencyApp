//
//  ContactViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "ContactViewController.h"
#import "AddContactViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"AddContact"])
    {
        ContactViewController* root = (sender);
        AddContactViewController* destination = (AddContactViewController*)[segue destinationViewController];
        destination.tableContato = root.tableView;
    }
    
    
    
}

- (IBAction)btnAddContact_TouchUpInside:(id)sender {
    
    [self performSegueWithIdentifier:@"AddContact" sender:self];
}
@end
