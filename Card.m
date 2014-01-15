//
//  Card.m
//  matchismo_II
//
//  Created by gisxing on 14-1-8.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *) cards {
    int score = 0;
    for (Card *card in cards) {
        if ([card.contents isEqualToString:self.contents]) {
            
            score = 1;
        }
    }
    
    return score;
}
@end
