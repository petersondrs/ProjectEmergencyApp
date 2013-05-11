//
//  EditContactViewContollerViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 13/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//


#import "EditContactViewController.h"
#import "AppDelegate.h"

@interface EditContactViewController ()

@end

@implementation EditContactViewController

@synthesize nomeTextField, phoneTextField, switchSMS, switchCall, editRow, detailContato;

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

- (void)loadDataContato
{
    self.nomeTextField.text = [self.detailContato objectAtIndex:0];
    self.phoneTextField.text = [self.detailContato objectAtIndex:1];
    self.switchCall.on = [[ self.detailContato objectAtIndex:2] intValue];
    self.switchSMS.on = [[self.detailContato objectAtIndex:3] intValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadDataContato];
    
    [self configuraKeyboard];
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
    [[self getMainDelegate] saveDictionaryBundleContatos:dic];
    
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
