//
//  magicCore.h
//  27-magic
//
//  Created by gisxing on 14-1-13.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface magicCore : NSObject

@property(nonatomic , strong) NSMutableArray *cards; //of Card (27)
@property(nonatomic , strong) NSMutableArray *cardsTricky;

@property(nonatomic , strong) NSArray *columns; // this magic trick rely 3 columns （of decks）

-(void)pickOneColumn:(NSInteger)index;

-(BOOL)divideThreeColumns;

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
@end
