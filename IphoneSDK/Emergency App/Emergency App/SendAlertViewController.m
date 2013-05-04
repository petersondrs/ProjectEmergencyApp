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
{
    CLLocation* currentLocation;
}
@synthesize reach, locationManager;



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
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    
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

//Quando o valor do sinal do telefone mudar, dispara esse evento para atualizar o estado do sinal
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.lblTestSinal setText:@"Testando"];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager startUpdatingLocation];
    });
    
    
}

- (IBAction)UIView_TouchUpInside:(id)sender {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma CCLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"%@",error);
    
    //Desliga o sinal de localização, economia de bateria
    [self.locationManager stopUpdatingLocation];
    
    [self.lblTestGPS setText:@"Error"];
    //[self.imgGPS setImage:[UIImage imageNamed:@"sendScreenIconsSignal.png"]];

}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
   
    [self.lblTestGPS setText:@"Calculando"];
            
    if ([locations count] > 0)
    {
       currentLocation =[locations objectAtIndex:0];
      //[self.imgGPS setImage:[UIImage imageNamed:@"sendScreenIconsSignal.png"]];
        
        CLGeocoder* geoCoder = [[ CLGeocoder alloc] init];
        
        //Transformando a localizaçäo dele
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            if ([placemarks count] > 0)
            {
                UITableViewCell* cellMessage = [[self.tblSendAlert visibleCells] objectAtIndex:0];
                
                if ([[cellMessage.contentView subviews] count] > 0) {
                
                [self.lblTestGPS setText:@"OK"];
                    
                    CLPlacemark* placeMark = [placemarks lastObject];
                    
                    
                    UILabel* label = (UILabel*)[[cellMessage.contentView subviews] objectAtIndex:0];
                    NSLog(@"%@",placeMark.thoroughfare);
                    
                    
                    NSString* localization = [NSString stringWithFormat:@"\nMinha localização é %@, %@ ffsdfsfdfsd",placeMark.thoroughfare, placeMark.administrativeArea];
                    
                    label.text = [NSString stringWithFormat:@"%@ %@", label.text, localization];
                    
                    label.adjustsLetterSpacingToFitWidth = YES;
                    
                    [label sizeToFit];
                    
                    [cellMessage addSubview:label];
                }
                
              
                
            }
            
        }];
        
        
        
    }
    else
    {
        [self.lblTestGPS setText:@"Error"];
        //[self.imgGPS setImage:[UIImage imageNamed:@"sendScreenIconsSignal.png"]];
    }
    
    
    //Desliga o sinal de localização, economia de bateria
    [self.locationManager stopUpdatingLocation];
    
}


#pragma UITableViewDelegate

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(9, 0, tableView.bounds.size.width, 0)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:232.0/255.0
                                                   green:232.0/255.0
                                                    blue:232.0/255.0
                                                   alpha:1.0]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(9, 3, tableView.bounds.size.width, 13)];
    
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
    
    if (indexPath.section == 0)
        return 65;
    
    return 50;
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
                      initWithFrame:CGRectMake(5, 3, cell.bounds.size.width - 5, cell.bounds.size.height + 5)];
    
    [label clipsToBounds];
    label.numberOfLines = 3;
    label.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
    [label setFont:[UIFont systemFontOfSize:12]];
    
    if (indexPath.section == 0)
    {
        label.numberOfLines = 4;
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
        
        if ( [stringBuild length] > 2)
        {
        
            //Retiro o ultimo caracter "-" por nada
            NSRange range = NSMakeRange([stringBuild length] - 2, 1);
            
            [stringBuild replaceCharactersInRange:range withString:@""];
        }

        label.text = stringBuild;
        
    }
    
    //Ajuste do tamanho do label em relação a celula;
    [label sizeToFit];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;	
    [cell.contentView addSubview:label];
    
    return cell;
}
@end
