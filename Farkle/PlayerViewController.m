//
//  PlayerViewController.m
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "PlayerViewController.h"
#import "Player.h"

@interface PlayerViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *playersArray;

@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    Player *player1 = [[Player alloc] initWithName:@"Player 1"];
    Player *player2 = [[Player alloc] initWithName:@"Player 2"];
    
    self.playersArray = [[NSMutableArray alloc] initWithObjects:player1, player2, nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%li", (long)indexPath.row);

    if (indexPath.row >= self.playersArray.count)
    {
        UITableViewCell *addPlayerCell = [tableView dequeueReusableCellWithIdentifier:@"AddPlayer"];
        addPlayerCell.textLabel.text = [NSString stringWithFormat:@"+"];
        return addPlayerCell;
    }
    else
    {
        UITableViewCell *currentPlayerCell = [tableView dequeueReusableCellWithIdentifier:@"CurrentPlayer"];
        Player *currentPlayer = [self.playersArray objectAtIndex:indexPath.row];
        currentPlayerCell.textLabel.text = currentPlayer.name;
        return currentPlayerCell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
