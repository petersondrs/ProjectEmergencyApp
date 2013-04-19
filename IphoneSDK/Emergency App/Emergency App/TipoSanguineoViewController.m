//
//  TipoSanguineoViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 15/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "TipoSanguineoViewController.h"

@interface TipoSanguineoViewController ()

@end

@implementation TipoSanguineoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadPageView
{
    int rowCount = (int)[self.tableView numberOfRowsInSection:0];
    
    for (int i = 0; i < rowCount; i++)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if ([cell.textLabel.text isEqualToString:self.cell.detailTextLabel.text])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPageView];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (UITableViewCell* cell in tableView.visibleCells) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (IBAction)btnSalvar_TouchUpInside:(id)sender {
    BOOL isValid = NO;
    for (UITableViewCell* cell in self.tableView.visibleCells)
    {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            self.cell.detailTextLabel.text = cell.textLabel.text;
            isValid = YES;
        }
        
    }
    
    if (!isValid)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                        message:@"Selecione um tipo sanguineo"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        return;

    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
