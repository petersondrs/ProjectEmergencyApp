//
//  ProfileEditNomeViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/18/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "ProfileEditNomeViewController.h"

@interface ProfileEditNomeViewController ()

@end

@implementation ProfileEditNomeViewController

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
    [self.txtNome becomeFirstResponder];
    
    self.txtNome.text = self.cellNome.detailTextLabel.text;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        self.cellNome.detailTextLabel.text = self.txtNome.text;
        [self.navigationController popViewControllerAnimated:YES];
    }
    return YES;
}


- (IBAction)btnSalvar_TouchUpInside:(id)sender {
    NSLog(@"%@",self.txtNome.text);
    self.cellNome.detailTextLabel.text = self.txtNome.text;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
