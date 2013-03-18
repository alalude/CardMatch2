//
//  PlayingCardDeck.m
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

#import "PlayingCardDeck.h"
#import "PlayingCard.h"


// Create a deck of 52 playing cards

@implementation PlayingCardDeck

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

@end
