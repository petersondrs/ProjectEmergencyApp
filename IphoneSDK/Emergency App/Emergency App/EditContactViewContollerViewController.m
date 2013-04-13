//
//  EditContactViewContollerViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 13/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "EditContactViewContollerViewController.h"

@interface EditContactViewContollerViewController ()

@end

@implementation EditContactViewContollerViewController

@synthesize nomeTextField, phoneTextField, switchSMS, switchCall, editRow, detailContato;

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


- (BOOL)validateView {
    
    UIAlertView *alertErro;
    
    if ([nomeTextField.text isEqual: @""] || nomeTextField.text == nil)
    {
        alertErro = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                               message:@"Preencha o nome do contato"
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
        [alertErro show];
        return NO;
    }
    
    if ([phoneTextField.text isEqual: @""] || phoneTextField.text == nil)
    {
        alertErro = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                               message:@"Preencha o telefone do contato"
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
        
        [alertErro show];
        return NO;
        
    }
    
    if (self.switchCall.isOn == NO && self.switchSMS.isOn == NO)
    {
        alertErro = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                               message:@"Escolha pelo menos uma forma de contato"
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
        [alertErro show];
        return NO;
        
        
    }
    
    return YES;
}

- (IBAction)btnSalvarContato_TouchUpInside:(id)sender {
    
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"Contatos" ofType:@"plist"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithContentsOfFile:bundle];
    
    //Le o array ja gravado para se manter os antigos registros
    NSMutableArray* arrContato = [dic valueForKey:@"Contato"];
    
    bool sendSMS = (self.switchSMS.isOn ? YES : NO);
    bool sendCall = (self.switchCall.isOn ? YES : NO);
    
    if(![self validateView])
        return;
    
    //Cria o novo contato
    NSMutableArray* editContato = [[NSMutableArray alloc] initWithObjects:self.nomeTextField.text
                                   ,self.phoneTextField.text
                                   ,[NSNumber numberWithBool:sendCall]
                                   ,[NSNumber numberWithBool:sendSMS]
                                   , nil];
    //Adiciona o novo contato
    [arrContato setObject:editContato atIndexedSubscript:self.editRow];
    
    //Grava os novos valores no dicionario
    [dic setObject:arrContato forKey:@"Contato"];
    
    //Escreve no arquivo o contato
    [dic writeToFile:bundle atomically:YES];
    
    [self.tableContato reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (NSString*)formatPhone:(NSString *)text
{
    
    NSString* textFormat;
    
    textFormat = text;
    
    if ([[text substringToIndex:1] isEqual: @"0"])
    {
        if ([text length] >= 13)
        {
            textFormat = [NSString stringWithFormat:@"(%@ %@) %@",
                          [text substringToIndex:3],
                          [text substringWithRange:NSMakeRange(3, 2)],
                          [text substringWithRange:NSMakeRange(5, [text length]-5)]
                          ];
        }
    }
    else
    {
        if ([text length] >= 10)
        {
            textFormat = [NSString stringWithFormat:@"(%@) %@",
                          [text substringToIndex:2],
                          [text substringWithRange:NSMakeRange(2, [text length]-2)]
                          ];
        }
        
    }
    
    return textFormat;
}

-(void) btnDone_TouchUpInside
{
    if ([self.phoneTextField.text isEqual:@""] || self.phoneTextField.text == nil)
    {
        [self.phoneTextField resignFirstResponder];
        return;
    }
    
    
    self.phoneTextField.text = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@"(" withString:@""];
    self.phoneTextField.text = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@")" withString:@""];
    self.phoneTextField.text = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.phoneTextField.text = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.phoneTextField.text = [self formatPhone:self.phoneTextField.text];
    
    [self.phoneTextField resignFirstResponder];
}


#pragma UITableViewDataSource Protocol

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    CGRect aRect;
    UIToolbar* numberBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    if (indexPath.section == 0)
    {
        
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:@"CellIdentifier"];
        
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        UISwitch* uiSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Nome";
                aRect = CGRectMake(70, 11, 223, 31.f );
                textField.keyboardType = UIKeyboardTypeDefault;
                textField.returnKeyType = UIReturnKeyNext;
                textField.tag = indexPath.row;
                textField.frame = aRect;
                textField.delegate = self;
                textField.textColor = cell.detailTextLabel.textColor;
                textField.text = [self.detailContato objectAtIndex:0];
                textField.enabled = NO;
                
                self.nomeTextField = textField;
                
                [cell.contentView addSubview:textField];
                break;
            case 1:
                cell.textLabel.text = @"Telefone";
                aRect = CGRectMake(95, 11, 200, 31.f );
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.returnKeyType = UIReturnKeyDone;
                textField.tag = indexPath.row;
                textField.frame = aRect;
                textField.delegate = self;
                textField.textColor = cell.detailTextLabel.textColor;
                textField.text = [self.detailContato objectAtIndex:1];
                
                numberBar.barStyle = UIBarStyleBlackOpaque;
                numberBar.items = [NSArray arrayWithObjects:[
                                                             [UIBarButtonItem alloc]
                                                             initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                             target:nil
                                                             action:nil]
                                   ,[
                                     [UIBarButtonItem alloc]
                                     initWithTitle:@"Done"
                                     style:UIBarButtonItemStyleDone
                                     target:self
                                     action:@selector(btnDone_TouchUpInside)]
                                   ,nil];
                
                
                [numberBar sizeToFit];
                
                textField.inputAccessoryView = numberBar;
                
                self.phoneTextField = textField;
                
                [cell.contentView addSubview:textField];
                break;
            case 2:
                cell.textLabel.text = @"Efetuar Ligação";
                aRect = CGRectMake(210, 10, 0, 0 );
                uiSwitch.frame = aRect;
                self.switchCall = uiSwitch;
                uiSwitch.on = [[self.detailContato objectAtIndex:2] intValue];
                [cell.contentView addSubview:uiSwitch];
                
                break;
            case 3:
                cell.textLabel.text = @"Enviar SMS";
                aRect = CGRectMake(210, 10, 0, 0 );
                uiSwitch.frame = aRect;
                uiSwitch.on = [[self.detailContato objectAtIndex:3] intValue];
                self.switchSMS = uiSwitch;
                [cell.contentView addSubview:uiSwitch];
                break;
        }
        
        
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}



#pragma Text Field Protocol

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextTextField = [self.view viewWithTag:textField.tag + 1];
    
    if (nextTextField)
    {
        [nextTextField becomeFirstResponder];
    }
    
    return YES;
}


@end
