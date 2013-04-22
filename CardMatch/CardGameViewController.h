//
//  CardGameViewController.h
//  CardMatch
//
//  Created by Akinbiyi Lalude on 2/28/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

//
// Master
//

#import <UIKit/UIKit.h>
#import "Deck.h" // import as part of abstraction upgrade vis a vis PlayingCardDeck removal

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary  *settingsDicReceiver;

- (Deck*)createDeck; //abstract
@property (nonatomic) NSUInteger startingCardCount; //abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; // abstract

@end
