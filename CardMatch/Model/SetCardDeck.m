//
//  SetCardDeck.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/27/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

//
// Coded in
// CS193 Winter 2013
// Assignment 2
//

#import "SetCardDeck.h"
#import "SetCard.h"


@implementation SetCardDeck

//-----------------------------------------------------------------
// Creating an 81 card Set deck
//-----------------------------------------------------------------

- (id)init
{
    // This line is a very rare case
    self = [super init];
    
    if (self)
    {
        for (NSString *suit in [SetCard validSuits])
        {
            for (NSNumber *rank in [SetCard validRanks])
            {
                for (UIColor *color in [SetCard validColors])
                {
                    for (NSNumber *shade in [SetCard validShades])
                    {
                        SetCard *card = [[SetCard alloc] init];
                        // calling the setters
                        card.suit = suit; // inheritance issue -- forced to add property to SetCard.h
                        card.rank = [rank intValue];
                        card.color = color;
                        card.shade = [shade floatValue];
                        
                        // testing
                        //card.unplayable = YES;                        
                        
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }        
    }
    
    return self;
    
}

@end


/*
- (id)init
{
    // This line is a very rare case
    self = [super init];
    
    if (self)
    {
        for (NSString *suit in [PlayingCard validSuits])
        {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc] init];
                // calling the setters
                card.rank = rank;
                card.suit = suit;
                
                [self addCard:card atTop:YES];
            }
        }
        
    }
    
    return self;
    
}
*/



