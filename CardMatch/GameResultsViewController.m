//
//  GameResultsViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/25/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

//
// Coded in
// CS193 Winter 2013
// Lecture 5
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (strong, nonatomic) NSArray *allGameResults;

@end

@implementation GameResultsViewController

// add all game results to text field display
- (void)updateUI
{
    NSString *displayText = @""; // start with a blank screen
    
    // NSLog(@"GameResult UI update");
    for (GameResult *result in self.allGameResults) // in [GameResult allGameResults]
    {
        //displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n  ", result.score, result.end, round(result.duration)]; // 0g is an unformatted floating point number
        
        // NSLog(@"Score: %d (%@, %0g)", result.score, result.end, round(result.duration));
        
        
        // Display text with formatted date/time
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n  ", result.score,
                       [NSDateFormatter localizedStringFromDate:result.end
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterShortStyle],
                       round(result.duration)]; // 0g is an unformatted floating point number
        
    }
    
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.allGameResults = [GameResult allGameResults];
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
- (IBAction)sortByDate
{
    NSLog(@"By Date pushed");
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDate:)];
    
    //----------------------------------------------------------------------------------
    NSLog(@"GameResult UI update for Date");
    for (GameResult *result in [GameResult allGameResults])
    {
        NSLog(@"Score: %d (%@, %0g)", result.score, result.end, round(result.duration));
    }
    
    [self updateUI];
}

- (IBAction)sortByScore
{
    NSLog(@"By Score pushed");
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareScore:)];
    
    //----------------------------------------------------------------------------------
    NSLog(@"GameResult UI update for Score");
    for (GameResult *result in [GameResult allGameResults])
    {
        NSLog(@"Score: %d (%@, %0g)", result.score, result.end, round(result.duration));
    }
    
    [self updateUI];
}

- (IBAction)sortByDuration
{
    NSLog(@"By Duration pushed");
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDuration:)];
    
    //----------------------------------------------------------------------------------
    NSLog(@"GameResult UI update for Duration");
    for (GameResult *result in [GameResult allGameResults])
    {
        NSLog(@"Score: %d (%@, %0g)", result.score, result.end, round(result.duration));
    }
    [self updateUI];
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
