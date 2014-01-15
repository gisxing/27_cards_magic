//
//  magicCore.m
//  27-magic
//
//  Created by gisxing on 14-1-13.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "magicCore.h"
#import "Deck.h"
#import "Card.h"

@implementation magicCore


-(NSArray *)cards {
	if (!_cards) _cards = [[NSMutableArray alloc] init];
	return _cards;
}

-(NSArray *)cardsTricky {
	if (!_cardsTricky) _cardsTricky = [[NSMutableArray alloc] init];
	return _cardsTricky;
}


-(NSArray *)columns {
	if (!_columns) {
		NSMutableArray *aColumn = [[NSMutableArray alloc] init];
		NSMutableArray *bColumn = [[NSMutableArray alloc] init];
		NSMutableArray *cColumn = [[NSMutableArray alloc] init];
		_columns = @[aColumn, bColumn, cColumn];
    }
	return _columns;
}



-(BOOL)divideThreeColumns {
    if (![self.cardsTricky count]) {
        NSLog(@"the cards tricky already empty");
        return NO;
    }
    if ([self.cardsTricky count] != [self.cards count]) {
        NSLog(@"cards tricky is not yet full!");
        return NO;
    }
    self.columns = nil; // delete all columns first
    for (int i =0 ; i<[self.cardsTricky count];)  {
        for (NSMutableArray *column in self.columns) {
            // divide the cards in the order A , B , C
            if (i<[self.cardsTricky count]) {
                [column addObject:self.cardsTricky[i]];
                i++;
            }
        }
    }
    
    [self.cardsTricky removeAllObjects];
	NSLog(@"the cardsTricky should be empty:%d", [self.cardsTricky count]);
    return YES;
    
}

-(void)pickOneColumn:(NSInteger)index {
	if ([self.cardsTricky count] == [self.cards count])	{	// cardsTricky is already FULL
        NSLog(@"the cards tricky already full");
		return ;
    }

    if ([self.cardsTricky indexOfObject:self.columns[index][0]] == NSNotFound) {
		//this column is not pick yet; **
        NSLog(@"column add in cardsTricky");
        [self.cardsTricky addObjectsFromArray:self.columns[index]];
		return;
	}
    else {
        NSLog(@"column already pick");
        return;
    }

}


-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
        self.cardsTricky = [[NSMutableArray alloc] initWithArray: self.cards];

    }
    return self;
}


@end
