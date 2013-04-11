//
//  ContactViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 06/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
    @property(retain,nonatomic) NSMutableArray* contatos;

- (IBAction)btnAddContact_TouchUpInside:(id)sender;

@end
