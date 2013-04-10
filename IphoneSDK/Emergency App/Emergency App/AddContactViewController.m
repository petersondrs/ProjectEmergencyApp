//
//  AddContactViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "AddContactViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AddContactViewController ()

@end

@implementation AddContactViewController

@synthesize nomeTextField, phoneTextField, switchSMS, switchCall;

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


- (IBAction)btnSalvarContato_TouchUpInside:(id)sender {
    
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"Contatos" ofType:@"plist"];
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithContentsOfFile:bundle];
    
    //Le o array ja gravado para se manter os antigos registros
    NSMutableArray* arrContato = [dic valueForKey:@"Contato"];
    
    bool sendSMS = (self.switchSMS.isOn ? YES : NO);
    bool sendCall = (self.switchCall.isOn ? YES : NO);
    
    //Cria o novo contato
    NSMutableArray* novoContato = [[NSMutableArray alloc] initWithObjects:self.nomeTextField.text
                                                                         ,self.phoneTextField.text
                                                                         ,[NSNumber numberWithBool:sendSMS]
                                                                         ,[NSNumber numberWithBool:sendCall]
                                                                         , nil];
    //Adiciona o novo contato
    [arrContato addObject:novoContato];
    
    //Grava os novos valores no dicionario
    [dic setObject:arrContato forKey:@"Contato"];
    
    //Escreve no arquivo o contato
    [dic writeToFile:bundle atomically:YES];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                    message:@"Contato Salvo.\nDeseja adicionar mais contatos?"
                                                   delegate:self
                                          cancelButtonTitle:@"Sim"
                                          otherButtonTitles:@"Não", nil];
    
    [alert show];
    
}


- (IBAction)btnImportarContato_TouchUpInside:(id)sender {
    
    //Criando o controller de contato
    ABPeoplePickerNavigationController* picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (NSString*)formatPhone:(NSString *)text
{
    NSRange range = NSMakeRange(2, 4);
    
    
    NSString* textFormat = [NSString stringWithFormat:@"(%@) %@-%@",
                            [text substringToIndex:2],
                            [text substringWithRange:range],
                            [text substringFromIndex:6]];
    
    return textFormat;
}

#pragma UIAlert Protocol

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
       
    if (buttonIndex == 0){
        
        self.nomeTextField.text = @"";
        self.phoneTextField.text = @"";
        self.switchCall.on = NO;
        self.switchSMS.on = NO;
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma UITableViewDataSource Protocol

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    CGRect aRect;
   
                                                               
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"CellIdentifier"];
    
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UISwitch* uiSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Nome:";
            aRect = CGRectMake(70, 11, 223, 31.f );
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyNext;
            textField.tag = indexPath.row;
            textField.frame = aRect;
            textField.delegate = self;
            textField.textColor = cell.detailTextLabel.textColor;
            
            self.nomeTextField = textField;
            
            [cell.contentView addSubview:textField];
            break;
        case 1:
            cell.textLabel.text = @"Telefone:";
            aRect = CGRectMake(95, 11, 200, 31.f );
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.returnKeyType = UIReturnKeyDone;
            textField.tag = indexPath.row;
            textField.frame = aRect;
            textField.delegate = self;
            textField.textColor = cell.detailTextLabel.textColor;
            
            self.phoneTextField = textField;
            
            [cell.contentView addSubview:textField];
            break;
        case 2:
            cell.textLabel.text = @"Efetuar Ligação:";
            aRect = CGRectMake(210, 10, 0, 0 );
            
            uiSwitch.frame = aRect;
            
            self.switchCall = uiSwitch;
            
            [cell.contentView addSubview:uiSwitch];
            
            break;
        case 3:
            cell.textLabel.text = @"Enviar SMS:";
            aRect = CGRectMake(210, 10, 0, 0 );
            uiSwitch.frame = aRect;
            
            self.switchSMS = uiSwitch;
            
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


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1)
    {
        NSString* text = [textField.text stringByReplacingCharactersInRange:range
                                                                withString:string];
        text = [text stringByReplacingOccurrencesOfString:@"(" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@")" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([text length] == 10)
        {
            textField.text = [self formatPhone:text];
            [textField resignFirstResponder];
        }
        else if ([text length] > 10)
        {
            [textField resignFirstResponder];
            return NO;
        }
        
    }
    
    return YES;
    
}

#pragma Address Book Protocol

-(void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

-(BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    
    //Pegando o nome do contato
    NSString* nome = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    if (![lastName isEqual: @""])
        nome = [NSString stringWithFormat:@"%@ %@", nome, lastName];
    
    //pegando o telefone do contato
    ABMultiValueRef phoneNumbers =  ABRecordCopyValue(person, kABPersonPhoneProperty);

    NSString* phone;
    
    if (ABMultiValueGetCount(phoneNumbers) > 0){
        phone = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    }
    
    self.nomeTextField.text = nome;
    self.phoneTextField.text = phone;
    self.switchSMS.on = NO;
    self.switchCall.on = NO;
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    return  NO;
    
}
@end
