//
//  PlayingCard.h
//  matchismo_II
//
//  Created by gisxing on 14-1-8.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong , nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
//+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank ;
@end
