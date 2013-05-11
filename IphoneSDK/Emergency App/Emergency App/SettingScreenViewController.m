//
//  SettingScreenViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 05/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "SettingScreenViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingScreenViewController ()

@end

@implementation SettingScreenViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setando as aparencias do controles na aplicação
    
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Deselecionando a linha
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}

@end
