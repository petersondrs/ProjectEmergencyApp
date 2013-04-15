//
//  NascidoViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 15/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NascidoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)btnSalvar_TouchUpInside:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblNascido;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak,nonatomic) UITableViewCell* cell;

- (IBAction)datePickerChanged:(id)sender;

@end
