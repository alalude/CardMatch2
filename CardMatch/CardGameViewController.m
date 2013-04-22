//
//  CardGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 2/28/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "CardGameViewController.h"
// #import "PlayingCardDeck.h" // this class is being made generic
#import "CardMatchingGame.h"
#import "GameResult.h"
// #import "GameSettings.h"

// we want our controller to provide data for the collection view
// so we will tell the world that the CardGameViewController is willing to be a colection view data source
@interface CardGameViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

// UPGRADE
// An array of the cards on screen
// @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// Bringing in the game itself, a pointer to the model
@property (strong, nonatomic) CardMatchingGame *game;

// A history of flips in the current game
@property (strong, nonatomic) NSMutableArray *history;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;

@property (weak, nonatomic) IBOutlet UISlider *historySlider;

@property (strong, nonatomic) GameResult *gameResult;

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;



@end


@implementation CardGameViewController


//-----------------------------------------------------------------
// Required Implementation for UICollectionViewDataSource Protocol
//-----------------------------------------------------------------

// optional example
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1; // returns 1 even if not implemented
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount; // *!* gonna want to ask how many cards are currently in play *!*
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // make sure "PlayingCard" matches up with what s in the storyboard (reuse identifier)
    // were talking about the cell not the view within it
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingOrSetCard" forIndexPath:indexPath]; // PlayingOrSetCard has been set as the Reuse Identifier for both PlayingCardCollectionViewCell and PlayingCardCollectionViewCell
    
    // now that we have the cell let's load it up with that something from the model
    // let's get that something from the model... the card
    Card *card = [self.game cardAtIndex:indexPath.item];
    // indexPath has two propertys item and section
    // the section will be 0 because we only have one section, while the item will be which card we're talking about
    
    [self updateCell:cell usingCard:card];  // implemented just below
    
    return cell;
}

// supports method above
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // abstract
    // can't be implemented in this base class because nothing is known about playing cards and set cards here
    // don't forget to make it public, so subclasses can make it not abstract 
}

//-----------------------------------------------------------------
// Original Implementation
//-----------------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateUI];
}

// Lazy instantiation for the model
- (CardMatchingGame *)game
{
    if (!_game)
    {
        // will now be a generic base class
        // playing card and set will become sub classes
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                  usingDeck:[self createDeck]];
        [self gameModeChange:self.gameModeSelector];
    }
    
    return _game;
}

- (Deck*)createDeck { return nil; } //abstract

- (NSMutableArray *)history
{
    if (!_history)
    {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

// UPGRADE
/*
- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    [self updateUI];    
}
 */

- (void)setGameModeSelector:(UISegmentedControl *)gameModeSelector
{
    _gameModeSelector = gameModeSelector;
    
    [self updateUI];
}

#define RESULTS_LABEL_FONT_SIZE 12.0

// The method to update the UI
// Objective 1: Make the UI look like the model
// Objective 2: Inform the model of changes to the UI
- (void)updateUI
{
    NSLog(@"2) CGVC.m in updateUI");
    
    // go through all the visible cells and  update them all
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        // get the indexPath for each one to find it in the model
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        
        Card *card = [self.game cardAtIndex:indexPath.item];
        
        [self updateCell:cell usingCard:card];
    }
    
    // Make sure the enbled state is correct
    self.gameModeSelector.enabled = self.game.isActiveModeControl;

    // Update score on UI
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    // Update results on UI  
    if ([self.game.results isKindOfClass: [NSAttributedString class]])
    {
        // Update results
        if (self.game.results) self.resultsLabel.attributedText = self.game.results;
        
        // Center and Set Font Size
        NSRange range = [[self.resultsLabel.attributedText string] rangeOfString:[self.resultsLabel.attributedText string]];
        
        NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
        [paragrahStyle setAlignment: NSTextAlignmentCenter];
        
        NSMutableAttributedString *resultsLabelAttrText = [self.resultsLabel.attributedText mutableCopy];
        [resultsLabelAttrText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:RESULTS_LABEL_FONT_SIZE] range:range];
        [resultsLabelAttrText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:range];
            
        self.resultsLabel.attributedText = resultsLabelAttrText;
    }
    
    else
    {
        self.resultsLabel.text = self.game.results;
    }
    
    self.resultsLabel.alpha = 1;
    
    // Update slider on UI
    [self updateSliderRange];
    
}

// Purely UI features can update themselves directly in their own setter
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (void)updateSliderRange
{
    int maxValue = [self.history count] - 1;
    if (maxValue < 0) maxValue = 0;
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}

// UPGRADE
// - (IBAction)flipCard:(UIButton *)sender

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    // get the location of the tap
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    
    // get the indexPath of the cell that was clicked on
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    // check to confirm tap is on a cell
    if (indexPath)
    {
        // all the former flipCard code
        
        // [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];        
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        NSLog(@"1) CGVC.m card succesfully flipped");
        
        
        
        // TROUBLE for SetCard
        
        // introspect to only work on playingcards
        // if statement is causing trouble
        
        /*
        if(![self.game.results isEqualToString:@"Results"] && ![[self.history lastObject] isEqualToString:self.game.results]) // *!* condition to keep word "Results" out of history
        {
            [self.history addObject:self.game.results];
        }
         */
       
        
        
        
        
        // Each time a card is flipped th e UI needs to be updated
        [self updateUI];
        
        
        self.gameResult.score = self.game.score;
        
        self.gameResult.gameType = self.game.gameType;
        
    }    
    
}



- (IBAction)historySliderChanged:(UISlider *)sender
{
    int sliderValue;
    sliderValue = lroundf(self.historySlider.value);
    [self.historySlider setValue:sliderValue animated:NO];
    
    if ([self.history count])
    {
        self.resultsLabel.alpha =
        (sliderValue + 1 < [self.history count]) ? 0.6 : 1.0;
        self.resultsLabel.text = [self.history objectAtIndex:sliderValue];
    }
}

- (IBAction)dealCards:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0; // reset flipCount
    self.history = nil;
    self.gameResult =nil;
    [self updateUI]; // get all cards face up
}

- (IBAction)gameModeChange:(UISegmentedControl *)sender
{
    switch ([sender selectedSegmentIndex])
    {
        case 0:
            self.game.numberOfMatchingCards = 2;
            break;
        case 1:
            self.game.numberOfMatchingCards = 3;
            break;
        default:
            self.game.numberOfMatchingCards = 2;
            break;
    }
}


@end
