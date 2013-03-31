//
//  SetGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/26/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface SetGameViewController ()

// *** IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

@property (nonatomic) int flipCount;

// An array of the cards on screen
// *** IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// Bringing in the game itself, a pointer to the model
@property (strong, nonatomic) CardMatchingGame *game;

// A history of flips in the current game
@property (strong, nonatomic) NSMutableArray *history;

// *** IBOutlet UILabel *scoreLabel

// *** IBOutlet UILabel *resultsLabel

// xxx IBOutlet UISegmentedControl *gameModeSelector;

// xxx IBOutlet UISlider *historySlider;

// @property (strong, nonatomic) GameResult *gameResult;

@end

@implementation SetGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]];
        // [self gameModeChange:self.gameModeSelector];
    }
    return _game;
}

- (NSMutableArray *)history
{
    if (!_history)
    {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    [self updateUI];
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardshading.png"];
    
    for (UIButton *cardButton in self.cardButtons)
    {
        // Get a card from
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        // Setting all of the card's features
        
        // *!* ---------------------------------------------
        // Set card value
       
        
        NSString *cardContents = [card.contents objectForKey: @"contents"];
        NSLog(@"In UI update on flip %@", cardContents); // *!*this is a dic now
        
        NSDictionary *cardTextAttributes = [card.contents objectForKey: @"attributes"];
        
        /*
        NSDictionary *cardTextAttributes = @{NSForegroundColorAttributeName : [[UIColor greenColor] colorWithAlphaComponent: 0.2],
                                                 NSStrokeWidthAttributeName : @-3,
                                                 NSStrokeColorAttributeName : [UIColor greenColor]};
        */
        
        NSRange textRange = [[cardButton.currentAttributedTitle string] rangeOfString: [cardButton.currentAttributedTitle string]];
        
        // NSLog(@"currentAttributedTitle %@", [cardButton.currentAttributedTitle string]);
        NSLog(@"textRange.location %i", textRange.location);
        NSLog(@"textRange.length %i", textRange.length);
        
        NSMutableAttributedString *colorCard = [cardButton.currentAttributedTitle mutableCopy];
        
        NSLog(@"colorCard %@", [colorCard string]);
        [colorCard addAttributes:cardTextAttributes range:textRange];
        
        [colorCard replaceCharactersInRange:textRange withString:cardContents];
        
        // setAttributedTitle:forState:
        [cardButton setAttributedTitle:colorCard forState:UIControlStateNormal];
        [cardButton setAttributedTitle:colorCard forState:UIControlStateSelected];
        [cardButton setAttributedTitle:colorCard forState:UIControlStateSelected | UIControlStateDisabled];
    }
}

// Purely UI features can update themselves directly in their own setter
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{
    // [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    
    /*
     
     // if (![[self.history lastObject] isEqualToString:self.game.results]) [self.history addObject:self.game.results];
     if(![self.game.results isEqualToString:@"Results"] && ![[self.history lastObject] isEqualToString:self.game.results]) // *!* condition to keep word "Results" out of history
     {
     [self.history addObject:self.game.results];
     }
     
     */
    
    // Each time a card is flipped the UI needs to be updated
    [self updateUI];
    // self.gameResult.score = self.game.score;
}

/* Serious Issues

// The method to update the UI
// Objective 1: Make the UI look like the model
// Objective 2: Inform the model of changes to the UI
- (void)updateUI
{
    // Create a variable for card backs
    UIImage *cardBackImage = [UIImage imageNamed:@"cardshading.png"];
    
    // Go through all your buttons and update all your cards
    for (UIButton *cardButton in self.cardButtons)
    {
        // Get a card from
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        // Setting all of the card's features
        
        // Set card value
        [cardButton setTitle:card.contents forState: UIControlStateNormal | UIControlStateSelected | UIControlStateDisabled];
        
        // Make sure correct state is selected
        cardButton.selected = card.isFaceUp;
        
        // Make sure the enbled state is correct
        cardButton.enabled = !card.isUnplayable;
        
        // Ghost cards if matched to 30%
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        // Display the card back if the card is face down
        if (!card.isFaceUp)
        {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        
        else
        {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        }
    }

    // Update score on UI
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
 
    // Update results on UI
    self.resultsLabel.alpha = 1;
    self.resultsLabel.text = self.game.results;

}
 
 */

@end
