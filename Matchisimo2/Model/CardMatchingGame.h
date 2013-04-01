//
//  CardMatchingGame.h
//  Matchisimo2
//
//  Created by Brandon White on 3/25/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#import "CardFlip.h"

@interface CardMatchingGame : NSObject

//designated intializer
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
              gameMode:(NSUInteger)gameMode;

-(void)flipCardAtIndex:(NSInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic) NSUInteger matchCount;


@property (nonatomic,readonly) NSMutableArray *lastFlippedCards;
@property (nonatomic,readonly) int score;
@property (nonatomic,readonly) int lastScore;
- (NSUInteger)messageCount;
- (NSString *)messageAtIndex:(NSUInteger)index;
@end
