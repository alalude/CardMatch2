//
//  SetCard.m
//  CardMatch
//
//  Created by Akinbiyi Lalude on 3/27/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "SetCard.h"


@implementation SetCard


//-----------------------------------------------------------------
// Matching method for SetCardGame
//-----------------------------------------------------------------

/*
 
 Rules
 ------------------------------------------------------------------
 
 1) They all have the same symbol, or they have three different symbols.
    suit(1) = suit(2) = suit(3) || suit(1) ≠ suit(2) ≠ suit(3) ≠ suit(1)
 
 2) They all have the same number, or they have three different numbers.
    rank(1) = rank(2) = rank(3) || rank(1) ≠ rank(2) ≠ rank(3) ≠ rank(1)
 
 3) They all have the same color, or they have three different colors.
    color(1) = color(2) = color(3) || color(1) ≠ color(2) ≠ color(3) ≠ color(1)
 
 4) They all have the same shading, or they have three different shadings.
    shade(1) = shade(2) = shade(3) || shade(1) ≠ shade(2) ≠ shade(3) ≠ shade(1) 
 
 */

// Overrides match function in Card/PLayingCard
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int dicID = 0;
    
    BOOL suitSet = NO;
    BOOL rankSet = NO;
    BOOL colorSet = NO;
    BOOL shadeSet = NO;
    
    NSDictionary  *otherCardsDic;
    NSDictionary  *firstCard;
    NSDictionary  *secondCard;
    
    if ([otherCards count] > 1)
    {        
        for (SetCard *otherCard in otherCards)
        {
            otherCardsDic = @{@(dicID) : otherCard.rawContents};
            dicID++;
        }
    
        // Two Cards for Comparison
        firstCard = [otherCardsDic objectForKey: @(0)];
        secondCard = [otherCardsDic objectForKey: @(1)];
        
        // All Three Cards' Charachteristics
        
        NSString *mainSuit = [self.rawContents objectForKey: @"suit"];
        NSInteger mainRank = [[self.rawContents objectForKey: @"rank"] intValue];
        UIColor *mainColor = [self.rawContents objectForKey: @"color"];
        CGFloat mainShade = [[self.rawContents objectForKey: @"shade"] floatValue];
        
        NSString *firstSuit = [firstCard objectForKey: @"suit"];
        NSInteger firstRank = [[firstCard objectForKey: @"rank"] intValue];
        UIColor *firstColor = [firstCard objectForKey: @"color"];
        CGFloat firstShade = [[firstCard objectForKey: @"shade"] floatValue];
        
        NSString *secondSuit = [secondCard objectForKey: @"suit"];
        NSInteger secondRank = [[secondCard objectForKey: @"rank"] intValue];
        UIColor *secondColor = [secondCard objectForKey: @"color"];
        CGFloat secondShade = [[secondCard objectForKey: @"shade"] floatValue];
        
        // Rule Format
        // if ((x = y && y = z && z = x) || (x != y && y != z && z != x))
        
        // 1) They all have the same symbol, or they have three different symbols
        if (([mainSuit isEqualToString: firstSuit] && [firstSuit isEqualToString: secondSuit] && [secondSuit isEqualToString: mainSuit]) ||
            ([mainSuit isEqualToString: firstSuit] == FALSE && [firstSuit isEqualToString: secondSuit] == FALSE && [secondSuit isEqualToString: mainSuit] == FALSE))
        {suitSet = YES;}
        
        // 2) They all have the same number, or they have three different numbers
        if ((mainRank == firstRank && firstRank == secondRank && secondRank == mainRank) ||
            (mainRank != firstRank && firstRank != secondRank && secondRank != mainRank))
        {rankSet = YES;}
        
        // 3) They all have the same color, or they have three different colors
        if (([mainColor isEqual: firstColor] && [firstColor isEqual: secondColor] && [secondColor isEqual: mainColor]) ||
            ([mainColor isEqual: firstColor] == FALSE && [firstColor isEqual: secondColor] == FALSE && [secondColor isEqual: mainColor] == FALSE))
        {colorSet = YES;}
        
        // 4) They all have the same shading, or they have three different shadings
        if ((mainShade == firstShade && firstShade == secondShade && secondShade == mainShade) ||
            (mainShade != firstShade && firstShade != secondShade && secondShade != mainShade))
        {shadeSet = YES;}
        
        if(suitSet && rankSet && colorSet && shadeSet)
        {score = 1;}
        
        else { score = 0; }
    }
    
    return score;
    
    
    /*
    if ([otherCards count])
    {
        int suitCount = 0;
        int rankCount = 0;
        int colorCount = 0;
        int shadeCount = 0;
        
        NSString *lastSuit = [[[otherCards lastObject] rawContents] objectForKey: @"suit"];
        NSInteger lastRank = [[[[otherCards lastObject] rawContents] objectForKey: @"rank"] intValue];
        UIColor *lastColor = [[[otherCards lastObject] rawContents] objectForKey: @"color"];
        CGFloat lastShade = [[[[otherCards lastObject] rawContents] objectForKey: @"shade"] floatValue];
        
        for (SetCard *otherCard in otherCards)
        {
            NSString *otherSuit = [otherCard.rawContents objectForKey: @"suit"];
            NSInteger otherRank = [[otherCard.rawContents objectForKey: @"rank"] intValue];
            UIColor *otherColor = [otherCard.rawContents objectForKey: @"color"];
            CGFloat otherShade = [[otherCard.rawContents objectForKey: @"shade"] floatValue];
        
            if ([otherSuit isEqualToString:self.suit]) suitCount++;
            else { suitCount--; }
            
            if (otherRank == self.rank) rankCount++;
            else { rankCount--; }
            
            if ([otherColor isEqual:self.suit]) colorCount++;
            else { colorCount--; }
            
            if (otherShade == self.rank) shadeCount++;
            else { shadeCount--; }
        }
    }
     */
    
}

//-----------------------------------------------------------------
// Content fetcher method for SetCards
//-----------------------------------------------------------------

// Grabs the attributed text of a card
- (NSAttributedString *)contents
{
    /*
     - (void)addTextAttributes:(NSDictionary *)attributes range:(NSRange) range
     {
     }
     */
    
    // initWithObjects:forKeys:
    
    NSString *cardSuit = [self.rawContents objectForKey: @"suit"];
    NSInteger cardRank = [[self.rawContents objectForKey: @"rank"] intValue];
    UIColor *cardColor = [self.rawContents objectForKey: @"color"];
    CGFloat cardShade = [[self.rawContents objectForKey: @"shade"] floatValue];
    
    for (NSUInteger loopCount = cardRank; loopCount > 1; loopCount--)
    {
        cardSuit = [cardSuit stringByAppendingString: cardSuit];
    }
    
    NSRange textRange = [cardSuit rangeOfString: cardSuit];

    NSMutableAttributedString *cardText = [cardSuit mutableCopy];

    NSDictionary *cardTextAttributes = @{NSForegroundColorAttributeName : [cardColor colorWithAlphaComponent: cardShade],
                                             NSStrokeWidthAttributeName : @-3,
                                             NSStrokeColorAttributeName : cardColor};
    
    [cardText addAttributes:cardTextAttributes range: textRange];
    
    return cardText;
}

//-----------------------------------------------------------------
// Setters and getters
//-----------------------------------------------------------------

// The "setter" for rank
// Hopefully overwrites inherited method
-(void)setRank:(NSInteger)rank
{
    if([[SetCard validRanks] containsObject:[NSNumber numberWithInteger:rank]]) // *!* SetCard = [self class]
    {
        _rank = rank;
    }
}

// The "setter" for color
-(void)setColor:(UIColor *)color
{
    if([[SetCard validColors] containsObject:color]) // *!* SetCard = [self class]
    {
        _color = color;
    }
}

// The "setter" for alpha
-(void)setShade:(CGFloat)shade
{
    if([[SetCard validShades] containsObject:[NSNumber numberWithFloat:shade]]) // *!* SetCard = [self class]
    {
        _shade = shade;
    }
}

//-----------------------------------------------------------------
// Raw materials to build SetCards
//-----------------------------------------------------------------

// Method does work directly on class not eligible to use @property
+ (NSArray *)validSuits
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validRanks
{
    return @[@(1), @(2), @(3)];
}

+ (NSArray *)validColors
{
    return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSArray *)validShades
{
    return @[@(1.0), @(0.2), @(0.0)];
}

/*
+ (NSDictionary *)vColors
{
    return @{@"red" : [UIColor redColor], @"green" : [UIColor greenColor], @"blue" : [UIColor blueColor]};
 
    return @{@"suit" : [UIColor redColor], @"rank" : [UIColor greenColor], @"color" : [UIColor blueColor], @"shade" : [UIColor greenColor]};
}*/

@end
