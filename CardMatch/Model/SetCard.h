//
//  SetCard.h
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/27/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "PlayingCard.h"

@interface SetCard : Card

//-----------------------------------------------------------------
// Very unhappy with this, it should be inherited from PlayingCard.h

@property (strong, nonatomic) NSString *suit;

//-----------------------------------------------------------------

@property (nonatomic) NSInteger rank;
@property (nonatomic) CGFloat shade;
@property (strong, nonatomic) UIColor *color;

+ (NSArray *)validSuits;
+ (NSArray *)validRanks;
+ (NSArray *)validColors;
+ (NSArray *)validShades;
// + (NSDictionary *)vColors;
// + (NSUInteger)maxRank;

@end
