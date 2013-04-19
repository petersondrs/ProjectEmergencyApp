//
//  ProfileViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 14/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UITableViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtSobreNome;
@property (weak, nonatomic) IBOutlet UITextField *txtPais;
@property (weak, nonatomic) IBOutlet UITextView *txtAlergia;
@property (weak, nonatomic) IBOutlet UITextView *txtObs;
@property (retain, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellNascido;

@property (weak, nonatomic) IBOutlet UITableViewCell *cellTipoSanguineo;
@property (weak, nonatomic) IBOutlet UITextView *txtPlanoSaude;


- (IBAction)btnSalvar_TouchUpInside:(id)sender;
@end
