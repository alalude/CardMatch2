//
//  CardGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 2/28/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

// An array of the cards on screen
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// Bringing in the game itself, a pointer to the model
@property (strong, nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;

@end


@implementation CardGameViewController

// Lazy instantiation for the model
- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
        [self gameModeChange:self.gameModeSelector];
    }
    return _game;
}


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    [self updateUI];
    
}

// The method to update the UI
// Objective 1: Make the UI look like the model
// Objective 2: Inform the model of changes to the UI
- (void)updateUI
{
    
    // Go through all your buttons and update all your cards
    for (UIButton *cardButton in self.cardButtons)
    {
        // Get a card from
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        // Setting all of the card's features
        
        // Set card value
        [cardButton setTitle:card.contents forState:UIControlStateSelected]; //Nailed on first try
        // Not so fast
        // Documentation says I need to set title for every state or it reverts to the default
        // in this case the back of the card
        // So, I've got to add...
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        
        // Make sure correct state is selected
        cardButton.selected = card.isFaceUp;
        
        // Make sure the enbled state is correct
        cardButton.enabled = !card.isUnplayable;
        
        // Ghost cards if matched to 30%
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    
    // Update score on UI
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    // Update results on UI
    self.resultsLabel.text = self.game.results;
    
    // self.resultsLabel.text = (@"Results");
    
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
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    // Each time a card is flipped the UI needs to be updated
    [self updateUI];
}


- (IBAction)dealCards:(UIButton *)sender
{
    // - (void)flipCardAtIndex:(NSUInteger)index
    // [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    // - (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
    // deal new cards
    //CardMatchingGame *game = [self.game initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    // or
    self.game = nil;
    [self updateUI]; // get all cards face up
    self.flipCount = 0; // reset flipCount
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
