//
//  AppDelegate.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 05/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // SETA A COR DE FUNDO DE TODAS AS TELAS DE NAVEGACAO;
    // Cabecalho
<<<<<<< HEAD
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigator-controller.png"] forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"g_barbutton.png"] forState:UIControlStateNormal  barMetrics:UIBarMetricsDefault];

    
    UIImage *barButtonBgImage = [[UIImage imageNamed:@"g_barbutton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 4, 15, 4)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonBgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
=======
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigator-controller.png"]
                                       forBarMetrics:UIBarMetricsDefault];
>>>>>>> Adiçao dos Botãos de Voltar
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:1.0]];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"g_barbutton.png"]
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    [[UITableView appearance] setBackgroundColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0]];
    
    // Override point for customization after application launch.
    return YES;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[FBSession activeSession] close];
}

@end
