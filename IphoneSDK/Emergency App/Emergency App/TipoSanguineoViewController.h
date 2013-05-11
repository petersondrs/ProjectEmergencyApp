//
//  TipoSanguineoViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 15/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipoSanguineoViewController : UITableViewController
@property (weak,nonatomic) UITableViewCell* cell;

- (IBAction)btnSalvar_TouchUpInside:(id)sender;

@end
