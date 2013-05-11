//
//  AddContactViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactViewController.h"

@interface AddContactViewController : UITableViewController<UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate, UIAlertViewDelegate>
@property(retain,nonatomic) UITableView* tableContato;

@property (weak, nonatomic) IBOutlet UITextField *nomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchCall;
@property (weak, nonatomic) IBOutlet UISwitch *switchSMS;

- (IBAction)btnSalvarContato_TouchUpInside:(id)sender;

- (void)btnImportarContato_TouchUpInside;

@end
