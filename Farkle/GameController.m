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

-(instancetype)initWithPlayersArray:(NSMutableArray *)playersArray {
    
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
        self.playersArray = [NSMutableArray new];
        
        self.playersArray = playersArray;
        
        self.currentPlayer = self.playersArray[0];
    }
    
    return self;
}

-(BOOL) selectDice:(NSUInteger)diceIndex{
    self.selectedPointTotal = 0;
    
    Dice *selectedDice = [self.allDice objectAtIndex:(diceIndex -1)];
    
    if (selectedDice.selected) {
        [self.diceSelected removeObject:selectedDice];
        [self.diceToBeRolled addObject:selectedDice];
        selectedDice.selected = NO;
        
    }else {
        [self.diceToBeRolled removeObject:selectedDice];
        [self.diceSelected addObject:selectedDice];
        selectedDice.selected = YES;
    }
    
    BOOL validGame = [self checkSelectedDice];
    
    for (Dice *dice in self.diceContainer) {
        [self.diceSelected addObject:dice];
    }
    self.diceContainer = [NSMutableArray new];
    
    return validGame;
    
}

-(BOOL) checkSelectedDice{
    
    NSMutableDictionary *countOfOccurencesDictionary = [NSMutableDictionary new];
    countOfOccurencesDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@0, @1, @0, @2, @0, @3, @0, @4, @0, @5, @0, @6, nil];
    for (Dice *selectedDice in self.diceSelected) {
        NSNumber *currentOccurenceCount =[countOfOccurencesDictionary objectForKey:selectedDice.currentRoll];
        [countOfOccurencesDictionary setObject:[NSNumber numberWithInt:([currentOccurenceCount intValue] + 1)] forKey:selectedDice.currentRoll];
    }
    
//    NSLog(@"count of occurences : %@", countOfOccurencesDictionary);
    BOOL validGame = [self checkForValidGame:countOfOccurencesDictionary];
    
    return validGame;
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
    //check for occurence of number 1
    }else if ([[countOfOccurences objectForKey:@1] intValue] == 1 || [[countOfOccurences objectForKey:@1] intValue] == 2){
        self.selectedPointTotal += 100;
        [self shiftSingleOccurence:1];
    //check for occurence of number 5
    }else if ([[countOfOccurences objectForKey:@5] intValue] > 0){
        self.selectedPointTotal +=50;
        [self shiftSingleOccurence:5];
    //check if selected array is empty to stop recursion
    }if (self.diceSelected.count == 0 && self.diceContainer.count != 0){
        return YES;
    }
    return NO;
}

-(BOOL) checkForFarkle:(NSMutableArray *)visibleDice{
    
    for (Dice *dice in visibleDice) {
        [self.diceSelected addObject: dice];
    }
    
    NSMutableDictionary *countOfOccurences = [NSMutableDictionary new];
    countOfOccurences = [NSMutableDictionary dictionaryWithObjectsAndKeys:@0, @1, @0, @2, @0, @3, @0, @4, @0, @5, @0, @6, nil];
    for (Dice *selectedDice in self.diceSelected) {
        NSNumber *currentOccurenceCount =[countOfOccurences objectForKey:selectedDice.currentRoll];
        [countOfOccurences setObject:[NSNumber numberWithInt:([currentOccurenceCount intValue] + 1)] forKey:selectedDice.currentRoll];
    }

    
    //check for 6 of a kind
    if ([[countOfOccurences allValues] containsObject:@6]) {
        return YES;
        //check for 5 of a kind
    }else if ([[countOfOccurences allValues] containsObject:@5]){
        return YES;
        //check for straight
    }else if ([[countOfOccurences allKeysForObject:@1] count] == 6){
        return YES;
        //check for 3 pairs
    }else if ([[countOfOccurences allKeysForObject:@2] count] == 3){
        return YES;
        //check for 2 triplets
    }else if ([[countOfOccurences allKeysForObject:@3] count] == 2){
        return YES;
        //check for 4 of a kind and pair
    }else if ([[countOfOccurences allKeysForObject:@4] count] == 1 && [[countOfOccurences allKeysForObject:@2] count] == 1){
        return YES;
        //check for 4 of a kind
    }else if ([[countOfOccurences allKeysForObject:@4] count] == 1){
        return YES;
        //check for 3 of a kind
    }else if ([[countOfOccurences allKeysForObject:@3] count] == 1){
        return YES;
        //check for occurence of number 1
    }else if ([[countOfOccurences objectForKey:@1] intValue] > 0){
        return YES;
        //check for occurence of number 5
    }else if ([[countOfOccurences objectForKey:@5] intValue] > 0){
        return YES;
        //check if selected array is empty to stop recursion
    }if (self.diceSelected.count == 0 && self.diceContainer.count != 0){
        return YES;
    }
    return NO;
}

-(void) shiftSingleOccurence:(int)number {
    NSMutableArray *diceToRemove = [NSMutableArray new];
    for (Dice *dice in self.diceSelected) {
        if ([dice.currentRoll intValue] == number) {
            [diceToRemove addObject:dice];
            [self.diceContainer addObject:dice];
                break;
        }
    }
    for (Dice *dice in diceToRemove) {
        [self.diceSelected removeObject:dice];
    }
    [self checkSelectedDice];
}

-(void) shiftOccurencesOfNumber:(NSNumber *)number :(NSDictionary *)countOfOccurences{
    NSMutableArray *diceToRemove = [NSMutableArray new];
    NSArray *keys = [countOfOccurences allKeysForObject:number];
    for (Dice *dice in self.diceSelected) {
        if (dice.currentRoll == keys[0]) {
            [self.diceContainer addObject:dice];
            [diceToRemove addObject:dice];
        }
    }
    for (Dice *dice in diceToRemove) {
        [self.diceSelected removeObject:dice];
    }
    [self checkSelectedDice];
}

-(void) acceptSelected {
    //leaves die on table if pair of 5s
    int fiveCount = 0;
    for (Dice *dice in self.diceSelected) {
        if ([dice.currentRoll intValue] == 5) {
            fiveCount += 1;
        }
    }
    if (fiveCount == 2) {
        NSMutableArray *toBeRemoved = [NSMutableArray new];
        for (Dice *dice in self.diceSelected) {
            if ([dice.currentRoll intValue] == 5) {
                [self.diceToBeRolled addObject:dice];
                [toBeRemoved addObject:dice];
                break;
            }
        }
        for (Dice *dice in toBeRemoved) {
            [self.diceSelected removeObject:dice];
        }
    }
    
    //accept selected
    for (Dice *dice in self.diceSelected) {
        [self.diceAccepted addObject:dice];
    }
    self.diceSelected = [NSMutableArray new];
}

-(int) updatePoints {
    self.turnPointTotal += self.selectedPointTotal;
    self.selectedPointTotal = 0;
    return  self.turnPointTotal;
}

-(void) playerTurnDone{
    self.currentPlayer.points += self.turnPointTotal;
    self.turnPointTotal = 0;
    NSUInteger indexOfCurrentPlayer = [self.playersArray indexOfObject:self.currentPlayer];
    if (indexOfCurrentPlayer+1 >=  self.playersArray.count) {
        self.currentPlayer = self.playersArray[0];
    }else{
        self.currentPlayer = [self.playersArray objectAtIndex:indexOfCurrentPlayer+1];
    }
    
}



@end
