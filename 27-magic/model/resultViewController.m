//
//  resultViewController.m
//  27-magic
//
//  Created by gisxing on 14-1-15.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "resultViewController.h"
#import "cardButton.h"
#import "Card.h"

@interface resultViewController ()
@property (weak, nonatomic) IBOutlet cardButton *cardbutton;
@property (weak, nonatomic) IBOutlet UILabel *flipCount;

@end

@implementation resultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cardButtonClick:(id)sender {
    static int i = 0;
    
    if ([self.magic.cardsTricky count] == 0)
        return;
    
    if ([self.magic.cardsTricky count] < i)
        return;
    
    

    Card *card = self.magic.cardsTricky[i];
    
    [self.cardbutton setTitle:card.contents forState:UIControlStateNormal];
    self.cardbutton.labelTop.text = card.contents;
    self.cardbutton.labelBottom.text = card.contents;
    self.flipCount.text = [NSString stringWithFormat:@"flips: %d", i+1];

    i++;
    if (i>= [self.magic.cardsTricky count]) {
        i = 0;
    }
   
}

@end
