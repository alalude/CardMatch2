//
//  GameResult.h
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/25/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

//
// Coded in
// CS193 Winter 2013
// Lecture 5
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; // of GameResult

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;

// This does not need to be read write because it will be calculated each time it's requested
@property (readonly, nonatomic) NSTimeInterval duration;

@property (nonatomic) int score;

- (NSComparisonResult)compareDate:(GameResult *)aGameResult;
- (NSComparisonResult)compareScore:(GameResult *)aGameResult;
- (NSComparisonResult)compareDuration:(GameResult *)aGameResult;

@end
