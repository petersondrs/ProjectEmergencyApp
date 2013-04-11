//
//  AddContactViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AddContactViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableContato;


@property (weak,nonatomic)  UITextField* nomeTextField;
@property (weak, nonatomic) UITextField* phoneTextField;
@property (weak, nonatomic) UISwitch* switchSMS;
@property (weak, nonatomic) UISwitch* switchCall;

- (IBAction)btnSalvarContato_TouchUpInside:(id)sender;

- (void)btnImportarContato_TouchUpInside;

@end
