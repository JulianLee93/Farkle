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

@property NSMutableArray *diceButtonsArray;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.game = [[GameController alloc] initWithPlayerCount:self.playersArray.count];
    self.diceButtonsArray = [NSMutableArray arrayWithObjects:self.d1, self.d2, self.d3, self.d4, self.d5, self.d6, nil];
    for (UIImageView *imageView in self.diceButtonsArray) {
        imageView.userInteractionEnabled = YES;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *playerCell = [tableView dequeueReusableCellWithIdentifier:@"GamePlayerCell"];
    playerCell.textLabel.text = [[self.playersArray objectAtIndex:indexPath.row] name];
    return playerCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playersArray.count;
}

- (IBAction)onRollButtonTapped:(UIButton *)sender {
    
    for (int i = 0; i<self.game.diceToBeRolled.count; i++) {
        Dice *currentDice = [self.game.diceToBeRolled objectAtIndex:i];
        [currentDice rollSelf];
       
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"%@", currentDice.currentRoll];
        [imageName appendString:@"_dice"];

        UIImageView *currentImage = self.diceButtonsArray[i];
        
        currentImage.image = [UIImage imageNamed:imageName];
    }
    
}

- (IBAction)onImageViewTapped:(UITapGestureRecognizer *)sender {
    
//    NSLog(@"%d", sender.view.tag);
    [self.game selectDice:(NSInteger *)sender.view.tag];
    
}






@end
