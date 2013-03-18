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

// @property (strong, nonatomic) Deck *deck; //rendered obsolete by connection to model

// Bringing in the game itself
// Essentially a pointer to the model
@property (strong, nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end


@implementation CardGameViewController

/* rendered obsolete by connection to model
 - (Deck *)deck
 {
 if (!_deck) _deck = [[PlayingCardDeck alloc] init];
 return _deck;
 }
 */

// Lazy instantiation for the model
// - (CardMatchingGame *)game:(NSUInteger)count:(Deck *)deck // I was wrong
- (CardMatchingGame *)game
{
    // if (!_game) _game = [[CardMatchingGame alloc] init]; // I was wrong again
    // Don't cut/paste write by hand and let Xcode help you
    // if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:count usingDeck:deck];
    // Not quite there yet
    /* This works, but it's better/simpler to not init deck by itself
     if (!_game) {
     _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
     usingDeck:self.deck];
     }
     */
    // grabbed alloc/init from Deck init and dropped it in
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    // Still need a means by witch to update the UI
    // We must have the UI match the model at all times
    [self updateUI];
    
    
    /* Model now controls how cards are set
     
     int i = 1; //*!* just for testing
     
     //
     // added "self." to for loop parameters
     // for (UIButton *cardButtons in cardButtons)
     //
     
     for (UIButton *cardButtons in self.cardButtons)
     {
     Card *card = [self.deck drawRandomCard];
     [cardButtons setTitle:card.contents forState:UIControlStateSelected];
     NSLog(@"Card Contents - %d %@", i, card.contents); //*!* just for testing
     i++; //*!* just for testing
     }
     */
}

// The method to update the UI
// Objective 1: Make the UI look like the model
// Objective 2: Inform the model of changes to the UI
- (void)updateUI
{
    
    // Go through all your buttons and update all your cards
    // for (CardButtons *cardButtons in self.cardButtons) // Gotta get the type right
    // for (UIButton *cardButtons in self.cardButtons) // NOT *cardButtons
    for (UIButton *cardButton in self.cardButtons)
    {
        // Think - from PlayingCardGame
        // - (Card *)cardAtIndex:(NSUInteger)index;
        // Think - from this class's method flipCard
        // [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        
        // A good start
        // [self.game cardAtIndex:[self.cardButtons indexOfObject:i]];
        
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
        // cardButton.selected = card.faceUp; // Close, but not quite
        cardButton.selected = card.isFaceUp;
        
        // Make sure the enbled state is correct
        // cardButton.enabled = card.isUnplayable;// Close, but not quite
        // Negate rightside of equation
        cardButton.enabled = !card.isUnplayable;
        
        // Ghost cards if matched to 30%
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    
    // Update score on UI
    // self.scoreLabel = [card match:@[otherCard]]; // not quite
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
}

// Purely UI features can update themselves directly in their own setter
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

// Show the Score
/* This is the worng way to do this
 - (void)setScoreLabel:(UILabel *)scoreLabel
 {}
 */

- (IBAction)flipCard:(UIButton *)sender
{
    // sender.selected = !sender.isSelected; //rendered obsolete by connection to model
    // We now need to let the model know a card needs to be flipped
    // self.cardButtons.isFaceUp; // No way this will work
    // You have to go through the game
    // [self.game flipCardAtIndex:self.card.index] // Not quite there
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    // Each time a card is flipped the UI needs to be updated
    [self updateUI];
}

@end
