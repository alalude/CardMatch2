//
//  CardMatchingGame.m
//  CardMatch
//
//  Created by Akinbiyi Adesina Lalude on 3/18/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

//
// Coded in
// CS193 Winter 2013
// Lecture 3
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
// readwrite = unnesscary
@property (readwrite, nonatomic) int score;

@property (readwrite, nonatomic) NSString *results;

@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

// Lazy instantiation for cards in implementation of game intializer below
- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1


/*
 Extract the results from the method below
 Then serve them up to be delivered in the UI
 
 What we know:
 1) Match Rank
 2) Match Suit
 3) Mismatch
 4) Neutral FLip
 
 // Testing Suite
 NSLog(@"Rank Matched, Score %d", self.score);
 NSLog(@"Card Contents - %@", card.contents);
 NSLog(@"Other Card's Contents - %@", otherCard.contents);
 
 */




- (void)flipCardAtIndex:(NSUInteger)index
{
    // First get the card at the designated index
    Card *card = [self cardAtIndex:index];
    
    // Now confirm there's a card at the index and it is playable
    if (card && !card.unplayable)
    {
        self.results = (@"Results");
        
        // To prevent comparing a card to itself
        if (!card.isFaceUp)
        {
            self.results = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            
            // Before simply fliping the card, check to see if it matches a card that's already up
            for (Card *otherCard in self.cards)
            {
                
                if(otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    int matchScore = [card match:@[otherCard]];
                    
                    // If there is a rank match i.e. matchScore > 1, points and "immobilization" are in order
                    if(matchScore > 1)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        
                        // Results picked up for display
                        // self.results = (@"Rank Matched");
                        // self.results = [NSString stringWithFormat:@"Rank Matched: %d points", (matchScore * MATCH_BONUS)];
                        self.results = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, (matchScore * MATCH_BONUS)];
                        
                    }
                    // If there is a suit match i.e. matchScore = 1, points and "immobilization" are in order
                    else if(matchScore)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        
                        // Results picked up for display
                        // self.results = (@"Suit Matched");
                        // self.results = [NSString stringWithFormat:@"Suit Matched: %d points", (matchScore * MATCH_BONUS)];
                        self.results = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, (matchScore * MATCH_BONUS)];

                    }
                    // A failure to match means gettingput facedown
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        
                        // Results picked up for display
                        // self.results = (@"Mismatch");
                        // FORMATTING self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];                        
                        // self.results = [NSString stringWithFormat:@"Mismatch: %d point penalty", MISMATCH_PENALTY];
                        self.results = [NSString stringWithFormat:@"%@ & %@ Don't match! %d point penalty", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    // Breakout since we've found another face up card
                    break;
                }
            }
            // To create more of a challenge, there is a cost to flipping
            self.score -= FLIP_COST; // Moved out of last loop            
                        
        }
        // Now flip the card
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
    
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init]; //Designated inits call their supers' DIs, Convinience Inits call their DI's initializer
    
    if (self)
    {
        for (int i=0; i<count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card) //checking that we haven't run out of cards
            {
                self.cards[i] = card; // requires lazy instantiation, cards could be contain nil causing this line to do nothing
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end
