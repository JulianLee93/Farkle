//
//  GameViewController.m
//  Farkle
//
//  Created by Julian Lee on 1/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "GameViewController.h"
#import "Player.h"
#import "GameController.h"
#import "Dice.h"

@interface GameViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property GameController *game;

@property (weak, nonatomic) IBOutlet UITableView *gameTableView;

@property (weak, nonatomic) IBOutlet UIImageView *d1;
@property (weak, nonatomic) IBOutlet UIImageView *d2;
@property (weak, nonatomic) IBOutlet UIImageView *d3;
@property (weak, nonatomic) IBOutlet UIImageView *d4;
@property (weak, nonatomic) IBOutlet UIImageView *d5;
@property (weak, nonatomic) IBOutlet UIImageView *d6;

@property (nonatomic, weak) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIButton *bankButton;

@property NSMutableArray *diceButtonsArray;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.game = [[GameController alloc] initWithPlayersArray:self.playersArray];
    self.diceButtonsArray = [NSMutableArray arrayWithObjects:self.d1, self.d2, self.d3, self.d4, self.d5, self.d6, nil];
    for (UIImageView *imageView in self.diceButtonsArray) {
        imageView.userInteractionEnabled = YES;
    }
    self.bankButton.enabled = NO;
    
}




- (IBAction)onRollButtonTapped:(UIButton *)sender {
    //handle roll if all are used
    BOOL allHidden = YES;
    for (UIImageView *image in self.diceButtonsArray) {
        if (image.hidden == NO) {
            allHidden = NO;
        }
    }
    if (allHidden) {
        for (UIImageView *image in self.diceButtonsArray) {
            image.hidden = NO;
        }
    }
    
    for (Dice *dice in self.game.allDice) {
        dice.selected = NO;
    }
    
    
    for (int i = 0; i<self.game.allDice.count; i++) {
        Dice *currentDice = [self.game.allDice objectAtIndex:i];
        [currentDice rollSelf];
       
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"%@", currentDice.currentRoll];
        [imageName appendString:@"_dice"];

        UIImageView *currentImage = self.diceButtonsArray[i];
        
        currentImage.image = [UIImage imageNamed:imageName];
    }
    
}

- (IBAction)onImageViewTapped:(UITapGestureRecognizer *)sender {
    
//    NSLog(@"%d", sender.view.tag);
    BOOL validGame = [self.game selectDice:(NSUInteger)sender.view.tag];
    NSLog(@"%i", self.game.selectedPointTotal);
    NSLog(@" dice selected : %@", self.game.diceSelected);
    NSLog(@" dice container : %@", self.game.diceContainer);
    NSLog(@" dice to be rolled : %@", self.game.diceToBeRolled);
    NSLog(@" dice accepted : %@", self.game.diceAccepted);
    
    if (validGame) {
        self.bankButton.enabled = YES;
    }else {
        self.bankButton.enabled = NO;
    }
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%i", self.game.turnPointTotal + self.game.selectedPointTotal];
    
}

- (IBAction)onBankButtonPressed:(UIButton *)sender {
    [self.game acceptSelected];
    for  (int i =0; i<self.game.allDice.count; i++) {
        if ([[self.game.allDice objectAtIndex:i] selected] == YES && [self.game.diceAccepted containsObject:[self.game.allDice objectAtIndex:i]]) {
            UIImageView *currentImage = [self.diceButtonsArray objectAtIndex:i];
            currentImage.hidden = YES;
        }
    }
    int points = [self.game updatePoints];
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%i", points];
}

- (IBAction)onDoneButtonPressed:(UIButton *)sender {
    
    [self.game playerTurnDone];
    [self.tableView reloadData];
    for (UIImageView *image in self.diceButtonsArray) {
        image.hidden = NO;
    }
    for (Dice *dice in self.game.allDice) {
        dice.selected = NO;
    }
    self.pointsLabel.text = @"0";
    
    self.game.diceToBeRolled = [NSMutableArray new];
    for (Dice *dice in self.game.allDice) {
        [self.game.diceToBeRolled addObject:dice];
    }
    
    self.game.diceAccepted = [NSMutableArray new];
    self.game.diceContainer = [NSMutableArray new];
    self.game.diceSelected = [NSMutableArray new];
    
}

#pragma mark - table view delegate methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *playerCell = [tableView dequeueReusableCellWithIdentifier:@"GamePlayerCell"];
    playerCell.textLabel.text = [[self.playersArray objectAtIndex:indexPath.row] name];
    playerCell.detailTextLabel.text = [NSString stringWithFormat:@"%i", [[self.playersArray objectAtIndex:indexPath.row] points] ];
    return playerCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playersArray.count;
}



@end
