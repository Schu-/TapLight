//
//  TapSettings.m
//  TapLight
//
//  Created by Andrew Schumacher on 2/14/12.
//  Copyright (c) 2012 XeSys. All rights reserved.
//

#import "TapSettings.h"

#define A_SWITCH_KEY @"auto_key"


@implementation TapSettings

@synthesize setTable;
@synthesize setList;
@synthesize startSwitch;
@synthesize shakeSwitch;
@synthesize startString;
@synthesize shakeString;
@synthesize bAuto;
@synthesize bShake;






-(void)viewDidLoad
{
    
    
    NSArray *setStuf = [[NSArray alloc] initWithObjects:@"AutoStart Light:",@"Shake ON/OFF:", nil];
    
    
    self.setList = setStuf;
    self.title = @"Settings";
}





-(void)viewDidUnload
{

    self.setList = nil;
    self.setTable = nil;
    self.setList = nil;
    self.startSwitch = nil;
    self.shakeSwitch = nil;

    
}


-(void)viewWillDisappear:(BOOL)animated
{
  /* Alert On Unload  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Settings Saved" message:@"All Settings Will Be Applied When App Restarts" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
   */
}


-(void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults *sDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *aString = [sDefaults stringForKey:@"auto_key"];
    NSLog(@"Auto String Was: %@",aString);
    
    
    if ([aString isEqualToString:@"on"])
    {
        
        bAuto = YES;
        
    }
    
    else
    {
        bAuto = NO;

    }
    
    
    
    NSString *sString = [sDefaults stringForKey:@"shake_key"];
    NSLog(@"Shake String Was: %@",sString);
    
    
    if ([sString isEqualToString:@"on"])
    {
        
        bShake = YES;
        
    }
    
    else
    {
        bShake = NO;

    }
    
    

}



-(void)autoStart:(UISwitch *)sender
{
    NSUserDefaults *sDefaults = [NSUserDefaults standardUserDefaults];

    if(sender.on)
    {
        startString = [[NSString alloc] initWithFormat:@"on"];
        NSLog(@"String: %@",startString);
        [sDefaults setObject:startString forKey:@"auto_key"];
        [sDefaults synchronize];
        
        NSLog(@"Start Strings Set: %@",startString);
    }
    
    else
    {
        startString = [[NSString alloc] initWithFormat:@"off"];
        NSLog(@"String: %@",startString);
        [sDefaults setObject:startString forKey:@"auto_key"];
        [sDefaults synchronize];
        
        NSLog(@"Start Strings Set: %@",startString);
    }


}


-(void)shake:(UISwitch *)sender
{
    
    NSUserDefaults *sDefaults = [NSUserDefaults standardUserDefaults];
    
    if(sender.on)
    {
        shakeString = [[NSString alloc] initWithFormat:@"on"];
        NSLog(@"String: %@",shakeString);
        [sDefaults setObject:shakeString forKey:@"shake_key"];
        [sDefaults synchronize];
        
        NSLog(@"Shake Strings Set: %@",shakeString);
    }
    
    else
    {
        shakeString = [[NSString alloc] initWithFormat:@"off"];
        NSLog(@"String: %@",shakeString);
        [sDefaults setObject:shakeString forKey:@"shake_key"];
        [sDefaults synchronize];
        
        NSLog(@"Shake Strings Set: %@",shakeString);
    }
    
    
}



#pragma mark -
#pragma mark Settings Data Source Methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.setList count];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TapSettings = @"TapSettings";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TapSettings];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    
    if (cell == nil)
    {
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TapSettings];
    }
    
    
    NSInteger row = [indexPath row];
    
    
    if (row == 0)
    {
        
        startSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = startSwitch;
        [startSwitch setOn:bAuto animated:YES];
        [startSwitch addTarget:self action:@selector(autoStart:) forControlEvents:UIControlEventValueChanged];
        //startSwitch.tag = indexPath.row;

    }     
    
    
    if (row == 1)
    {
        shakeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = shakeSwitch;
        [shakeSwitch setOn:bShake animated:NO];
        [shakeSwitch addTarget:self action:@selector(shake:) forControlEvents:UIControlEventValueChanged];
    }
    
    
    
    cell.textLabel.text = [setList objectAtIndex:row];   
    return cell;
    
    
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header = [[NSString alloc] initWithFormat:@"Settings:"];
        
    
    return header;

}


@end
