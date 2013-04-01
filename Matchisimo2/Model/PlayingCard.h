//
//  PlayingCard.h
//  Matchisimo2
//
//  Created by Brandon White on 3/10/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

//#import "Card.h"

#import "Card.h"

@interface PlayingCard : Card 

//instance variable declaration
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

//method declarations
+(NSArray *)validSuits;
+(NSUInteger)maxRank;
@end
