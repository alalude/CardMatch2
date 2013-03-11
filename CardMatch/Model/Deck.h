//
//  Deck.h
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

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

// A method that takes 2 arguements and returns 0
- (void)addCard:(Card *)card atTop:(BOOL)atTop;

// A method that takes 0 arguements and returns "a Card"
- (Card *)drawRandomCard;

@end
