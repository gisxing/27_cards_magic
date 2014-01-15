//
//  Card.h
//  matchismo_II
//
//  Created by gisxing on 14-1-8.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter =  isMatched) BOOL matched;


- (int)match:(NSArray *)cards;

@end
