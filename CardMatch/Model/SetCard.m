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


//-----------------------------------------------------------------
// Content fetcher method for SetCards
//-----------------------------------------------------------------


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
// Syntaxt for string attributes
//-----------------------------------------------------------------

- (void)addTextAttributes:(NSDictionary *)attributes range:(NSRange) range
{
    
    NSAttributedString *attributedString = @{NSForegroundColorAttributeName : [[UIColor greenColor] colorWithAlphaComponent:0.2],
                                             NSStrokeWidthAttributeName : @-3,
                                             NSStrokeColorAttributeName : [UIColor greenColor]};
    
    // Assuming the range has been found
    if (range.location != NSNotFound)
    {
        // Get a mutable version of the string to work with
    //    NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
        
        // Add attributes to the range of text
    //    [mat addAttributes:attributes range:range];
        
        // Update the attributed text
    //    self.label.attributedText = mat;
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
}*/

@end
