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

// Grabs the suit and number of a card
- (NSString *)contents
{
    // 11 of hearts not the jack of hearts :-(
    // return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
    // Generic means
    // NSArray *rankString = @[@"?", @"A", @"2", @"3", ..., @"10", @"J", @"Q", @"K"];
    
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

// Only necessary because both setter and getter manually created
@synthesize suit = _suit;

// A simple approach
// -(void)setSuit:(NSString *)suit
// {
//     if([@[@"♣", @"♦", @"♥", @"♠"] containsObject:suit])
//     {
//         _suit = suit;
//     }
// }

// Method does work directly on class not eligible to use @property
+ (NSArray *)validSuits
{
    return @[@"♣", @"♦", @"♥", @"♠"];
}

// The "setter" for suit
-(void)setSuit:(NSString *)suit
{
    // Example of calling a class method
    // Not "[" pointer to an instance of a class
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}


+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
















