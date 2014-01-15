//
//  Deck.h
//  matchismo_II
//
//  Created by gisxing on 14-1-8.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
