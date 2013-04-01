//
//  Deck.h
//  Matchisimo2
//
//  Created by Brandon White on 3/10/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card
         atTop:(BOOL) atTop;

-(Card *)drawRandomCard;

@end
