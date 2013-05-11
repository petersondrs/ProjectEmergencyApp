//
//  MessageAlertViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 4/28/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageAlertViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtMensagem;
- (IBAction)btnSalvar_TouchUpInside:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblWordCount;

@end
