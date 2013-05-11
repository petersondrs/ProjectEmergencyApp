//
//  NascidoViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 15/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "NascidoViewController.h"

@interface NascidoViewController ()

@end

@implementation NascidoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (IBAction)btnSalvar_TouchUpInside:(id)sender {
    
    UITableViewCell* cell = [[self.tblNascido visibleCells] objectAtIndex:0];
    
    if (![cell.textLabel.text isEqualToString:@"Selecione uma data"])
    {
        self.cell.detailTextLabel.text = cell.textLabel.text;
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                        message:@"Selecione uma data"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        return;

        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma UITableView Protocol

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    
    
    if ([self.cell.detailTextLabel.text isEqualToString:@""])
    {
        cell.textLabel.text = @"Selecione uma data";
        
    }
    else
    {
        cell.textLabel.text = self.cell.detailTextLabel.text;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM yyyy"];
        self.datePicker.date = [formatter dateFromString:self.cell.detailTextLabel.text];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (IBAction)datePickerChanged:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    
    UIDatePicker* picker = (UIDatePicker*)sender;
    
    UITableViewCell* cell = [[self.tblNascido visibleCells] objectAtIndex:0];
    
    cell.textLabel.text = [formatter stringFromDate: picker.date];
    
    
}
@end
