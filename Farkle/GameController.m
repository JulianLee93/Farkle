//
//  GameController.m
//  Farkle
//
//  Created by Rafael Auriemo on 1/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "GameController.h"
#import "Player.h"


@implementation GameController

-(instancetype)initWithPlayerCount:(NSUInteger) playerCount {
    
    self = [super init];
    
    if (self) {
        self.dice1 = [Dice new];
        self.dice2 = [Dice new];
        self.dice3 = [Dice new];
        self.dice4 = [Dice new];
        self.dice5 = [Dice new];
        self.dice6 = [Dice new];
        
        self.diceToBeRolled = [NSMutableArray arrayWithObjects:self.dice1, self.dice2, self.dice3, self.dice4, self.dice5, self.dice6, nil];
        
        self.diceSelected = [NSMutableArray new];
        self.diceAccepted = [NSMutableArray new];
        
        for (int i = 0; i<playerCount; i++) {
            Player *currentPlayer = [Player new];
            [self.playersArray addObject:currentPlayer];
        }
    }
    
    return self;
}

-(void) selectDice:(NSInteger *)diceIndex {
    Dice *selectedDice = [self.diceToBeRolled objectAtIndex:((int)diceIndex-1)];
    [self.diceToBeRolled removeObject:selectedDice];
    [self.diceSelected addObject:selectedDice];
    
}

@end
