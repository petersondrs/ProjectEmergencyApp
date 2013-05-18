
//
//  FacebookLoginViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 23/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "FacebookLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface FacebookLoginViewController ()

@end

@implementation FacebookLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(AppDelegate*) getMainDelegate {
    
    return [[UIApplication sharedApplication] delegate];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    // Do any additional setup after loading the view.
    double delayInSeconds = 3.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,
                                            (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    [self createBlockView:@"Carregando..."];
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self LogarFB];
        [self removeBlockView];
        
    });
    
    
    
    
 }

-(void)removeBlockView
{
    _blockerView.alpha = 0.0;
}


-(void)createBlockView: (NSString*)msg
{
    _blockerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200, 80)];
	_blockerView.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.8];
	_blockerView.center = CGPointMake(self.view.bounds.size.width / 2,
                                      self.view.bounds.size.height / 2);
	_blockerView.clipsToBounds = YES;
	
    [_blockerView.layer setCornerRadius:10.0];
    
	UILabel	*label = [[UILabel alloc] initWithFrame: CGRectMake(0, 5, _blockerView.bounds.size.width, 20)];
	label.text = msg;
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = NSTextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize: 15];
	[_blockerView addSubview: label];
	
	UIActivityIndicatorView	*spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
	
	spinner.center = CGPointMake(_blockerView.bounds.size.width / 2,
                                 _blockerView.bounds.size.height / 2 + 5);
	
    [_blockerView addSubview: spinner];
    
    [self.view addSubview:_blockerView];
    
    [spinner startAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFechar_TouchUpInside:(id)sender {
    AppDelegate* appDelegate = [self getMainDelegate];
    
    NSMutableDictionary* dic = [appDelegate getDictionaryBundleProfile];
    
    [appDelegate.fbSession closeAndClearTokenInformation];
   
    self.rootController.switchFacebook.on = NO;
    
    [dic setObject:@"0" forKey:@"Facebook"];
    
    [appDelegate saveDictionaryBundleProfile:dic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)LogarFB {
    
    AppDelegate* appDelegate = [self getMainDelegate];
    
    NSMutableDictionary* dic = [appDelegate getDictionaryBundleProfile];
   
    [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions",@"publish_checkins"]
                                       defaultAudience:FBSessionDefaultAudienceFriends
                                          allowLoginUI:YES
                                     completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
     {
         
         if (!error)
         {
             self.rootController.switchFacebook.on = YES;
             [dic setObject:@"1" forKey:@"Facebook"];
             [appDelegate saveDictionaryBundleProfile:dic];
             appDelegate.fbSession = session;
             [self dismissViewControllerAnimated:YES completion:nil];
         }
     }];
    

}


@end
