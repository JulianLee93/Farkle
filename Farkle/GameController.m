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
        self.allDice = [NSMutableArray arrayWithObjects:self.dice1, self.dice2, self.dice3, self.dice4, self.dice5, self.dice6, nil];
        
        self.diceContainer = [NSMutableArray new];
        self.diceSelected = [NSMutableArray new];
        self.diceAccepted = [NSMutableArray new];
        
        for (int i = 0; i<playerCount; i++) {
            Player *currentPlayer = [Player new];
            [self.playersArray addObject:currentPlayer];
        }
    }
    
    return self;
}

-(BOOL) selectDice:(NSInteger *)diceIndex{
    
    Dice *selectedDice = [self.allDice objectAtIndex:((int)diceIndex-1)];
    
    if (selectedDice.selected) {
        [self.diceSelected removeObject:selectedDice];
        [self.diceToBeRolled addObject:selectedDice];
        
    }else {
        [self.diceToBeRolled removeObject:selectedDice];
        [self.diceSelected addObject:selectedDice];
    }
    
    return [self checkSelectedDice];
    
}

-(BOOL) checkSelectedDice{
    
    NSMutableDictionary *countOfOccurencesDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@0, @1, @0, @2, @0, @3, @0, @4, @0, @5, @0, @6, nil];
    for (Dice *selectedDice in self.diceSelected) {
        NSNumber *currentOccurenceCount =[countOfOccurencesDictionary objectForKey:selectedDice.currentRoll];
        [countOfOccurencesDictionary setObject:[NSNumber numberWithInt:([currentOccurenceCount intValue] + 1)] forKey:selectedDice.currentRoll];
    }
   
    return [self checkForValidGame:countOfOccurencesDictionary];
}

-(BOOL) checkForValidGame:(NSDictionary *)countOfOccurences{

    //check for 6 of a kind
    if ([[countOfOccurences allValues] containsObject:@6]) {
        self.selectedPointTotal += 3000;
        return YES;
    //check for 5 of a kind
    }else if ([[countOfOccurences allValues] containsObject:@5]){
        self.selectedPointTotal += 2000;
        [self shiftOccurencesOfNumber:@5 :countOfOccurences];
    //check for straight
    }else if ([[countOfOccurences allKeysForObject:@1] count] == 6){
        self.selectedPointTotal += 1500;
        return YES;
    //check for 3 pairs
    }else if ([[countOfOccurences allKeysForObject:@2] count] == 3){
        self.selectedPointTotal += 1500;
        return YES;
    //check for 2 triplets
    }else if ([[countOfOccurences allKeysForObject:@3] count] == 2){
        self.selectedPointTotal += 1500;
        return YES;
    //check for 4 of a kind and pair
    }else if ([[countOfOccurences allKeysForObject:@4] count] == 1 && [[countOfOccurences allKeysForObject:@2] count] == 1){
        self.selectedPointTotal += 1500;
        return YES;
    //check for 4 of a kind
    }else if ([[countOfOccurences allKeysForObject:@4] count] == 1){
        self.selectedPointTotal += 1000;
        [self shiftOccurencesOfNumber:@4 :countOfOccurences];
    //check for 3 of a kind
    }else if ([[countOfOccurences allKeysForObject:@3] count] == 1){
        NSArray *roll = [countOfOccurences allKeysForObject:@3];
        if ([roll[0] intValue] == 1) {
            self.selectedPointTotal += 300;
        }else {
            self.selectedPointTotal += [roll[0] intValue] * 100;
        }
        [self shiftOccurencesOfNumber:@3 :countOfOccurences ];
    //check for pair of 5
    }else if ([[countOfOccurences objectForKey:@5] intValue] == 2){
        self.selectedPointTotal += 100;
        for (Dice *dice in self.diceSelected) {
            if ([dice.currentRoll intValue] == 5) {
                dice.currentRoll = @1;
                [self.diceContainer addObject:dice];
                [self.diceSelected removeObject:dice];
                break;
            }
        }
        [self checkSelectedDice];
    //check for occurence of number 1
    }else if ([[countOfOccurences objectForKey:@1] intValue] == 1){
        self.selectedPointTotal += 100;
        [self shiftSingleOccurence:1];
    //check for occurence of number 5
    }else if ([[countOfOccurences objectForKey:@5] intValue] == 1){
        self.selectedPointTotal += 50;
        [self shiftSingleOccurence:5];
    //check if selected array is empty to stop recursion
    }if (self.diceSelected.count == 0){
        return YES;
    }else {
         return NO;
    }
    return YES;
}

-(void) shiftSingleOccurence:(int)number {
    for (Dice *dice in self.diceSelected) {
        if ([dice.currentRoll intValue] == number) {
            [self.diceSelected removeObject:dice];
            [self.diceContainer addObject:dice];
            [self checkSelectedDice];
        }
    }
}

-(void) shiftOccurencesOfNumber:(NSNumber *)number :(NSDictionary *)countOfOccurences{
    NSArray *keys = [countOfOccurences allKeysForObject:number];
    for (Dice *dice in self.diceSelected) {
        if (dice.currentRoll == keys[0]) {
            [self.diceContainer addObject:dice];
            [self.diceSelected removeObject:dice];
            [self checkSelectedDice];
        }
    }
}



@end
