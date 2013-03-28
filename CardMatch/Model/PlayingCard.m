//
//  PlayingCard.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/1/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

//
// Coded in
// CS193 Winter 2013
// Lecture 2
//

#import "PlayingCard.h"

@implementation PlayingCard


//-----------------------------------------------------------------
// Matching method for PlayingCardGame
//-----------------------------------------------------------------

// Overrides match function in Card
- (int)match:(NSArray *)otherCards
{

    int score = 0;
    
    if ([otherCards count])
    {
        for (PlayingCard *otherCard in otherCards)
        {
            if ([otherCard.suit isEqualToString:self.suit])
            {
                score += 1;
            }
            
            else if (otherCard.rank == self.rank)
            {
                score += 4;
            }
            
            else
            {
                score = 0;
                break;
            }
        }
    }
    
    return score;
    
}


//-----------------------------------------------------------------
// Content fetcher method for PlayingCards
//-----------------------------------------------------------------

// Grabs the suit and number of a card
- (NSString *)contents
{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}


//-----------------------------------------------------------------
// Setters and getters DUPLICATED
//-----------------------------------------------------------------

// Only necessary because both setter and getter manually created
@synthesize suit = _suit;

// The "setter" for suit
-(void)setSuit:(NSString *)suit
{
    if([[[self class] validSuits] containsObject:suit]) // *!* PlayingCard = [self class]
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [[self class] maxRank]) // *!* PlayingCard = [self class]
    {
        _rank = rank;
    }
}


//-----------------------------------------------------------------
// Raw materials to build PlayingCards DUPLICATED
//-----------------------------------------------------------------

// Method does work directly on class not eligible to use @property
+ (NSArray *)validSuits
{
    return @[@"♣", @"♦", @"♥", @"♠"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] -1;
}

@end
















