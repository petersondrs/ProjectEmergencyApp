//
//  SendAlertViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/1/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendAlertViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewTestFeature;

@property (weak, nonatomic) IBOutlet UIView *uiViewSendAlert;

- (IBAction)UIView_TouchUpInside:(id)sender;

@end
