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
// readwrite = unnesscary, but an aid to code readabiltity
// brings eye to public readonly conterpart
@property (readwrite, nonatomic) int score;

@property (strong, nonatomic) NSMutableArray *cards; // of Card
// In objective-c there's no way to know the class(es) of objects in an array

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

- (void)flipCardAtIndex:(NSUInteger)index
{
    // First get the card at the designated index
    Card *card = [self cardAtIndex:index];
    
    int i = 1;
    
    // Now confirm there's a card at the index and it is playable
    if (card && !card.unplayable)
    {
        // To prevent comparing a card to itself
        if (!card.isFaceUp)
        {
            // Before simply fliping the card, check to see if it matches a card that's already up
            for (Card *otherCard in self.cards)
            {
                
                if(otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    // It would be nice to do
                    // int matchScore = [card match:otherCard];
                    // But match takes an array not a single card
                    
                    // Testing Suite
                    // NSLog(@"Card Contents - %@", card.contents);
                    // NSLog(@"Other Card's Contents - %@", otherCard.contents);
                    
                    int matchScore = [card match:@[otherCard]];
                    
                    // If there is a match i.e. matchScore > 0, points and "immobilization" are in order
                    if(matchScore)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    }
                    // A failure to match means gettingput facedown
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    // Breakout since we've found another face up card
                    break;
                }
            }
            // To create more of a challenge, there is a cost to flipping
            self.score -= FLIP_COST; // Moved out of last loop
            // Debugging Suite
            NSLog(@"Loop %d  Match Score %d", i, self.score);
            i++;
            
        }
        // Now flip the card
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    // This could be enough
    // return self.cards[index];
    
    // But it is better to be protective with an if/then/else statement
    return (index < [self.cards count]) ? self.cards[index] : nil;
    
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init]; //Designated inits call their supers' DIs
    // Convinience Inits call their DI's initializer
    
    if (self)
    {
        for (int i=0; i<count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card) //checking that we haven't run out of cards
            {
                self.cards[i] = card; // requires lazy instantiation
                //cards could be contain nil causing this line to do nothing
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
