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

// Overrides match function in Card
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // For now matching against a single card
    if ([otherCards count] == 1) // *!* Changed from 0 to 1
    {
        
        PlayingCard *otherCard = [otherCards lastObject];
        
        // Points for matching suit
        if([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        
        // Points for matching rank
        else if (otherCard.rank == self.rank)
        {
            score = 4;
        }
    }
    
    return score;
}

// Grabs the suit and number of a card
- (NSString *)contents
{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

// Only necessary because both setter and getter manually created
@synthesize suit = _suit;

// The "setter" for suit
-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
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
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

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
















