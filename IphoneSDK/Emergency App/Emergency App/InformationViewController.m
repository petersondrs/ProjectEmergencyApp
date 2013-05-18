//
//  InformationViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/15/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "InformationViewController.h"
#import "AppDelegate.h"

@interface InformationViewController ()

@end

@implementation InformationViewController
{
    NSDictionary* profileDic;
}


-(AppDelegate*) getMainAppDelegate {
    
    return [[UIApplication sharedApplication] delegate];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tblInfo.scrollEnabled = NO;
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    profileDic = [[self getMainAppDelegate] getDictionaryBundleProfile];
    
   [self.tblInfo reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:232.0/255.0
                                                   green:232.0/255.0
                                                    blue:232.0/255.0
                                                   alpha:1.0]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(7, 4, tableView.bounds.size.width, 13)];
    
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    
    if (section == 0)
        label.text = @"DADOS PESSOAIS";
    else if (section == 1)
        label.text = @"ALERGIAS";
    else if (section == 2)
        label.text = @"PLANO DE SAÚDE";
    else if (section == 3)
        label.text = @"OBSERVAÇÕES";
    
    [headerView addSubview:label];
    
    return headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1)
        return 60;
    else if (indexPath.section == 2)
        return 60;
    else if (indexPath.section == 3)
        return 100;
        
    return 70;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    UILabel* label = [[UILabel alloc]
                      initWithFrame:CGRectMake(5, 2, cell.bounds.size.width - 5, cell.bounds.size.height + 5)];
    
    [label clipsToBounds];
    label.numberOfLines = 4;
    label.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
    [label setFont:[UIFont systemFontOfSize:12]];
    
    
    if (indexPath.section == 0)
    {
        NSMutableString* stringBuild = [[NSMutableString alloc] init];
        
        if ([profileDic objectForKey:@"SobreNome"] != nil && ![[profileDic objectForKey:@"SobreNome"] isEqualToString:@""])
            [stringBuild appendFormat:@"Nome: %@%@ \r", [profileDic objectForKey:@"Nome"], [profileDic objectForKey:@"SobreNome"]];
        else if ([profileDic objectForKey:@"Nome"] != nil && ![[profileDic objectForKey:@"Nome"] isEqualToString:@""])
            [stringBuild appendFormat:@"Nome: %@ \r", [profileDic objectForKey:@"Nome"]];
        
        if ([profileDic objectForKey:@"DataNascimento"] != nil && ![[profileDic objectForKey:@"DataNascimento"] isEqualToString:@""])
            [stringBuild appendFormat:@"Data de Nascimento: %@ \r", [profileDic objectForKey:@"DataNascimento"]];
        
        if ([profileDic objectForKey:@"TipoSanguineo"] != nil && ![[profileDic objectForKey:@"TipoSanguineo"] isEqualToString:@""])
            [stringBuild appendFormat:@"Tipo Sanguineo: %@", [profileDic objectForKey:@"TipoSanguineo"]];

        label.text = stringBuild;
        
    }
    if (indexPath.section == 1)
    {
        if ([profileDic objectForKey:@"Alergia"] != nil)
            label.text = [NSString stringWithFormat:@"%@",[profileDic objectForKey:@"Alergia"]];
    }
    if (indexPath.section == 2)
    {
        if ([profileDic objectForKey:@"PlanoSaude"] != nil)
            label.text = [NSString stringWithFormat:@"%@",[profileDic objectForKey:@"PlanoSaude"]];
    }
    if (indexPath.section == 3)
    {
        if ([profileDic objectForKey:@"Obs"] != nil)
            label.text = [NSString stringWithFormat:@"%@",[profileDic objectForKey:@"Obs"]];
    }

    [label sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:label];
    
    return cell;
}
@end
