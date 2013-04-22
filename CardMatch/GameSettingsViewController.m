//
//  GameSettingsViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 4/8/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "GameSettingsViewController.h"
#import "CardGameViewController.h"

@interface GameSettingsViewController ()
@property (strong, nonatomic) NSMutableDictionary *allSettings;
@property (strong, nonatomic) NSMutableDictionary *settingsDic;

@end

@implementation GameSettingsViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)settingsDic
{
    if(!_settingsDic) _settingsDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [UIImage imageNamed: @"cardBackDefault.png"], @"cardback", @"value2", @"setting2", @"value3", @"setting3", nil];
    return _settingsDic;
}

- (IBAction)selectedCardBack:(UIButton *)sender
{
    NSLog(@"GameSetting cardback before %@", [self.settingsDic objectForKey: @"cardback"]);
    [self.settingsDic setObject: [sender imageForState: UIControlStateNormal] forKey: @"cardback"];
    NSLog(@"GameSetting cardback after %@", [self.settingsDic objectForKey: @"cardback"]);
    
    // prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    [self performSegueWithIdentifier: @"passCardbacks" sender: self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"passCardbacks"])
    {
        NSLog(@"GameSetting Segue %@", [self.settingsDic objectForKey: @"cardback"]);
        CardGameViewController *controller = (CardGameViewController *)segue.destinationViewController;
        controller.settingsDicReceiver = self.settingsDic;
        
    }
}

@end
