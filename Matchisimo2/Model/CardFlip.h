//
//  CardFlip.h
//  Matchisimo2
//
//  Created by Brandon White on 3/27/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

typedef enum {
    NORMAL,
    MATCH,
    MISMATCH
} FlipType;

@interface CardFlip : NSObject

@property (readonly, nonatomic) FlipType type;
@property (readonly, weak, nonatomic) Card *card;
@property (readonly, nonatomic) int score;
@property (readonly, strong, nonatomic) NSArray *otherFaceUpPlayableCards; //of Card


// designated initializer
- (id)initWithType:(FlipType)type
          andScore:(int)score
           forCard:(Card *)card
andOtherFaceUpPlayableCards:(NSArray *)otherFaceUpPlayableCards; // of Card

@end