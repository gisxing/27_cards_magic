//
//  PlayingCard.m
//  matchismo_II
//
//  Created by gisxing on 14-1-8.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits {
    return @[@"♦️",@"♠️", @"♣️", @"♥️"];
}

+(NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}


- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit: @"?";
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank {
    if(rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}



- (int)match:(NSArray *) cards {
    int score = 0;
    /*
    if ([cards count] == 1) {
        NSLog(@"2 card mode");
        PlayingCard *otherCard = [cards firstObject];
        if ([self.suit isEqualToString: otherCard.suit]) {
                score =  1;
        }
        else if (self.rank == otherCard.rank){
                score = 4;
        }
    }
  
    if ([cards count] == 2) {
      
        BOOL suit_match = YES;
        BOOL rank_match = YES;
        for (PlayingCard *otherCard in cards) {
            if (suit_match && ![self.suit isEqualToString: otherCard.suit]) {
                suit_match = NO;
            }
            if (rank_match && self.rank != otherCard.rank) {
                rank_match = NO;
            }
        }
        if (suit_match) score = 1;
        if (rank_match) score = 4;
    }
    */
    
    BOOL suit_match = YES;
    BOOL rank_match = YES;
    for (PlayingCard *otherCard in cards) {
        if (suit_match && ![self.suit isEqualToString: otherCard.suit]) {
            suit_match = NO;
        }
        if (rank_match && self.rank != otherCard.rank) {
            rank_match = NO;
        }
    }
    if (suit_match) score = 1;
    if (rank_match) score = 4;
    
    
    return score;
}

@end
