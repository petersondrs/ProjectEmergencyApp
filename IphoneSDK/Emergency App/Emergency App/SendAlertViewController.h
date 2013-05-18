//
//  SendAlertViewController.h
//  Emergency App
//
//  Created by Rafael Bento Cruz on 5/1/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>
#import <CoreTelephony/CTCallCenter.h>
#import "SA_OAuthTwitterEngine.h"

@interface SendAlertViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate, SA_OAuthTwitterEngineDelegate>
{
   // UIView*     _blockerView;

    
}
@property (retain, nonatomic) CLLocationManager* locationManager;
@property (retain, nonatomic) Reachability* reach;
@property (weak, nonatomic) IBOutlet UIView *viewTestFeature;
@property (weak, nonatomic) IBOutlet UIView *uiViewSendAlert;
@property (weak, nonatomic) IBOutlet UITableView *tblSendAlert;

@property (weak, nonatomic) IBOutlet UILabel *lblTestSinal;
@property (weak, nonatomic) IBOutlet UILabel *lblTestGPS;
@property (weak, nonatomic) IBOutlet UILabel *lblTestSMS;
@property (weak, nonatomic) IBOutlet UILabel *lblTestLigacao;
@property (weak, nonatomic) IBOutlet UIImageView *imgSinal;
@property (weak, nonatomic) IBOutlet UIImageView *imgGPS;
@property (weak, nonatomic) IBOutlet UIImageView *imgSMS;
@property (weak, nonatomic) IBOutlet UIImageView *imgLigacao;
@property (weak, nonatomic) IBOutlet UIImageView *btnEnviarAlert;

- (IBAction)UIViewContact_TouchUpInside:(id)sender;
- (IBAction)BtnRefresh_TouchUpInside:(id)sender;
- (IBAction)UIView_TouchUpInside:(id)sender;

@end
