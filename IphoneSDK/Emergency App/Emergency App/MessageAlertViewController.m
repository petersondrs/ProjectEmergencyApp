//
//  MessageAlertViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 4/28/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "MessageAlertViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


@interface MessageAlertViewController ()

@end

@implementation MessageAlertViewController

const NSInteger count = 120;

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
	// Do any additional setup after loading the view.
    
    [self configureControls];
}



-(void) configureControls {
    
    [self.txtMensagem.layer setCornerRadius:8.0];
    [self.txtMensagem.layer setBorderWidth:1.0];
    [self.txtMensagem.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.txtMensagem.layer setBorderWidth:1.3];
    [self.txtMensagem.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [self.txtMensagem clipsToBounds];
    
    
    //Pegando conteudo salvo anteriormente
    NSMutableDictionary* dic = [[self getMainDelegate] getDictionaryBundleProfile];
    self.txtMensagem.text = [dic objectForKey:@"MessageAlert"];
    
    //Calculando quanto resta de caracter para o usuario
    self.lblWordCount.text = [NSString stringWithFormat:@"Caracteres: %u", count - [self.txtMensagem.text length]];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSalvar_TouchUpInside:(id)sender {
    
    NSMutableDictionary* dic = [[self getMainDelegate] getDictionaryBundleProfile];
    
    [dic setObject:self.txtMensagem.text forKey:@"MessageAlert"];
    
    [[self getMainDelegate] saveDictionaryBundleProfile:dic];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma UITextView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
  
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [self.view endEditing:YES];
    }
    else
    {
        NSString* textComplete = [textView.text stringByReplacingCharactersInRange:range withString:text];
        
        if ([textComplete length] > count)
            return NO;
        
        self.lblWordCount.text = [NSString stringWithFormat:@"Caracteres: %u", count - [textComplete length]];
        
        
        
    }
    return YES;
}



@end
