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
#define RESULTS_LABEL_FONT_SIZE 12.0

- (void)flipCardAtIndex:(NSUInteger)index
{
    //Disable game mode selector
    self.activeModeControl = NO;
    
    // First get the card at the designated index
    Card *card = [self cardAtIndex:index];
    
   
    // Now confirm there's a card at the index and it is playable
    if (card && !card.isUnplayable)
    {
        
        if ([card.contents isKindOfClass: [NSAttributedString class]])
        {
            self.results = [[NSMutableAttributedString alloc] initWithString:@"Results"];
            self.gameType = @"Set Matching";                                                                    // *!*
            // NSLog(@"1) CMG.m gameType %@", self.gameType);
        }
        else
        {
            self.results = (@"Results");    
            self.gameType = @"Card Matching";                                                                   // *!*
            // NSLog(@"CMG.m gameType %@", self.gameType);
        }
        
        
        
        // To prevent comparing a card to itself
        if (!card.isFaceUp)
        {
            // NSLog(@"2) CMG.m card is not face up");
            
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
                // NSLog(@"3) CMG.m card.contents isKindOfClass NSAttributedString");
                
                // NSDictionary  *otherCardsDic = [[NSDictionary alloc] init];
                NSMutableDictionary  *otherCardsDic = [[NSMutableDictionary alloc] init];
                
                int dicID = 1;
                
                for (Card *otherCard in otherCards)
                {
                    //otherCardsDic = @{@(dicID) : otherCard.contents};
                    [otherCardsDic setObject:otherCard.contents forKey: @(dicID)];
                    
                    // NSLog(@"dicID %i, entry %@", dicID, [otherCard.contents string]);
                    dicID++;
                    
                }
                
                // Dynamic text for resultsLabel
                NSMutableAttributedString *mainCard = [card.contents mutableCopy];
                NSMutableAttributedString *secondCard = [[otherCardsDic objectForKey: @(1)] mutableCopy];
                NSMutableAttributedString *thirdCard = [[otherCardsDic objectForKey: @(2)] mutableCopy];
                
                // Static text for resultsLabel
                NSMutableAttributedString *ampersand = [[NSMutableAttributedString alloc] initWithString:@" & "];
                NSMutableAttributedString *areASet = [[NSMutableAttributedString alloc] initWithString:@" are a set worth "];
                NSMutableAttributedString *arentASet = [[NSMutableAttributedString alloc] initWithString:@" aren't a set, "];
                NSMutableAttributedString *rewardEnding = [[NSMutableAttributedString alloc] initWithString:@" points"];
                NSMutableAttributedString *penaltyEnding = [[NSMutableAttributedString alloc] initWithString:@" point penalty"];
                
                NSRange textRange = [[self.results string] rangeOfString: [self.results string]];
            
                
                // If only one card is flipped
                if ([otherCards count] < 2)                                     // self.numberOfMatchingCards
                {
                    // self.results = [NSString stringWithFormat:@"Flipped up %@", card.contents];           // *!*
                    
                    // NSLog(@"4) CMG.m only one card flipped");
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
                        
                        NSString *reward = [NSString stringWithFormat: @"%d", (matchScore * MATCH_BONUS * MATCH_BONUS)];
                        NSMutableAttributedString *pointsEarned = [[NSMutableAttributedString alloc] initWithString: reward];
                        NSLog(@"Score for set: %@", reward);
                        
                        self.score += matchScore * MATCH_BONUS * MATCH_BONUS;
                        
                        //self.results = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, [otherContents componentsJoinedByString:@" & "], matchScore * MATCH_BONUS];
                        
                        [self.results replaceCharactersInRange:textRange withString:@"Yes, "];
                        [self.results appendAttributedString: thirdCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: secondCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: mainCard];
                        [self.results appendAttributedString: areASet];
                        [self.results appendAttributedString: pointsEarned];
                        [self.results appendAttributedString: rewardEnding];
                        
                        // NSLog(@"3 form a match: %@", [self.results string]);
                        
                    }
                    
                    
                    else
                    {
                        
                        for (Card *otherCard in otherCards)
                        {
                            otherCard.faceUp = NO;
                        }
                        
                        NSString *penalty = [NSString stringWithFormat: @"%d", MISMATCH_PENALTY];
                        NSMutableAttributedString *pointsLost = [[NSMutableAttributedString alloc] initWithString: penalty];
                        NSLog(@"Score for no set: %@", penalty);
                        
                        self.score -= MISMATCH_PENALTY;
                        
                        // self.results = [NSString stringWithFormat:@"%@ & %@ don’t match! %d point penalty!", card.contents, [otherContents componentsJoinedByString:@" & "], MISMATCH_PENALTY];
                        
                        [self.results replaceCharactersInRange:textRange withString:@"No, "];
                        [self.results appendAttributedString: thirdCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: secondCard];
                        [self.results appendAttributedString: ampersand];
                        [self.results appendAttributedString: mainCard];
                        [self.results appendAttributedString: arentASet];
                        [self.results appendAttributedString: pointsLost];
                        [self.results appendAttributedString: penaltyEnding];
                        
                        // NSLog(@"3 don't form a match: %@", [self.results string]);
                         
                    }
                    
                    /*
                    // Center and Set Font Size
                    NSRange range = [[self.results string] rangeOfString:[self.results string]];
                    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
                    [paragrahStyle setAlignment: NSTextAlignmentCenter];
                    
                    if (range.location != NSNotFound)
                    {
                        NSMutableAttributedString *resultsAttrText = [self.results mutableCopy];
                        [resultsAttrText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:RESULTS_LABEL_FONT_SIZE] range:range];
                        [resultsAttrText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:range];
                        
                        self.results = resultsAttrText;
                    }
                     */
                    
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
                    // NSLog(@"flipCardAtIndex: 2+ cards flipped");
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
