//
//  CardMatchingGame.h
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

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// DESIGNATED INITIALIZER
// Method to initialize the game
// It is more complex than initializers for simpler objects
// It cannot be initialized until it is known how many cards are expected and from which deck
// It takes an arguement for card count and a deck
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

// A method to flip cards back and forth, check if they match, get the score, and such
- (void)flipCardAtIndex:(NSUInteger)index;

// Get a card to update UI
- (Card *)cardAtIndex:(NSUInteger)index;

// readonly = only has a getter
@property (readonly, nonatomic) int score;

@end
