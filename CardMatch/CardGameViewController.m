//
//  CardGameViewController.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 2/28/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

@property (nonatomic) int flipCount;

// Fetch the card to work with
// Should it be weak?
@property (strong, nonatomic) IBOutlet UIButton *cardButton;
//*!* I'd like to have a playing card deck

// My original and flawed idea
// TRY 1: @property (strong, nonatomic) NSMutableArray *myDeck; *!*
// TRY 2: @property PlayingCardDeck *deck; *!*

@property (strong, nonatomic) Deck *deck; // Does not have to be PlayingCardDeck

@end



//*!* create a deck of cards
//    PlayingCard *card = [[PlayingCard alloc] init];
//    PlayingCardDeck *deck = [[PlayingCardDeck alloc] init];

//*!* Use "PlayingCardDeck" to create an array/deck of cards

//*!* drawRandomCard



@implementation CardGameViewController

//*!* Hopefully building a deck
// - (void)buildDeck
// {
//        PlayingCardDeck *deck = [[PlayingCardDeck alloc] init];
// }

// The proper way to build/init an object
- (Deck *)deck
{
    if (!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init]; // of type Deck but inited as PlayingCardDeck
    }
    return _deck;
}

- (void) setCardButton:(UIButton *)cardButton;
{
    // *** this needs to be a new random card each click
    // *** leverage -- UIButton - setTitle:forState
    // *** xxx
    
    // Before I did anything I should have decided to make a setter
    // This first line of any setter
    _cardButton = cardButton;
    
    // Setting the cards value
    // TRY 1: setTitle:sender.selected = drawRandomCard[self.deck]; *!*
    
    // First get the random card
    Card *card = [self.deck drawRandomCard];
    NSLog(@"Card Contents %@", card.contents);
    // Then display it
    // TRY 1: [setTitle:card.content];
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}



- (IBAction)flipCard:(UIButton *)sender
{
//    if (sender.isSelected)
//    {
//        sender.selected = NO;
//        else
//        {
//            sender.selected = YES;
//        }
//        
//    }
    
    sender.selected = !sender.isSelected;
    
//    self.flipCount = self.flipCount + 1;
    
    self.flipCount++;
}

@end
