//
//  PlayerViewController.m
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "PlayerViewController.h"
#import "Player.h"
#import "PlayerTableViewCell.h"
#import "AddPlayerTableViewCell.h"
#import "GameViewController.h"

@interface PlayerViewController () <UITableViewDelegate, UITableViewDataSource, AddPlayerTableViewCellDelegate, UITextFieldDelegate, PlayerTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *playersArray;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameScoreLimitValue;


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

    if (indexPath.row >= self.playersArray.count)
    {
        AddPlayerTableViewCell *addPlayerCell = [tableView dequeueReusableCellWithIdentifier:@"AddPlayer"];
        addPlayerCell.AddPlayerTextField.text = @"";
        addPlayerCell.delegate = self;
        return addPlayerCell;
    }
    else
    {
        PlayerTableViewCell *currentPlayerCell = [tableView dequeueReusableCellWithIdentifier:@"CurrentPlayer"];
        Player *currentPlayer = [self.playersArray objectAtIndex:indexPath.row];
        currentPlayerCell.playerNameTextField.text = currentPlayer.name;
        currentPlayerCell.delegate = self;
        return currentPlayerCell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.playersArray.count + 1;
}

- (IBAction)onGoButtonTapped:(UIButton *)sender {
    
}

#pragma mark - PlayerTableViewCell
- (void)onAddPlayerButtonTapped:(UIButton *)sender playerName:(NSString *)name
{
    if (self.playersArray.count < 6) {
        Player *newPlayer = [[Player alloc] initWithName:name];
        [self.playersArray addObject:newPlayer];
        [self.tableView reloadData];
    }else {
        [self.tableView reloadData];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Exceeded max number of players" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (void)PlayerTableViewCellDelegate:(id)cell updatedName:(NSString *)name
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Player *currentPlayer = [self.playersArray objectAtIndex:indexPath.row];
    currentPlayer.name = name;

}





#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameViewController *destination = segue.destinationViewController;
    destination.playersArray = self.playersArray;
    NSString *segmentTitle = [self.gameScoreLimitValue titleForSegmentAtIndex:self.gameScoreLimitValue.selectedSegmentIndex];
    destination.gameScoreLimit = [segmentTitle intValue];
    destination.pvc = self;
}


























@end
