//
//  GameController.h
//  Farkle
//
//  Created by Rafael Auriemo on 1/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

@interface GameController : NSObject

@property Dice *dice1;
@property Dice *dice2;
@property Dice *dice3;
@property Dice *dice4;
@property Dice *dice5;
@property Dice *dice6;

@property NSMutableArray *diceToBeRolled;
@property NSMutableArray *diceSelected;
@property NSMutableArray *diceAccepted;

@property NSNumber *numberOfPlayers;
@property NSNumber *currentPlayer;

@property NSMutableArray *playersArray;

-(instancetype)initWithPlayerCount:(NSUInteger) playerCount;

@end
