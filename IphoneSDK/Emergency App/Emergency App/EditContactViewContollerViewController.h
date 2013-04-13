//
//  EditContactViewContollerViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 13/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface EditContactViewContollerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) UITableView *tableContato;
@property (nonatomic) NSInteger editRow;
@property (weak, nonatomic) NSMutableArray* detailContato;

@property (weak, nonatomic)  UITextField* nomeTextField;
@property (weak, nonatomic) UITextField* phoneTextField;
@property (weak, nonatomic) UISwitch* switchSMS;
@property (weak, nonatomic) UISwitch* switchCall;

- (IBAction)btnSalvarContato_TouchUpInside:(id)sender;

@end
