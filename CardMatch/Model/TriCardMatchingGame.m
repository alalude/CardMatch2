//
//  TriCardMatchingGame.m
//  CardMatch
//
//  Created by Akinbiyi Adesina Lalude on 3/19/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "TriCardMatchingGame.h"

@interface TriCardMatchingGame()
// readwrite = unnesscary
@property (readwrite, nonatomic) int score;

@property (readwrite, nonatomic) NSString *results;

@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end


@implementation TriCardMatchingGame

// Lazy instantiation for cards in implementation of game intializer below
- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define BIG_MATCH_BONUS 8
#define BIGGEST_MATCH_BONUS 50
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

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
            for (Card *secondCard in self.cards)
            {
                
                if(secondCard.isFaceUp && !secondCard.isUnplayable)
                {
                    int matchScore = [card match:@[secondCard]];
                    
                    // If there is a rank match i.e. matchScore > 1, points and "immobilization" are in order
                    if(matchScore > 1)
                    {
                        
                        
                        
                        for (Card *thirdCard in self.cards)
                        {
                            
                            if(thirdCard.isFaceUp && !thirdCard.isUnplayable)
                            {
                                int matchScore = [card match:@[thirdCard]];
                                
                                // Testing Suite
                                NSLog(@"Card Contents - %@", card.contents);
                                NSLog(@"Second Card's Contents - %@", secondCard.contents);
                                NSLog(@"Third Card's Contents - %@", thirdCard.contents);
                                
                                // If there is a rank match i.e. matchScore > 1, points and "immobilization" are in order
                                if(matchScore > 1)
                                {
                                    card.unplayable = YES;
                                    secondCard.unplayable = YES;
                                    thirdCard.unplayable = YES;
                                    self.score += matchScore * BIGGEST_MATCH_BONUS;
                                    
                                    // Results picked up for display
                                    self.results = [NSString stringWithFormat:@"Matched %@, %@ & %@ for %d points", card.contents, secondCard.contents, thirdCard.contents, (matchScore * BIGGEST_MATCH_BONUS)];
                                }
                                
                                else
                                {
                                    secondCard.faceUp = NO;
                                    thirdCard.unplayable = NO;
                                    self.score -= MISMATCH_PENALTY;
                                    
                                    // Results picked up for display
                                    self.results = [NSString stringWithFormat:@"%@, %@ & %@ Don't match! %d point penalty", card.contents, secondCard.contents, thirdCard.contents, MISMATCH_PENALTY];
                                }
                                
                             }
                        }
                        
                        
                        
                        
                    }
                    
                    // If there is a suit match i.e. matchScore = 1, points and "immobilization" are in order
                    else if(matchScore)
                    {
                        
                        
                        
                        
                        for (Card *thirdCard in self.cards)
                        {
                            
                            if(thirdCard.isFaceUp && !thirdCard.isUnplayable)
                            {
                                int matchScore = [card match:@[thirdCard]];
                                
                                // Testing Suite
                                NSLog(@"Card Contents - %@", card.contents);
                                NSLog(@"Second Card's Contents - %@", secondCard.contents);
                                NSLog(@"Third Card's Contents - %@", thirdCard.contents);
                                
                                // If there is a rank match i.e. matchScore > 1, points and "immobilization" are in order
                                if(matchScore)
                                {
                                    card.unplayable = YES;
                                    secondCard.unplayable = YES;
                                    thirdCard.unplayable = YES;
                                    self.score += matchScore * BIG_MATCH_BONUS;
                                    
                                    // Results picked up for display
                                    self.results = [NSString stringWithFormat:@"Matched %@, %@ & %@ for %d points", card.contents, secondCard.contents, thirdCard.contents, (matchScore * BIG_MATCH_BONUS)];
                                }
                                
                                else
                                {
                                    secondCard.faceUp = NO;
                                    thirdCard.unplayable = NO;
                                    self.score -= MISMATCH_PENALTY;
                                    
                                    // Results picked up for display
                                    self.results = [NSString stringWithFormat:@"%@, %@ & %@ Don't match! %d point penalty", card.contents, secondCard.contents, thirdCard.contents, MISMATCH_PENALTY];
                                }
                                
                            }
                        }
                        
                        

                        
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

@end
