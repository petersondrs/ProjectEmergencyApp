//
//  SendAlertViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/1/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "SendAlertViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Reachability.h"

@interface SendAlertViewController ()

@end

@implementation SendAlertViewController

@synthesize reach;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(AppDelegate*) getMainAppDelegate {
 
    return [[UIApplication sharedApplication] delegate];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    reach = [Reachability reachabilityForInternetConnection];
    
    [self.reach startNotifier];
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    
    
}



-(void) viewWillAppear:(BOOL)animated
{
    [self.tblSendAlert reloadData]; //recarrega as informações caso o usuário tenha feito algume alteração
    
    [self testFeatureIPhone];
}

//Metodo para verificar o sinal do telefone
-(void)getSignalCarrierPhone: (Reachability*) reachability {
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == NotReachable)
    {
        [self.lblTestSinal setText:@"Sem Sinal"];
        [self.imgSinal setImage:[UIImage imageNamed:@"sendScreenIconsSignal.png"]];
    }
    else
    {
        [self.lblTestSinal setText:@"OK"];
        [self.imgSinal setImage:[UIImage imageNamed:@"sendScreenIconsSignal.png"]];
    }
    
    if ([reachability connectionRequired])
    {
        [self.lblTestSinal setText:@"Testando"];
        
    }
}

-(void)reachabilityChanged: (NSNotification*) notification
{
    Reachability* reachNote = [notification object];
    
    [self getSignalCarrierPhone:reachNote];
    
}

//Metodo para testar os sinal do telefone, gps e outras
-(void) testFeatureIPhone {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getSignalCarrierPhone: reach];

    });
    
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
    
    [headerView setBackgroundColor:[UIColor colorWithRed:232.0/255.0
                                                   green:232.0/255.0
                                                    blue:232.0/255.0
                                                   alpha:1.0]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(9, 2, tableView.bounds.size.width, 13)];
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


#pragma UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSMutableDictionary* dicInformation;
    
    UILabel* label = [[UILabel alloc]
                      initWithFrame:CGRectMake(5, 2, cell.bounds.size.width - 5, cell.bounds.size.height + 5)];
    
    [label clipsToBounds];
    
    label.numberOfLines = 3;
    label.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
    [label setFont:[UIFont systemFontOfSize:13]];
    
    if (indexPath.section == 0)
    {
        dicInformation = [[self getMainAppDelegate] getDictionaryBundleProfile];
        
        label.text = [dicInformation objectForKey:@"MessageAlert"];
        
    }
    else if (indexPath.section == 1 || indexPath.section == 2)
    {
        dicInformation = [[self getMainAppDelegate] getDictionaryBundleContatos];
        
        NSMutableArray* contatosArray = [dicInformation objectForKey:@"Contato"];
        NSMutableString* stringBuild = [[NSMutableString alloc] init];
        
        for (int i =0; i< [contatosArray count]; i++)
        {
            NSMutableArray* contato = [contatosArray objectAtIndex:i];
            
            if (indexPath.section == 1) //caso seja destinarios leio somente a parte de sms
            {
                if ([[contato objectAtIndex:3] intValue] == 1)
                {
                    [stringBuild appendString:[NSString stringWithFormat:@"%@ - ",[contato objectAtIndex:0]]];
                }
            }
            else // caso seja ligacao leio somente a parte de ligação
            {
                if ([[contato objectAtIndex:2] intValue] == 1)
                {
                    [stringBuild appendString:[NSString stringWithFormat:@"%@ - ",[contato objectAtIndex:0]]];
                }
            }
        }
        
        //Retiro o ultimo caracter "-" por nada
        NSRange range = NSMakeRange([stringBuild length] - 2, 1);
    
        [stringBuild replaceCharactersInRange:range withString:@""];

        label.text = stringBuild;
        
    }
    
    //Ajuste do tamanho do label em relação a celula;
    [label sizeToFit];
    [cell.contentView addSubview:label];
    
    return cell;
}
@end
