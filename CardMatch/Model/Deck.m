//
//  Deck.m
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

#import "Deck.h"

@interface Deck()
// An array to store the Cards "a deck"
@property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation Deck

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
        
    else
    {
        [self.cards addObject:card];
    }

}

- (Card *)drawRandomCard
{
    
    Card *randomCard = nil; // no need to initialize
    
    if(self.cards.count)
    {
        // Dot notation will work, but count is not a property
        // Properties are to do little if any calculations
        // unsigned index = arc4random() % self.cards.count;
        
        unsigned index = arc4random() % [self.cards count];
        
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
    
}

@end
