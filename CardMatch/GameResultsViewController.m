//
//  GameResultsViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/25/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultsViewController

// add all game results to text field display
- (void)updateUI
{
    NSString *displayText = @""; // start with a blank screen
    for (GameResult *result in [GameResult allGameResults])
    {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n  ", result.score, result.end, round(result.duration)]; // 0g is an unformatted floating point number
    }
    
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)setup
{
    // Initialization that cannot wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup]; //*!*
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    // It is not necessary to protect this with an if statement
    if (self) {
        // Custom initialization
        [self setup]; //*!*
    }
    return self;
}

/*
 
 // Unnecessary default code
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
 */

@end
