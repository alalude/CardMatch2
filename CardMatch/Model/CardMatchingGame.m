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

@property (readwrite, nonatomic) id results; // NSString or NSMutableAttributedString

@property (strong, nonatomic) NSMutableArray *cards; // of Card


@end

/*
 // Testing Suite
 NSLog(@"Rank Matched, Score %d", self.score);
 NSLog(@"Card Contents - %@", card.contents);
 NSLog(@"Other Card's Contents - %@", otherCard.contents);
 */

@implementation CardMatchingGame

// Lazy instantiation for cards in implementation of game intializer below
- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// Lazy instantiation
- (int)numberOfMatchingCards
{
    if (!_numberOfMatchingCards) _numberOfMatchingCards = 3; // 3... Hopefully will work for both games
    return _numberOfMatchingCards;
}

/*
 
 Not sure this code is really necessary
 
 - (void)setNumberOfMatchingCards:(int)numberOfMatchingCards
 {
 if (numberOfMatchingCards < 2) _numberOfMatchingCards = 2;
 else if (numberOfMatchingCards > 3) _numberOfMatchingCards = 3;
 else _numberOfMatchingCards = numberOfMatchingCards;
 }
 
 */

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index            // --- Start the War Here --- //
{
    //Disable game mode selector
    self.activeModeControl = NO;
    
    // First get the card at the designated index
    Card *card = [self cardAtIndex:index];
    
    
    
    // ---------------------------------------------------
    /*
    // self.deckIndex = index;
    //NSLog(@"self.deckIndex %d", self.deckIndex);
    
    if ([card.contents isKindOfClass: [NSAttributedString class]])                                           // card.contents //
    {
        NSLog(@"NSAttributedString card.contents %@", [card.contents string]);
    }
    else if ([card.contents isKindOfClass: [NSAttributedString class]])                                           // card.contents //
    {
        NSLog(@"NSMutableAttributedString card.contents %@", [card.contents string]);
    }
    else
    {
        NSLog(@"Introspection failure %@", [card.contents string]);
    }
     */
    // ---------------------------------------------------

    
   
    // Now confirm there's a card at the index and it is playable
    if (card && !card.isUnplayable)
    {
        
        if ([card.contents isKindOfClass: [NSAttributedString class]])
        {
            self.results = [[NSMutableAttributedString alloc] initWithString:@"Results"];
            NSLog(@"self.results init %@", [self.results string]);
        }
        else
        {
            self.results = (@"Results");                                                                        // *!*
        }
        
        
        
        // To prevent comparing a card to itself
        if (!card.isFaceUp)
        {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            NSMutableArray *otherContents = [[NSMutableArray alloc] init];
            
            // Before simply fliping the card, check to see if it matches a card that's already up
            for (Card *otherCard in self.cards)
            {
                // If cards are playable, put them in arrays to work with
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [otherCards addObject:otherCard];
                    [otherContents addObject:otherCard.contents];
                }
            }
            
            
            if ([card.contents isKindOfClass: [NSAttributedString class]])
            {
                // NSDictionary  *otherCardsDic = [[NSDictionary alloc] init];
                NSMutableDictionary  *otherCardsDic = [[NSMutableDictionary alloc] init];
                
                int dicID = 1;
                
                for (Card *otherCard in otherCards)
                {
                    //otherCardsDic = @{@(dicID) : otherCard.contents};
                    [otherCardsDic setObject:otherCard.contents forKey: @(dicID)];
                    
                    NSLog(@"dicID %i, entry %@", dicID, [otherCard.contents string]);
                    dicID++;
                    
                }
                
                // Dynamic text for resultsLabel
                NSMutableAttributedString *mainCard = [card.contents mutableCopy];
                NSMutableAttributedString *secondCard = [[otherCardsDic objectForKey: @(1)] mutableCopy];
                NSMutableAttributedString *thirdCard = [[otherCardsDic objectForKey: @(2)] mutableCopy];
                
                // Static text for resultsLabel
                NSMutableAttributedString *ampersand = [[NSMutableAttributedString alloc] initWithString:@" & "];
                NSMutableAttributedString *areASet = [[NSMutableAttributedString alloc] initWithString:@" are a set"];
                NSMutableAttributedString *arentASet = [[NSMutableAttributedString alloc] initWithString:@" aren't a set"];
                
                NSRange textRange = [[self.results string] rangeOfString: [self.results string]];
            
                
                // If only one card is fliped
                if ([otherCards count] < 2)                                     // self.numberOfMatchingCards
                {
                    // self.results = [NSString stringWithFormat:@"Flipped up %@", card.contents];           // *!*
                    
                    [self.results replaceCharactersInRange:textRange withString:@"Flipped up "];
                    [self.results appendAttributedString: mainCard];                    
                }
                
                
                else
                {
                    int matchScore = [card match:otherCards];                                               // card.contents
                    
                    if (matchScore)
                    {
                        
                        card.unplayable = YES;
                        
                        for (Card *otherCard in otherCards)
                        {
                            otherCard.unplayable = YES;
                        }
                        
                        self.score += matchScore * MATCH_BONUS * MATCH_BONUS;
                        NSLog(@"Score for set: %d", self.score);
                        
                        //self.results = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, [otherContents componentsJoinedByString:@" & "], matchScore * MATCH_BONUS];
                        
                        
                        [self.results replaceCharactersInRange:textRange withString:@"Yes, "];
                        [self.results appendAttributedString: thirdCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: secondCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: mainCard];
                        [self.results appendAttributedString: areASet];
                        
                        NSLog(@"3 form a match: %@", [self.results string]);
                        
                    }
                    
                    
                    else
                    {
                        
                        for (Card *otherCard in otherCards)
                        {
                            otherCard.faceUp = NO;
                        }
                        
                        self.score -= MISMATCH_PENALTY;
                        NSLog(@"Score for no set: %d", self.score);
                        
                        // self.results = [NSString stringWithFormat:@"%@ & %@ don’t match! %d point penalty!", card.contents, [otherContents componentsJoinedByString:@" & "], MISMATCH_PENALTY];
                        
                        
                        [self.results replaceCharactersInRange:textRange withString:@"No, "];
                        [self.results appendAttributedString: thirdCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: secondCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: mainCard];
                        [self.results appendAttributedString: arentASet];
                        
                        NSLog(@"3 don't form a match: %@", [self.results string]);
                         
                    }
                    
                    
                }
            }
            
            
            
            else
            {
                // If only one card is fliped
                if ([otherCards count] < self.numberOfMatchingCards - 1)
                {
                    self.results = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                }
                
                else
                {
                    NSLog(@"flipCardAtIndex: 2+ cards flipped");
                    int matchScore = [card match:otherCards];
                    
                    if (matchScore)
                    {
                        card.unplayable = YES;
                        
                        for (Card *otherCard in otherCards)
                        {
                            otherCard.unplayable = YES;
                        }
                        
                        self.score += matchScore * MATCH_BONUS;                                             
                        
                        self.results = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, [otherContents componentsJoinedByString:@" & "], matchScore * MATCH_BONUS];
                    }
                    
                    else
                    {
                        for (Card *otherCard in otherCards)
                        {
                            otherCard.faceUp = NO;
                        }
                        
                        self.score -= MISMATCH_PENALTY;                                                    
                        self.results =
                        [NSString stringWithFormat:@"%@ & %@ don’t match! %d point penalty!", card.contents, [otherContents componentsJoinedByString:@" & "], MISMATCH_PENALTY];
                    }
                }
             }
             
            
       
            
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
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
    self.activeModeControl = YES; // initialize game mode selector to active
    self.score = 0; // initialize score to zero (for new games)
    return self;
}

@end
