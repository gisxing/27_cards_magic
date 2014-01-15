//
//  homeViewController.m
//  27-magic
//
//  Created by gisxing on 14-1-13.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "homeViewController.h"
#import "cardButton.h"
#import "magicCore.h"
#import "PlayingCardDeck.h"

#import "magicViewController.h"

@interface homeViewController ()
@property (strong, nonatomic) IBOutletCollection(cardButton) NSArray *cardButtons;
@property (strong, nonatomic) magicCore *magic;

@end

@implementation homeViewController

-(magicCore *)magic {
    if (!_magic) _magic = [[magicCore alloc] initWithCardCount:27 usingDeck:[self createDeck]];
    return _magic;
}

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}
    


- (IBAction)touchBackground:(id)sender {
    self.magic = nil;
    [self updateUI];

}

- (void) updateUI {
    
    for (cardButton *button in self.cardButtons) {
        int index = [self.cardButtons indexOfObject:button];
        Card *card = [self.magic.cards objectAtIndex:index];
        button.contents = card.contents;
        //[button setTitle:card.contents forState:UIControlStateNormal];
        button.labelTop.text = card.contents;
        button.labelBottom.text = card.contents;
    }
  
    
}

-(void)viewDidAppear:(BOOL)animated {
    //[self performSegueWithIdentifier:@"sendMagicCoreData" sender:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
            NSLog(@"view did load !!");
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;     //隐藏状态栏 (电源那条东西)
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"in segue prepare");
    
    if ([[segue identifier] isEqualToString:@"sendMagicCoreData"]) {
        NSLog(@"send magic core daaa");        
        //magicViewController *DE = (magicViewController *) segue.destinationViewController;    //使用 push方式时候用这样的方法获取
        //DE.magic = self.magic;
        //NSLog(@"prepare segue %@", DE.magic);

        UINavigationController *DE = (UINavigationController *) segue.destinationViewController;  //使用modal时候的方法
        magicViewController *mvc =  (id)[DE topViewController];
        mvc.magic = self.magic;
        NSLog(@"prepare segue %@", mvc.magic);
        
        //设置 modal 进来的 UINavigationController 的 bar 属性  由于是modal进来的，注意上面获取 topViewController的方法 （和push 方式）不同
       [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
        
        
    }
}

-(IBAction)backFromMagicViewControler:(UIStoryboardSegue *)segue {
    magicViewController *source = [segue sourceViewController];
    NSLog(@"magic view controler's magic: %@", source.magic);
    
    
}

@end
