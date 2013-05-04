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
#import "AppDelegate.h"

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

-(AppDelegate*) getMainDelegate {
    return [[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configuraKeyboard];
    
     // Do any additional setup after loading the view.
}

-(void)configuraKeyboard {
    UIToolbar* numberBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberBar.barStyle = UIBarStyleBlackOpaque;
    numberBar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                 target:nil
                                                 action:nil],
                                                [[UIBarButtonItem alloc]
                                                 initWithTitle:@"Done"
                                                 style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(btnDone_TouchUpInside)]
                                                ,nil];
    
    
    [numberBar sizeToFit];
    
    self.phoneTextField.inputAccessoryView = numberBar;

    
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
    
    
    NSMutableDictionary* dic = [[self getMainDelegate] getDictionaryBundleContatos];
    
    //Le o array ja gravado para se manter os antigos registros
    NSMutableArray* arrContato = [dic valueForKey:@"Contato"];
    
    bool sendSMS = (self.switchSMS.isOn ? YES : NO);
    bool sendCall = (self.switchCall.isOn ? YES : NO);
    
    if(![self validateView])
        return;
    
    //Cria o novo contato
    NSMutableArray* novoContato = [[NSMutableArray alloc] initWithObjects:self.nomeTextField.text
                                                                         ,self.phoneTextField.text
                                                                         ,[NSNumber numberWithBool:sendCall]
                                                                         ,[NSNumber numberWithBool:sendSMS]
                                                                         , nil];
    //Adiciona o novo contato
    [arrContato addObject:novoContato];
    
    //Grava os novos valores no dicionario
    [dic setObject:arrContato forKey:@"Contato"];
    
    //Escreve no arquivo o contato
    [[self getMainDelegate] saveDictionaryBundleContatos:dic];
    
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                    message:@"Contato Salvo.\nDeseja adicionar mais contatos?"
                                                   delegate:self
                                          cancelButtonTitle:@"Sim"
                                          otherButtonTitles:@"Não", nil];
    
    [alert show];
    
    [self.tableContato reloadData];
    
}


- (void)btnImportarContato_TouchUpInside {
    
    //Criando o controller de contato
    ABPeoplePickerNavigationController* picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
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

    
    
    self.phoneTextField.text = [self formatPhone:self.phoneTextField.text];
    
    [self.phoneTextField resignFirstResponder];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self btnImportarContato_TouchUpInside];
    }
    
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
    
    if (lastName != nil && ![lastName isEqual: @""])
        nome = [NSString stringWithFormat:@"%@ %@", nome, lastName];
    
    //pegando o telefone do contato
    ABMultiValueRef phoneNumbers =  ABRecordCopyValue(person, kABPersonPhoneProperty);

    NSString* phone;
    
    if (ABMultiValueGetCount(phoneNumbers) > 0){
        phone = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    }
    
    
    phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phone = [self formatPhone:phone];
    
    
    
    self.nomeTextField.text = nome;
    self.phoneTextField.text = phone;
    self.switchSMS.on = YES;
    self.switchCall.on = YES;
    
    
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    return  NO;
    
}
@end
