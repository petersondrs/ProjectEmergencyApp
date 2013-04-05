//
//  SplashScreenViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 05/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[NSTimer scheduledTimerWithTimeInterval:3.0
                            target:self
                          selector:@selector(showMainApplication)
                          userInfo:nil
                           repeats:NO];
}

-(void)showMainApplication
{
    [self performSegueWithIdentifier:@"MainApplication" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
