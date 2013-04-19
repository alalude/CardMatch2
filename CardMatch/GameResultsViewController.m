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
    // Ghost cards if matched to .05%
    //cardButton.alpha = (card.isUnplayable ? 0.05 : 1.0);
    
    
    NSString *displayText = @""; // start with a blank screen
    
    // NSLog(@"GameResult UI update");
    for (GameResult *result in self.allGameResults) // in [GameResult allGameResults]
    {
        //displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n  ", result.score, result.end, round(result.duration)]; // 0g is an unformatted floating point number
        
        // NSLog(@"Score: %d (%@, %0g)", result.score, result.end, round(result.duration));
        
        
        NSLog(@"self.gameType %@", result.gameType);
        // Display text with formatted date/time
        // displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n  ", result.score,
        displayText = [displayText stringByAppendingFormat:@"%@ score: %d (%@, %0g)\n  ", result.gameType, result.score,            // *!*
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
    // flipCard in CardMatchingGameVC | - (IBAction)flipCard:(UIButton *)sender
    // flipCardAtIndex in CardMatchingGame | card.unplayable = YES;
    // flipCardAtIndex in CardMatchingGame | otherCard.faceUp = NO;
    
    /* updateUI in CardMatchingGameVC
     
     // Make sure correct state is selected
     cardButton.selected = card.isFaceUp;
     
     // Make sure the enbled state is correct
     cardButton.enabled = !card.isUnplayable;
     
     // Ghost cards if matched to 30%
     cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
     
     */
    
    // self.sortByDate.selected = YES;
    
    
    NSLog(@"sortByDate pushed");
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDate:)];
    
    //----------------------------------------------------------------------------------
    NSLog(@"GameResult UI update for Date");
    for (GameResult *result in [GameResult allGameResults])
    {
        NSLog(@"Score: %d (%@, %0g) - %@", result.score, result.end, round(result.duration), result.gameType);
    }
    
    [self updateUI];
}

- (IBAction)sortByScore
{
    NSLog(@"sortByScore pushed");
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareScore:)];
    
    //----------------------------------------------------------------------------------
    NSLog(@"GameResult UI update for Score");
    for (GameResult *result in [GameResult allGameResults])
    {
        NSLog(@"Score: %d (%@, %0g) - %@", result.score, result.end, round(result.duration), result.gameType);
    }
    
    [self updateUI];
}

- (IBAction)sortByDuration
{
    NSLog(@"sortByDuration pushed");
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDuration:)];
    
    //----------------------------------------------------------------------------------
    NSLog(@"GameResult UI update for Duration");
    for (GameResult *result in [GameResult allGameResults])
    {
        NSLog(@"Score: %d (%@, %0g) - %@", result.score, result.end, round(result.duration), result.gameType);
    }
    [self updateUI];
}

- (IBAction)sortByGameType
{
    NSLog(@"sortByGameType pushed");
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareGameType:)];
    
    //----------------------------------------------------------------------------------
    NSLog(@"GameResult UI update for Game Type");
    for (GameResult *result in [GameResult allGameResults])
    {
        NSLog(@"Score: %d (%@, %0g) - %@", result.score, result.end, round(result.duration), result.gameType);
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
