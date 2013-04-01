//
//  PlayingCard.m
//  Matchisimo2
//
//  Created by Brandon White on 3/10/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import "Card.h"
#import "PlayingCard.h"



@implementation PlayingCard
@synthesize suit=_suit;


- (int)match:(NSArray *)otherCards {
    int score = 0;
    BOOL matchRank = YES;
    BOOL matchSuit = YES;
    for (id otherCard in otherCards) {
        
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *) otherCard;
            NSLog(@"otherPlayingCard is: %@",otherPlayingCard.contents);
            if (![otherPlayingCard.suit isEqualToString:self.suit]) {
                matchSuit =NO;
                //score = 2;
            }
            if (otherPlayingCard.rank != self.rank) {
                matchRank = NO;
                //score = 4;
            }            
        }
    }
    score += matchSuit ? 1 : 0;
    score += matchRank ? 4 : 0;
    return score;
}


- (NSString *)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit {
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit=suit;
    }
}

- (NSString *) suit {
    return _suit ? _suit:@"?";
}

- (void)setRank:(NSUInteger)rank {
    if(rank<=[PlayingCard maxRank]){
        _rank = rank;
    }

}

+ (NSArray *)validSuits {
    static NSArray *validSuits = nil;
    if(!validSuits)validSuits=@[@"♥", @"♦", @"♠", @"♣"];
    return validSuits;
}

+(NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSUInteger)maxRank {
     return [self rankStrings].count-1;
    }

@end
