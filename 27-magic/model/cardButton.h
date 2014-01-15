//
//  cardButton.h
//  27-magic
//
//  Created by gisxing on 14-1-9.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cardButton : UIButton
@property  (nonatomic, assign) CGFloat hue;
@property  (nonatomic, assign) CGFloat saturation;
@property  (nonatomic, assign) CGFloat brightness;

@property  (nonatomic, strong) NSString *contents;

@property (strong, nonatomic) UILabel *labelTop;
@property (strong, nonatomic) UILabel *labelBottom;

@end
