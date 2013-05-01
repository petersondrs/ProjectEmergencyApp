//
//  SendAlertViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/1/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "SendAlertViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SendAlertViewController ()

@end

@implementation SendAlertViewController

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
    
  }
- (IBAction)UIView_TouchUpInside:(id)sender {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableViewDelegate

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(9, 0, tableView.bounds.size.width, 0)];
    
    [headerView setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(9, 5, tableView.bounds.size.width, 13)];
    
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    
    
    
    if (section == 0)
        label.text = @"MENSAGEM";
    else if (section == 1)
        label.text = @"DESTINATÁRIOS";
    else
        label.text = @"LIGAR PARA";
    
    [headerView addSubview:label];
    
    return headerView;
}



#pragma UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    
    return cell;
}
@end
