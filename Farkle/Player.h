//
//  Player.h
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property int points;
@property NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
