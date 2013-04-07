//
//  AddContactViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "AddContactViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AddContactViewController ()

@end

@implementation AddContactViewController

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
    
    //self.tableContato
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableViewDataSource Protocol

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    CGRect aRect;
   
                                                               
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"CellIdentifier"];
    
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UISwitch* uiSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Nome";
            aRect = CGRectMake(62, 10, 233, 31.f );
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyNext;
            textField.tag = indexPath.row;
            textField.frame = aRect;
            textField.delegate = self;
            [cell.contentView addSubview:textField];
            break;
        case 1:
            cell.textLabel.text = @"Telefone";
            aRect = CGRectMake(85, 10, 210, 31.f );
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.returnKeyType = UIReturnKeyDone;
            textField.tag = indexPath.row;
            textField.frame = aRect;
            textField.delegate = self;
            [cell.contentView addSubview:textField];
            break;
        case 2:
            cell.textLabel.text = @"Efetuar Ligação";
            aRect = CGRectMake(210, 10, 0, 0 );
            
            uiSwitch.frame = aRect;
            [cell.contentView addSubview:uiSwitch];
            
            break;
        case 3:
            cell.textLabel.text = @"Enviar SMS";
            aRect = CGRectMake(210, 10, 0, 0 );
            uiSwitch.frame = aRect;
            [cell.contentView addSubview:uiSwitch];
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Numero de linhas da tabela.
    return 4;
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextTextField = [self.view viewWithTag:textField.tag + 1];
    
    if (nextTextField)
    {
        [nextTextField becomeFirstResponder];
    }
    else
    {
        [nextTextField resignFirstResponder];
    }
    
    return NO;

}









- (IBAction)btnSalvarContato_TouchUpInside:(id)sender {
}

- (IBAction)btnSalvarContatoEContinuar_TouchUpInside:(id)sender {
}
@end
