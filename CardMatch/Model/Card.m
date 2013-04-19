//
//  Card.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/1/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

//
// Coded in
// CS193 Winter 2013
// Lecture 1
//


#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) //Loop to match an array
    {
        
        if ([card.contents isEqualToString:self.contents]) //Code to judge match quality of a card
        {
            score = 1;
        }
        
    }
    
    return score;
}

    /*
     // Lazy instantiation
    // -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    - (UIImage *)cardBack
    {
        if (!_cardBack) _cardBack = [UIImage imageNamed: @"cardBackStripes.png"];
        return _cardBack;
    }

    // -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

    // Default cardBack
    // self.cardBack = [UIImage imageNamed: @"cardBackAbstract.png"] ;

    // gotta init this some place, its a member of card
     */


@end

