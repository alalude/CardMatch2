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

/*
 Without this PlayingCardGame would be using the match function in Card via inheretance
 Card's match function only recognizes matches where both suit and rank are identical
 So it's necessary to create a more robust method that here that will overide Card's
 matching method and deliver PlayingCardGame the functionality it requires
 */
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // For now matching against a single card
    if ([otherCards count] == 1) // *!* Changed from 0 to 1
    {
        // Getting the card out of its array
        // One option is -->
        // PlayingCard *otherCard = [otherCards objectAtIndex:0];
        
        // But this never gives you an array index out of bounds
        PlayingCard *otherCard = [otherCards lastObject];
        
        // Testing Suite
        // NSLog(@"Card Contents - %@", self.contents);
        // NSLog(@"Other Card's Contents - %@", otherCard.contents);
        
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
    // Dot notation will work, but count is not a property
    // Properties are to do little if any calculations
    //return [self rankStrings].count -1;
    
    return [[self rankStrings] count] -1;
}

@end
















