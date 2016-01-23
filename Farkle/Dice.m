//
//  Dice.m
//  Farkle
//
//  Created by Rafael Auriemo on 1/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "Dice.h"

@implementation Dice

-(void) rollSelf{
    int roll = arc4random_uniform(6);
    self.currentRoll = [NSNumber numberWithInt:(roll + 1)];
}

@end
