//
//  ServiceTermViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 14/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTermViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblService;

@end
