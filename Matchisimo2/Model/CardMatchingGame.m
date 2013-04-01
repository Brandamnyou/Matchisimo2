//
//  CardMatchingGame.m
//  Matchisimo2
//
//  Created by Brandon White on 3/25/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

//private extentions
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; 
@property (nonatomic) int gameMode;
@property (strong, nonatomic) NSMutableArray *messages;
@end

// Class implementation
@implementation CardMatchingGame

//constants
#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define MAX_MESSAGES 50
#define MIN_MATCH_COUNT 2
#define MAX_MATCH_COUNT 3

//designated Initilizer
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
              gameMode:(NSUInteger)gameMode
{
    self = [super init];
    self.gameMode=gameMode;
    if(self){
        for (int i=0;i<cardCount;i++){
            Card *card=[deck drawRandomCard];
            if(!card){
                self=nil;
            }else{
                self.cards[i]=card;
            }
        }
    }
    return self;
}


// Returns the collection of game cards.
- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}


// Returns the collection of play messages.
- (NSMutableArray *)messages {
    if (!_messages) _messages = [[NSMutableArray alloc] init];
    return _messages;
}

// Custom synthesis
@synthesize matchCount  = _matchCount;

// Returns the number of game card matches to use.
- (NSUInteger)matchCount {
    if (!_matchCount) _matchCount = MIN_MATCH_COUNT;
    return _matchCount;
}

// Sets the number of game card matches to use.
- (void)setMatchCount:(NSUInteger)matchCount {
    _matchCount = (matchCount < MIN_MATCH_COUNT) ? MIN_MATCH_COUNT : (matchCount > MAX_MATCH_COUNT) ? MAX_MATCH_COUNT : matchCount;
}

// Flip a card, compute a score, and record a play message.
-(void)flipCardAtIndex:(NSInteger)index
{
    Card *card=[self cardAtIndex:index];
    NSLog(@"card is %@",card.contents);
    
    if(!card.isUnplayable) {
        if(!card.isFaceUp) {
            
            // Collect the cards to match
            NSMutableArray *flippedCards = nil;
            NSMutableString *cardsString = nil;
            
            for(Card *otherCard in self.cards){
                                 
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    
                    // Include the card we're flipping in the collection of cards to match
                    if(!flippedCards){
                        flippedCards= [[NSMutableArray alloc]init];
                        [flippedCards addObject:card];
                        cardsString = [NSMutableString stringWithFormat: @"%@", card.contents];
                    }
                    
                    [flippedCards addObject:otherCard];
                    [cardsString appendFormat:@" %@", otherCard.contents];
                    NSLog(@"flipcount is: %d",flippedCards.count);
                    
                    // Stop collecting when we have the necessary number of cards to match
                    if(flippedCards.count==self.gameMode){
                        break;
                    }
                }
            }
            
            // Check whether we have all the necessary cards
            NSString *message = nil;
            if (flippedCards.count == self.gameMode) {
                int matchScore = [card match:flippedCards];
                if(matchScore){
                    card.unplayable=YES;
                    for(Card *otherCardMatch in flippedCards){
                        otherCardMatch.unplayable=YES;
                    }
                    self.score+=matchScore*MATCH_BONUS;
                    message = [NSString stringWithFormat:@"Match found in %@ (+%d pts)", cardsString, matchScore*MATCH_BONUS];

                }else{
                    for(Card *otherCardMatch in flippedCards) {
                        otherCardMatch.faceUp=NO;
                        self.score-=MISMATCH_PENALTY;
                        message = [NSString stringWithFormat:@"No match found in %@ (-%d pts)", cardsString, MISMATCH_PENALTY];
                    }
                }
            }
            
            if (!message) {
                message = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            [self addMessage: message];
            self.score-=FLIP_COST;

        }
            card.faceUp=!card.isFaceUp;
   }
}

// Returns a specific game card.
-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

// Returns the number of recorded play messages.
- (NSUInteger)messageCount {
    return self.messages.count;
}
// Returns a specific play message.
- (NSString *)messageAtIndex:(NSUInteger)index {
    return (index < self.messages.count) ? self.messages[index] : @"";
}
// Adds a message to the collection of play messages.
- (void)addMessage:(NSString *)message {
    if (message) {
        if (self.messages.count == MAX_MESSAGES) {
            [self.messages removeLastObject];
        }
        [self.messages insertObject:message atIndex:0];
    }
}
@end
