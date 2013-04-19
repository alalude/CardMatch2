//
//  GameSettings.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 4/11/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "GameSettings.h"

@interface GameSettings()

// -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
// @property (strong, nonatomic) NSMutableDictionary  *settingsDic;

@end


@implementation GameSettings

/*
- (NSMutableDictionary *)settingsDic
{
    if(!_settingsDic) _settingsDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [UIImage imageNamed: @"cardBackStripes.png"], @"cardback", @"value2", @"setting2", @"value3", @"setting3", nil];
    return _settingsDic;
}
*/

// self.settingsDic;

// NSMutableDictionary  *otherCardsDic = [[NSMutableDictionary alloc] init];
// [otherCardsDic setObject:otherCard.rawContents forKey: @(dicID)];


+ (NSDictionary *)allSettings //allGameResults
{
    NSMutableDictionary *allSettings = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [UIImage imageNamed: @"cardBackDefault.png"], @"cardback", @"value2", @"setting2", @"value3", @"setting3", nil];
    
    /*
     UIImage *cardback = [self.settingsDic objectForKey: @"cardback"];
    NSMutableDictionary *allSettings = self.settingsDic;
    
     
    // NSMutableDictionary *allSettings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey: ALL_SETTINGS_KEY] mutableCopy];
    
    
    //---ignore---//
     // get it out of user defaults and itterate through all of it's values
     for (id settingsDictionary in [[[NSUserDefaults standardUserDefaults] dictionaryForKey: ALL_SETTINGS_KEY] allValues])
     {
     // unpackage things to create a game result
     Setting *setting = [[Setting alloc] initFromPropertyList: settingsDictionary];
     [allSettings addObject: setting];
     }
     //---ignore---//
    */
    
    return allSettings;
}

/*
NSDictionary *settingsDictionary = (NSDictionary *)plist; // casted the plist just for clarity
_start = settingsDictionary[START_KEY];
_end = settingsDictionary[END_KEY];
_score = [settingsDictionary[SCORE_KEY] intValue]; // this must be turned back into an int because it's been stored as an NSNumber

return self;



// CONVENIENCE INITIALIZER
-(id) initFromPropertyList:(id)plist
{
    self = [self init]; // NOTE not super init
    
    // Look in plist and set start, end, and score
    if (self)
    {
        // confirm that you've been passed a dictionary
        if ([plist isKindOfClass:[NSDictionary class]])
        {
            // create a local dictionary
            NSDictionary *resultDictionary = (NSDictionary *)plist; // casted the plist just for clarity
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue]; // this must be turned back into an int because it's been stored as an NSNumber
            
            NSLog(@"GameResults.m, data from initFromPropertyList: %@", resultDictionary[GAME_TYPE_KEY]);
            _gameType = resultDictionary[GAME_TYPE_KEY];                                                                   // *!*
            
            // a little saftey check
            if (!_start || !_end) self = nil;
        }
    }
    
    return self;
}
*/

#define ALL_SETTINGS_KEY @"Settings_All"
#define CARD_BACK_KEY @"CardBackType"

/*
// write game results out to NSUserDefault
// 1. take it out
// 2. modify
// 3. put it back
// 4. synchronize
- (void)synchronize
{
    // Settings will be stored in a dictionary
    // The key for the dictionary will be a uniqe identifier, the time the game started
    // The value will be a property list that can be used to recreate the game result, another dictionary
    NSMutableDictionary *mutableSettingsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey: ALL_SETTINGS_KEY] mutableCopy]; // have to say mutable copy because things come out immutable even if they go in mutable
    
    // Clear my existing settings
    // If there isn't allready a dictionary saved from previous play, initailize one now
    if(!mutableSettingsFromUserDefaults) mutableSettingsFromUserDefaults = [[NSMutableDictionary alloc] init];
    //if(mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    
    // set the unique key
    // NSDates can't be keys in an NSDictionary, but strings can
    // So leverage description to get the start time as string
    //--  mutableSettingsFromUserDefaults[[self.start description]] = [self asPropertyList];
    // asPropertyList - turns result into property list, so that it can go into NSUserDefaults
    
    // mutableSettingsFromUserDefaults = @{CARD_BACK_KEY : self.cardBack};
    mutableSettingsFromUserDefaults[CARD_BACK_KEY] = self.cardBack;
    
    
    
    // Now put it back in NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:mutableSettingsFromUserDefaults forKey: ALL_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
 */





@end
