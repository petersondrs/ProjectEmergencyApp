//
//  InformationViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/15/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblInfo;

@end
