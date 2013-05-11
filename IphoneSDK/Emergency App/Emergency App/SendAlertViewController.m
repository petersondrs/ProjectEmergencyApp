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
#import <MessageUI/MessageUI.h>
#import <CoreTelephony/CTCall.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SendAlertViewController ()

@end

@implementation SendAlertViewController
{
    CLLocation* currentLocation;
    UILabel* messageLocation;
    NSMutableArray* arraySMS;
    NSMutableArray* arrayPhone;
    CLPlacemark* currentPlaceMark;
   
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

- (void)carregaContatosESMS
{
    arrayPhone = [[NSMutableArray alloc] init];
    arraySMS = [[NSMutableArray alloc] init];
    
    
    NSMutableDictionary* dicInformation = [[self getMainAppDelegate] getDictionaryBundleContatos];
    
    NSMutableArray* contatosArray = [dicInformation objectForKey:@"Contato"];
    
    for (int i =0; i< [contatosArray count]; i++)
    {
        NSMutableArray* contato = [contatosArray objectAtIndex:i];
        
        if ([[contato objectAtIndex:3] intValue] == 1)
        {
            [arraySMS addObject:contato];
        }
        
        if ([[contato objectAtIndex:2] intValue] == 1)
        {
            [arrayPhone addObject:contato];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    reach = [Reachability reachabilityForInternetConnection];
    [self.reach startNotifier];
   
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self.locationManager setDistanceFilter: 10.0f];
    
  
    //obsevador para calcular o sinal do telefone
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    
    //Carrega os contatos e os sms;
    [self carregaContatosESMS];
    
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
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
        [self.lblTestGPS setText:@"Testando"];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager startUpdatingLocation];
    });
    
    
}

- (IBAction)BtnRefresh_TouchUpInside:(id)sender {
    
   [self getSignalCarrierPhone: reach];
   [self.locationManager startUpdatingLocation];

    
}

- (void)sendSMS {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MFMessageComposeViewController* controller = [[MFMessageComposeViewController alloc] init];
        NSMutableArray* recipients = [[NSMutableArray alloc] init];
        
        for (NSArray* contatoSMS in arraySMS) {
            [recipients addObject:[contatoSMS objectAtIndex:1]];
        }
        
        if ([MFMessageComposeViewController canSendText])
        {
            controller.body = messageLocation.text;
            controller.recipients = recipients;
            controller.messageComposeDelegate = self;
            controller.toolbarHidden = YES;
            controller.wantsFullScreenLayout = YES;
            [self presentViewController:controller animated:YES completion:nil];
            
        }
    });
}

- (IBAction)UIView_TouchUpInside:(id)sender {
    
    [self postToFacebook];
    
    //[self sendSMS];
    
    
    
}


-(void) postToFacebook
{
    
    AppDelegate* mainApp = [[UIApplication sharedApplication] delegate];
        
    NSMutableDictionary* dic = [mainApp getDictionaryBundleProfile];
    
    NSInteger facebook = [[dic objectForKey:@"Facebook"] intValue];
    
    if ([[mainApp fbSession] isOpen] && facebook == 1)
    {
        
        if (currentPlaceMark == nil)
        {
        
            [FBRequestConnection startForPostStatusUpdate:messageLocation.text
                                        completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                            
                                            if (error)
                                            {
                                                
                                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                                                                    message:@"Aconteceu um erro ao enviar a alerta para o facebook"
                                                                                                   delegate:nil
                                                                                          cancelButtonTitle:@"OK"
                                                                                          otherButtonTitles:nil];
                                                [alertView show];
                                                
                                            }
                                            
                                        }];
        }
        else
        {
            
            NSDictionary* dic = [[self getMainAppDelegate] getDictionaryBundleProfile];
            
            NSString* message = [NSString stringWithFormat:@"%@ Minha localização é %@, %@, %@ %@", [dic objectForKey:@"MessageAlert"], currentPlaceMark.thoroughfare, currentPlaceMark.subLocality, currentPlaceMark.subAdministrativeArea,currentPlaceMark.country];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]
                                         initWithObjectsAndKeys:message , @"message", nil];
           
            
            [FBRequestConnection  startWithGraphPath:@"me/feed"
                                         parameters:params
                                         HTTPMethod:@"POST"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (error)
                {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Emergency Response"
                                                                        message:@"Aconteceu um erro ao enviar a alerta para o facebook"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];

                }
            }];
            
            
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            
            [self.lblTestSMS setText:@"Cancelado"];
            break;
        case MessageComposeResultFailed:
            [self.lblTestSMS setText:@"Error"];
            break;
        case MessageComposeResultSent:
            [self.lblTestSMS setText:@"OK"];
            break;
            
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma CCLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    

    //Desliga o sinal de localização, economia de bateria
    [self.locationManager stopUpdatingLocation];
    
    [self.lblTestGPS setText:@"Error"];
    //[self.imgGPS setImage:[UIImage imageNamed:@"sendScreenIconsSignal.png"]];
    
    NSMutableDictionary* dicInformation;
    dicInformation = [[self getMainAppDelegate] getDictionaryBundleProfile];
    messageLocation.text = [dicInformation objectForKey:@"MessageAlert"];
    
    [messageLocation sizeToFit];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
   
    [self.lblTestGPS setText:@"Calculando"];
    
    NSMutableDictionary* dicInformation;
    UITableViewCell* cell = [[self.tblSendAlert visibleCells] objectAtIndex:0];
    
    dicInformation = [[self getMainAppDelegate] getDictionaryBundleProfile];
    

    
    if ([locations count] > 0)
    {
       currentLocation =[locations objectAtIndex:0];
      //[self.imgGPS setImage:[UIImage imageNamed:@"sendScreenIconsSignal.png"]];
        
        CLGeocoder* geoCoder = [[ CLGeocoder alloc] init];
        
        //Transformando a localizaçäo dele
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            if ([placemarks count] > 0)
            {
                [self.lblTestGPS setText:@"OK"];
                
                CLPlacemark* placeMark = [placemarks lastObject];
                
                currentPlaceMark = placeMark;
                
                NSString* localization = [NSString
                                          stringWithFormat:@"\nMinha localização é %@, %@",
                                          placeMark.thoroughfare,
                                          placeMark.administrativeArea];
               
                messageLocation.text = [dicInformation objectForKey:@"MessageAlert"];
                messageLocation.text = [NSString stringWithFormat:@"%@ %@", messageLocation.text, localization];
                
          }
          else
          {
              [self.lblTestGPS setText:@"Sem Sinal"];
              currentPlaceMark = nil;
              currentLocation = nil;
              messageLocation.text = [dicInformation objectForKey:@"MessageAlert"];
              
          }
            
            //Recalculando a label em relação a celula
            messageLocation.frame = CGRectMake(5, 1, cell.bounds.size.width - 5, cell.bounds.size.height + 5);
            [messageLocation sizeToFit];
         
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
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(7, 0, tableView.bounds.size.width, 0)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:232.0/255.0
                                                   green:232.0/255.0
                                                    blue:232.0/255.0
                                                   alpha:1.0]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(7, 4, tableView.bounds.size.width, 13)];
    
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
                      initWithFrame:CGRectMake(5, 2, cell.bounds.size.width - 5, cell.bounds.size.height + 5)];
    
    [label clipsToBounds];
    label.numberOfLines = 4;
    label.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
    [label setFont:[UIFont systemFontOfSize:12]];
    
  
    
    if (indexPath.section == 0)
    {
        dicInformation = [[self getMainAppDelegate] getDictionaryBundleProfile];
        label.text = [dicInformation objectForKey:@"MessageAlert"];
        messageLocation = label;
        
    }
    else if (indexPath.section == 1 || indexPath.section == 2)
    {
        NSMutableString* stringBuild = [[NSMutableString alloc] init];
        
        if (indexPath.section == 1) //caso seja destinarios leio somente a parte de sms
        {
            for (NSArray *contato in arraySMS)
            {
                if ([[contato objectAtIndex:3] intValue] == 1)
                {
                    [stringBuild appendString:[NSString stringWithFormat:@"%@ - ",[contato objectAtIndex:0]]];
                }
            }
        }
        
        if (indexPath.section == 2) //caso seja destinarios leio somente a parte de sms
        {
            for (NSArray *contato in arrayPhone)
            {
                if ([[contato objectAtIndex:3] intValue] == 1)
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
