//
//  magicViewController.m
//  27-magic
//
//  Created by gisxing on 14-1-9.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "magicViewController.h"
#import "cardButton.h"
#import "magicCore.h"
#import "resultViewController.h"

@interface magicViewController ()

@property (strong, nonatomic) NSArray *cardButtons;

@property (strong, nonatomic) NSTimer *flipTimer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *magicButton;

@end

@implementation magicViewController

-(NSArray *)cardButtons {
    if (!_cardButtons) {
        
        cardButton *myButton_1 = [[cardButton alloc]initWithFrame:CGRectMake(20, 120, 70, 100)];
        myButton_1.tag = 0;
        [myButton_1 addTarget:self action:@selector(cardbuttonPush:) forControlEvents:UIControlEventTouchUpInside];
        
        cardButton *myButton_2 = [[cardButton alloc]initWithFrame:CGRectMake(100, 120, 70, 100)];
        myButton_2.tag = 1;
        [myButton_2 addTarget:self action:@selector(cardbuttonPush:) forControlEvents:UIControlEventTouchUpInside];
        
        cardButton *myButton_3 = [[cardButton alloc]initWithFrame:CGRectMake(180, 120, 70, 100)];
        myButton_3.tag = 2;
        [myButton_3 addTarget:self action:@selector(cardbuttonPush:) forControlEvents:UIControlEventTouchUpInside];
        _cardButtons = [NSArray arrayWithObjects:
                        myButton_1,
                        myButton_2 ,
                        myButton_3 ,
                        nil];
    }
    return _cardButtons;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for (cardButton* card in self.cardButtons) {
        [self.view addSubview:card];    //建立好三个牌
        //NSLog(@"%@", card);

    }


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

#pragma display the cards (with delay effect)

-(IBAction)divideIntoThree:(id)sender {
    NSLog(@"click");
    if ([self.magic divideThreeColumns]) {
        // 安装timer（注册timer）
        self.flipTimer = [NSTimer scheduledTimerWithTimeInterval: 1// 当函数正在调用时，及时间隔时间到了 也会忽略此次调用
                                                          target: self
                                                        selector: @selector(handleTimer:)
                                                        userInfo: nil
                                                         repeats: YES];
    }
    for (Card * card in self.magic.columns[0]) {
        NSLog(@"column 1 : %@", card.contents);
    }

}

- (void) handleTimer: (NSTimer *) timer
{
    static int index_of_column = 0;
    if ([self.magic.columns[0] count] == index_of_column) {
        [self.flipTimer invalidate];
        index_of_column = 0;
        return;
    }
    for (int i = 0; i<[self.cardButtons count]; i++) {
        Card *card = self.magic.columns[i][index_of_column] ;
        cardButton *cardbutton = self.cardButtons[i];
        cardbutton.contents = card.contents;
        cardbutton.labelTop.text = card.contents;
        cardbutton.labelBottom.text = card.contents;
        [cardbutton setTitle:card.contents forState:UIControlStateNormal];
    }
    index_of_column++;
    NSLog(@"static :%d", index_of_column);
}

-(void)cardbuttonPush:(id)sender {
    cardButton *pressedButton = (cardButton *) sender;
    NSInteger index = pressedButton.tag;
    [self.magic pickOneColumn:index];
    NSLog(@"column %d : count %d", index, [self.magic.columns[index] count]);
    
    for (Card * card in self.magic.cardsTricky) {
        NSLog(@"cards tricky : %@", card.contents);
    }
    
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue prepare");
    
    if (sender != self.magicButton) return;
    resultViewController *DE = (resultViewController *) segue.destinationViewController;    //使用 push方式时候用这样的方法获取
    DE.magic = self.magic;  //继续传递 magic
    
}

@end
