//
//  AddContactViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableContato;

- (IBAction)btnSalvarContato_TouchUpInside:(id)sender;

- (IBAction)btnSalvarContatoEContinuar_TouchUpInside:(id)sender;

@end
