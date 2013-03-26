//
//  GameResult.m
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

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

/* Basic anatomy of an init
     - (id)init
     {
         self = [super init];
         if (self)
         {
         
         }
     
         return self;
     }
 */

// DESIGNATED INTIALIZER
- (id)init
{
    self = [super init];
    if (self)
    {
        // NOTE self.start isn't being called
        // This is because we want to be able to write setters and getters
        // where we can assume their objects are fully initialized
        
         _start = [NSDate date]; // date is a method that returns the date/time at the momentit's called
        _end = _start;
    }
    
    return self;
}

#define ALL_RESULTS_KEY @"GameResult_All"
// remember since this is being stored at the top level of defaults, so it must have a unique name, "All" won't cut it

#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"

+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    
    // get it out of user defaults and itterate through all of it's values
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues])
    {
        // unpackage things to create a game result
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults ;
}

// CONVENIENCE INITIALIZER
-(id) initFromPropertyList:(id)plist
{
    self = [self init]; // NOTE not super init
    
    // Look in plist and set start, end, and score
    if (self)
    {
        // confirm tht you've been passed a dictionary
        if ([plist isKindOfClass:[NSDictionary class]])
        {
            // create a local dictionary
            NSDictionary *resultDictionary = (NSDictionary *)plist; // casted the plist just for clarity
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue]; // this must be turned back into an int because it's been stored as an NSNumber
            
            // a little saftey check
            if (!_start || !_end) self = nil;
        }
    }
    
    return self;
}

// getter
- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

// setter
- (void)setScore:(int)score
{
    _score = score;
    // _end = [NSDate date]; shouldn't access another propety's "_"
    self.end = [NSDate date];
    [self synchronize]; //record the score
}

// write game results out to NSUserDefault
// 1. take it out
// 2. modify
// 3. put it back
// 4. synchronize
- (void)synchronize
{
    // Game results will be stored in a dictionary
    // The key for the dictionary will be a quniqe identifier, the time the game started
    // The value will be a property list that can be used to recreate the game result, another dictionary
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy]; // have to say mutable copy because things come out immutable even if they go in mutable
    
    // if there isn't allready a dictionary saved from previous play, initailize one now
    if(!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    
    // set the unique key
    // NSDates can't be keys in an NSDictionary, but strings can
    // So leverage description to get the start time as string
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    
    // Now put it back in NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList
{
     // return a dictionary
    return @{START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score)};
}

int i = 1;

- (NSComparisonResult)compareDate:(GameResult *)aGameResult
{
    NSLog(@"Compared for Date");
    NSLog(@"Date %@ (%d)", self.end, i);
    i++;
    
    return ([self.end compare:aGameResult.end]);
}

- (NSComparisonResult)compareScore:(GameResult *)aGameResult
{
    NSLog(@"Compared for Score");
    NSLog(@"Score %d (%d)", self.score, i);
    i++;
    
    return ([@(self.score) compare:@(aGameResult.score)]);
}

- (NSComparisonResult)compareDuration:(GameResult *)aGameResult
{
    NSLog(@"Compared for Duration");
    NSLog(@"Duration %0g (%d)", self.duration, i);
    i++;
    
    return ([@(self.duration) compare:@(aGameResult.duration)]);
}

@end














