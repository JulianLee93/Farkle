//
//  GameController.h
//  Farkle
//
//  Created by Rafael Auriemo on 1/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"
#import "Player.h"

@interface GameController : NSObject

@property Dice *dice1;
@property Dice *dice2;
@property Dice *dice3;
@property Dice *dice4;
@property Dice *dice5;
@property Dice *dice6;

@property NSMutableArray *diceToBeRolled;
@property NSMutableArray *diceContainer;
@property NSMutableArray *diceSelected;
@property NSMutableArray *diceAccepted;
@property NSMutableArray *allDice;

@property NSNumber *numberOfPlayers;
@property Player *currentPlayer;

@property NSMutableArray *playersArray;

@property int selectedPointTotal;
@property int turnPointTotal;

-(instancetype)initWithPlayersArray:(NSMutableArray *)playersArray;
-(BOOL) selectDice:(NSUInteger)diceIndex;
-(void) acceptSelected;
-(int) updatePoints;
-(void) playerTurnDone;
-(BOOL) checkSelectedDice;
-(BOOL) checkForFarkle:(NSMutableArray *)visibleDice;

@end
