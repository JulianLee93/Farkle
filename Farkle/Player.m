//
//  Player.m
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "Player.h"

@implementation Player


- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    self.name = name;
    self.points = 0;
    
    return self;
}

@end
