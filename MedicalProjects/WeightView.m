//
//  WeightView.m
//  MedicalProjects
//
//  Created by Marco Velluto on 18/05/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "WeightView.h"
#import "FirstViewController.h"

@interface WeightView ()

- (void)setTitleLabel;
- (void)setDataLabel;
- (void)setTextFiled;
- (void)setButton;

@end

@implementation WeightView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *)setView {
    
    [self setTitleLabel];
    [self setDataLabel];
    [self setTextFiled];
    [self setButton];
        return self;
}


- (void)setTitleLabel {
    //-- INSERISCI IL TUO PESO
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 21)];
    [titleLabel setText:@"Inserisci il tuo peso :)"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:titleLabel];
}

- (void)setDataLabel {
    //-- DATA
    UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 80, 110, 21)];
    [dataLabel setText:@"15/12/12"];
    [dataLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:dataLabel];
}

- (void)setTextFiled {
    //-- TEXT FIELD
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 111, 280, 30)];
    [myTextField setTextAlignment:NSTextAlignmentCenter];
    [myTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [myTextField setPlaceholder:@"Pippox"];
    [myTextField setTag:123];
    [self addSubview:myTextField];
}

- (void)setButton {
    //-- BOTTOM
    UIButton *bottom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bottom setFrame:CGRectMake(124, 195, 73, 44)];
    [bottom setTitle:@"Save" forState:UIControlStateNormal];
    [bottom addTarget:self action:@selector(pressButtonSave:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottom];
}


+ (UILabel *)titleLabel {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 21)];
    [titleLabel setText:@"Inserisci il tuo peso :)"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    return titleLabel;
}

+ (UILabel *)dataLabel {
    UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 80, 110, 21)];
    [dataLabel setText:@"15/12/12"];
    [dataLabel setTextAlignment:NSTextAlignmentRight];
    return dataLabel;
}

+ (UITextField *)myTextField {
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 111, 280, 30)];
    [myTextField setTextAlignment:NSTextAlignmentCenter];
    [myTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [myTextField setPlaceholder:@"Pippox"];
    return myTextField;
}

+ (UIButton *)button {
    //-- BOTTOM
    UIButton *bottom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bottom setFrame:CGRectMake(124, 195, 73, 44)];
    [bottom setTitle:@"Save" forState:UIControlStateNormal];
    return bottom;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
