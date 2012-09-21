//
//  TapSettings.h
//  TapLight
//
//  Created by Andrew Schumacher on 2/14/12.
//  Copyright (c) 2012 XeSys. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface TapSettings : UIViewController <UINavigationControllerDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) UITableViewController *setTable;
@property (strong, nonatomic) NSArray *setList;
@property (strong, nonatomic) UISwitch *startSwitch;
@property (strong, nonatomic) UISwitch *shakeSwitch;
@property (strong, nonatomic) NSString *startString;
@property (strong, nonatomic) NSString *shakeString;
@property (nonatomic) BOOL bAuto;
@property (nonatomic) BOOL bShake;






-(IBAction)autoStart:(id)sender;


-(IBAction)shake:(id)sender;



@end
