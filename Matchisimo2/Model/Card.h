//
//  Card.h
//  Matchisimo2
//
//  Created by Brandon White on 3/10/13.]'
@interface Card : NSObject

@property(strong, nonatomic) NSString* contents;
@property(nonatomic, getter=isFaceUp) BOOL faceUp;
@property(nonatomic,getter = isUnplayable) BOOL unplayable;

-(int)match:(NSArray *) otherCards;

@end
