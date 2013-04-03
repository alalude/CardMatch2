//
//  Card.h
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

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) id contents; // formerly NSString *contents now can be NSMutableAttributedString
@property (strong, nonatomic) NSMutableAttributedString *cardAttributedString;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
