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

- (UIButton *)createCustomButton:(UIImage *)buttonImage buttonHighlight:(UIImage*) buttonHighlight
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);

    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonHighlight forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(btnCustomButton_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
   
    return button;
}

-(void) topTabBarItem
{
    
    
    NSArray* arrayImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabBatButtonsInfoNormal.png"],
                                                     [UIImage imageNamed:@"tabBatButtonsSendNormal.png"],
                                                     [UIImage imageNamed:@"tabBatButtonsSettingsNormal.png"],
                                                     nil];
    
    
    NSArray* arrayImagesHighlight = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabBatButtonsInfoPressed.png"],
                                                              [UIImage imageNamed:@"tabBatButtonsSendPressed.png"],
                                                              [UIImage imageNamed:@"tabBatButtonsSettingsPressed.png"],
                                                     nil];

    
    
    for(int index = 0; index < [arrayImages count]; index ++)
    {
        UIButton *button;
        
        UIImage* buttonImage = [arrayImages objectAtIndex:index];
        UIImage* buttonHighlight = [arrayImagesHighlight objectAtIndex:index];
        
        button = [self createCustomButton:buttonImage buttonHighlight:buttonHighlight];
        button.tag = index;
        
        
        CGPoint center = self.tabBar.center;
        center.y = center.y - 20;
        
        //Não precisamos alinhar o center.x no index 1, pois ele já é o centro
        
        if (index == 0)
        {
            center.x = 52;
        }
        else if (index == 2)
        {
            center.x = center.x + 105;
        }
        
        button.center = center;
        
        [self.view addSubview:button];
      
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
