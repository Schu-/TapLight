//
//  TapLight.h
//  TapLight
//
//  Created by Andrew Schumacher on 2/12/12.
//  Copyright (c) 2012 XeSys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TapLight : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *autoOn;
@property (strong, nonatomic) IBOutlet UILabel *shake;


@property (strong, nonatomic) AVCaptureSession *tapSession;
@property (strong, nonatomic) AVCaptureDevice *ledDevice;

@property (strong, nonatomic) NSString *fromBack;

@property (strong, nonatomic) UIImageView *autoView;
@property (strong, nonatomic) UIImageView *shakeView;


@property (strong, nonatomic) UIImage *autoImage;
@property (strong, nonatomic) UIImage *shakeImage;
@property (strong, nonatomic) UIImage *tapImage;

@property (strong, nonatomic) UIButton *tapButton;


-(void)ledToggle;
-(void)shakeToggle;
-(void)viewDidLoad;
-(void)buttonSwitch;


-(IBAction)getSet:(id)sender;
-(IBAction)buttonToggle:(id)sender;

@end
