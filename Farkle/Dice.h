//
//  Dice.h
//  Farkle
//
//  Created by Rafael Auriemo on 1/22/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject

@property NSNumber *currentRoll;

-(void) rollSelf;

@end
