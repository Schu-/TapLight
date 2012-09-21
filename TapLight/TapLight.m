//
//  TapLight.m
//  TapLight
//
//  Created by Andrew Schumacher on 2/12/12.
//  Copyright (c) 2012 XeSys. All rights reserved.
//

#import "TapLight.h"
#import "TapSettings.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@implementation TapLight

@synthesize autoOn;
@synthesize shake;
@synthesize tapSession;
@synthesize ledDevice;
@synthesize fromBack;
@synthesize autoView;
@synthesize autoImage;
@synthesize shakeView;
@synthesize shakeImage;
@synthesize tapButton;
@synthesize tapImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fromTheBack) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)fromTheBack
{
    NSLog(@"Return From Background");
    
    fromBack = [[NSString alloc] initWithFormat:@"fromBack"];
    
    [self viewDidLoad];
    
}


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"TapLight";
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(getSet:)];
    
    self.navigationItem.rightBarButtonItem = settings;
    
    NSLog(@"View Did LOAD Called");
    

 
    //Check User Settings
    
    NSUserDefaults *sSettings = [NSUserDefaults standardUserDefaults];
    
    autoOn.text = [sSettings stringForKey:@"auto_key"];
    shake.text = [sSettings stringForKey:@"shake_key"];
     
    
    if ([autoOn.text isEqualToString:@"on"])
    {
        if ([fromBack isEqualToString:@"fromBack"])
        {
            [self buttonSwitch];
            
            [self ledToggle];
            [ledDevice lockForConfiguration:nil];
            [ledDevice setTorchMode:AVCaptureTorchModeOn];
            
        }
        
        else
        {
            
        [self ledToggle];
        [ledDevice lockForConfiguration:nil];
        [ledDevice setTorchMode:AVCaptureTorchModeOn];
        
        }
        
        [self statusBar];

        
    }
    
    else if ([autoOn.text isEqualToString:@"off"])
    {
        if ([fromBack isEqualToString:@"fromBack"])
        {
            [self buttonSwitch];
        }
        
        else
        {
        [self ledToggle];
        [ledDevice lockForConfiguration:nil];
        [ledDevice setTorchMode:AVCaptureTorchModeOff];
        }

        [self statusBar];
        
    }
    
    
    if ([shake.text isEqualToString:@"on"])
    {
        [self statusBar];
    }
    else if ([shake.text isEqualToString:@"off"])
    {
        [self statusBar];
    }

    
    [self buttonSwitch];

}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    NSLog(@"View Did Appear");

    
    [self statusBar];
    
    [self buttonSwitch];
    
    //[self becomeFirstResponder];

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    NSLog(@"UNLOAD VIEW");

    
    autoOn = nil;
    shake = nil;
    tapSession = nil;
    shake = nil;
    ledDevice = nil;
    fromBack = nil;
    autoView = nil;
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    
}



-(void)ledToggle
{
    ledDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureSession *ledSession = [[AVCaptureSession alloc] init];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:ledDevice error:nil];
    [ledSession addInput:input];
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [ledSession addOutput:output];
    
    [ledSession beginConfiguration];
    [ledDevice lockForConfiguration:nil];
    
    
    //[ledDevice setTorchMode:AVCaptureTorchModeOn];
    
    
    [ledDevice unlockForConfiguration];
    [ledSession commitConfiguration];
    
    
    
    //[ledSession startRunning];

    
    //[self setTapSession:ledSession];
}  

-(void)buttonSwitch
{
    if (ledDevice.torchMode == AVCaptureTorchModeOn)
    {
        //Release View
        [tapButton removeFromSuperview];
        
        
        tapImage = [UIImage imageNamed:@"on.png"];
        
        tapButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 70, 200, 200)];
        [tapButton setBackgroundImage:tapImage forState:UIControlStateNormal];
        [tapButton addTarget:self action:@selector(buttonToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tapButton];
        
    }
    else if (ledDevice.torchMode == AVCaptureTorchModeOff)
    {
        //Release View
        [tapButton removeFromSuperview];
        
        
        tapImage = [UIImage imageNamed:@"off.png"];
        
        tapButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 70, 200, 200)];
        [tapButton setBackgroundImage:tapImage forState:UIControlStateNormal];
        [tapButton addTarget:self action:@selector(buttonToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tapButton];
    }
}



-(IBAction)buttonToggle:(id)sender
{
    if (ledDevice.torchMode == AVCaptureTorchModeOn)
    {
        [ledDevice lockForConfiguration:nil];
        [ledDevice setTorchMode:AVCaptureTorchModeOff];
        
        [self buttonSwitch];
    }
    
    else if (ledDevice.torchMode == AVCaptureTorchModeOff)
    {
        [self ledDevice];
        [ledDevice lockForConfiguration:nil];
        [ledDevice setTorchMode:AVCaptureTorchModeOn];
        
        [self buttonSwitch];
    }
}



-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self shakeToggle];
}


-(void)shakeToggle
{
    NSUserDefaults *sSettings = [NSUserDefaults standardUserDefaults];
    
    shake.text = [sSettings stringForKey:@"shake_key"];
    
    if ([shake.text isEqualToString:@"on"])
         {
             if (ledDevice.torchMode == AVCaptureTorchModeOn)
             {
                 //[self ledDevice];
                 [ledDevice lockForConfiguration:nil];
                 [ledDevice setTorchMode:AVCaptureTorchModeOff];
                 
                 [self buttonSwitch];
             }
             else if (ledDevice.torchMode == AVCaptureTorchModeOff)
             {
                 [self ledDevice];
                 [ledDevice lockForConfiguration:nil];
                 [ledDevice setTorchMode:AVCaptureTorchModeOn];
                 
                 [self buttonSwitch];
             }
         }
    else
    {
        return;
    }
    
}



-(void)statusBar
{
    
    NSUserDefaults *sSettings = [NSUserDefaults standardUserDefaults];
    
    autoOn.text = [sSettings stringForKey:@"auto_key"];
    shake.text = [sSettings stringForKey:@"shake_key"];
    
    
    
    if ([autoOn.text isEqualToString:@"on"])
    {
        //Release View
        [autoView removeFromSuperview];
        
        //Load Status Images
        autoImage = [UIImage imageNamed:@"auto.png"];
        
        autoView = [[UIImageView alloc] initWithFrame:CGRectMake(259, 389, 27, 25)];
        autoView.image = autoImage;
        [self.view addSubview:autoView];
        
    }
    else if ([autoOn.text isEqualToString:@"off"])
    {
        
        //Release View
        [autoView removeFromSuperview];
        
        //Load Status Images
        autoImage = [UIImage imageNamed:@"autoNo.png"];
        
        autoView = [[UIImageView alloc] initWithFrame:CGRectMake(259, 389, 27, 25)];
        autoView.image = autoImage;
        [self.view addSubview:autoView];
    }
    
    
    
    if ([shake.text isEqualToString:@"on"])
    {
        //Release View
        [shakeView removeFromSuperview];
        
        
        //Load Status Images
        shakeImage = [UIImage imageNamed:@"shake.png"];
        
        shakeView = [[UIImageView alloc] initWithFrame:CGRectMake(288, 389, 27, 25)];
        shakeView.image = shakeImage;
        [self.view addSubview:shakeView];
    }
    else if ([shake.text isEqualToString:@"off"])
    {
        //Release View
        [shakeView removeFromSuperview];
        
        
        //Load Status Images
        shakeImage = [UIImage imageNamed:@"shakeNo.png"];
        
        shakeView = [[UIImageView alloc] initWithFrame:CGRectMake(288, 389, 27, 25)];
        shakeView.image = shakeImage;
        [self.view addSubview:shakeView];
    }

    
    
}




#pragma mark - 
#pragma mark View Controller

-(IBAction)getSet:(id)sender
{
    
    TapSettings *setTap = [[TapSettings alloc] init];
    [[self navigationController] pushViewController:setTap animated:YES];

}



@end
