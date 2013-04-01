//
//  CardGameViewController.m
//  Matchisimo2
//
//  Created by Brandon White on 3/10/13.
//  Copyright (c) 2013 Brandon White. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *matchSizeControl;
@property (nonatomic) int matchSize;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController


-(CardMatchingGame *) game
{
    if (!_game){

        int gameModeSegmentValue = [[self.matchSizeControl titleForSegmentAtIndex:self.matchSizeControl.selectedSegmentIndex] intValue];
        NSLog(@"2nd Sengment Title is  : %d",[[self.matchSizeControl titleForSegmentAtIndex:self.matchSizeControl.selectedSegmentIndex] intValue]);
        if(!gameModeSegmentValue) gameModeSegmentValue = 2;
        
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[[PlayingCardDeck alloc]init]
                                                  gameMode:gameModeSegmentValue];
    }
    return _game;
}


-(IBAction) dealNewDeck : (id) sender {
    self.game = nil;
    self.matchSizeControl.enabled = YES;
    self.flipCount = 0;
    [self updateUI];
}
    

-(void)setCardButtons:(NSArray *)cardButtons {
    
    _cardButtons= cardButtons;
    
    UIImage *blank = [[UIImage alloc] init];
    UIImage *cardBackImage = [UIImage imageNamed:@"DSC_1807.jpg"];
    for (UIButton *cardButton in cardButtons)
    {
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        [cardButton setImage:cardBackImage forState:UIControlStateHighlighted];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        [cardButton setImage:blank forState:UIControlStateSelected];
        
        [cardButton setImage:blank forState:UIControlStateSelected|UIControlStateDisabled];
    }

    [self updateUI];

}


-(void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    //self.lastFlipLabel.text = [self lastFlipResult:self.game];
                               
    //NSLog(@"the segment title is %@",[self.matchSizeControl titleForSegmentAtIndex:self.matchSizeControl.selectedSegmentIndex]);
    [self displayMessage:0];

    
    
}

#define FLIP_COST 1
-(NSString *)lastFlipResult:(CardMatchingGame *)cardMatchingGame
{
    NSString *result=@"";
    NSMutableArray *resultArrayStr = [[NSMutableArray alloc]init];
    
    if(cardMatchingGame.lastScore ==(0-FLIP_COST)){
        
        Card *lastFlippedCard=[cardMatchingGame.lastFlippedCards lastObject];
        if(lastFlippedCard!=nil){
            
            result = [NSString stringWithFormat:@"Flipped up %@",lastFlippedCard.contents];
            return result;
        }
    }
    else
        if(cardMatchingGame.lastScore>0)
        {
            [resultArrayStr addObject:@"Matched "];

            for(Card *card in cardMatchingGame.lastFlippedCards){
                [resultArrayStr addObject:card.contents];
                [resultArrayStr addObject:@" & "];
            }
            [resultArrayStr removeLastObject];
            [resultArrayStr addObject:[NSString stringWithFormat:@" for %d points",cardMatchingGame.lastScore]];
        }else if(cardMatchingGame.lastScore<0)
        {
            for(Card *card in cardMatchingGame.lastFlippedCards){
                [resultArrayStr addObject:card.contents];
                [resultArrayStr addObject:@" & "];
            }
            [resultArrayStr removeLastObject];
            [resultArrayStr addObject:[NSString stringWithFormat:@" don't match! %d points",cardMatchingGame.lastScore]];
        }
    
    return [resultArrayStr componentsJoinedByString:@" "];
}




- (void)displayMessage:(NSUInteger)index {
    self.messageLabel.text = (self.game.messageCount > 0) ? [self.game messageAtIndex:index] : @"Flip a card!";
    self.messageLabel.alpha = (index == 0) ? 1.0f : 0.5f;
}



- (IBAction)changeMatchSize:(UISegmentedControl *)sender {
    NSString *matchSizeString = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    self.matchSize = [matchSizeString intValue];
    //NSLog(@"match String is %@",matchSizeString);
    self.game = nil;
}


-(void)setFlipCount:(int)flipCount {
    _flipCount= flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d",self.flipCount];
}

-(IBAction)flipCard:(UIButton *) sender{
    [self animateFlipCard:sender];
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.matchSizeControl.enabled = NO;
    self.flipCount++;
    [self updateUI];
}

-(void)animateFlipCard:(UIButton *)sender {
        
    [UIView beginAnimations:@"flipCard" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:sender cache:YES];
    [UIView setAnimationDuration:.25];
    [UIView commitAnimations];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [[self.matchSizeControl titleForSegmentAtIndex:self.matchSizeControl.selectedSegmentIndex] intValue];
    NSLog(@"Sengment Title is : %d",[[self.matchSizeControl titleForSegmentAtIndex:self.matchSizeControl.selectedSegmentIndex] intValue]);

}


@end
