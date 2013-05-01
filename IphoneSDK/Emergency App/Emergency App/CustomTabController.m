//
//  CustomTabController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 4/28/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "CustomTabController.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomTabController ()

@end

@implementation CustomTabController

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
	// Do any additional setup after loading the view.
    
    [self topTabBarItem];
    
}

- (UIButton *)createCustomButton:(UIImage *)buttonImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    button.frame = CGRectMake(25, -17, buttonImage.size.width, buttonImage.size.height);
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
   
    return button;
}

-(void) topTabBarItem
{
    
    UIImage* buttonImage = [UIImage imageNamed:@"tabBatButtonsSendNormal.png"];
    NSArray* tabViews = [self.tabBar subviews];
    
    int index = 0;
    
    for (UIView* view in tabViews)
    {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            UIButton *button;
            button = [self createCustomButton:buttonImage];
            button.tag = index;
            [button addTarget:self action:@selector(btnCustomButton_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [button sizeToFit];
            [view addSubview:button];
            index++;
        }
        
    }
    
}

-(void) btnCustomButton_TouchUpInside:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    self.selectedIndex = btn.tag;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
