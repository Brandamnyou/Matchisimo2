//
//  CardFlip.m
//  Matchisimo2
//
//  Created by Brandon White on 3/27/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import "CardFlip.h"


@interface CardFlip()
@property (readwrite, nonatomic) FlipType type;
@property (readwrite, weak, nonatomic) Card *card;
@property (readwrite, nonatomic) int score;
@property (readwrite, strong, nonatomic) NSArray *otherFaceUpPlayableCards; // of Card
@end

@implementation CardFlip

- (id)init {
    return nil;
}

// designated initializer
- (id)initWithType:(FlipType)type
          andScore:(int)score
           forCard:(Card *)card
andOtherFaceUpPlayableCards:(NSArray *)otherFaceUpPlayableCards
{
    self = [super init];
    
    if(self) {
        self.card = card;
        self.type = type;
        self.score = score;
        self.otherFaceUpPlayableCards = otherFaceUpPlayableCards;
    }
    
    return self;
}

@end