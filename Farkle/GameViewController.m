//
//  GameViewController.m
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "GameViewController.h"
#import "Player.h"

@interface GameViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *gameTableView;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *playerCell = [tableView dequeueReusableCellWithIdentifier:@"GamePlayerCell"];
    playerCell.textLabel.text = [[self.playersArray objectAtIndex:indexPath.row] name];
    return playerCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playersArray.count;
}




@end
