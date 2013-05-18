//
//  ProfileEditNomeViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/18/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileEditNomeViewController : UIViewController<UITextViewDelegate>

- (IBAction)btnSalvar_TouchUpInside:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtNome;
@property (weak,nonatomic) UITableViewCell* cellNome;
@end
