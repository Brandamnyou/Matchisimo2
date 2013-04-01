//
//  Deck.m
//  Matchisimo2
//
//  Created by Brandon White on 3/10/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation Deck

-(NSMutableArray *)cards{
    if(!_cards)_cards =[[NSMutableArray alloc]init];
    return _cards;
}

- (Card *)drawRandomCard {
    Card * randomCard = nil;
    if(self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

- (void)addCard:(Card *)card
          atTop:(BOOL)atTop {
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }else{  [self.cards addObject:card];

        }
    }

@end