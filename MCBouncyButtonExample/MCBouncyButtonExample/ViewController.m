//
//  ViewController.m
//  MCBouncyButtonExample
//
//  Created by Matt Condon on 12/20/14.
//  Copyright (c) 2014 Shrugs. All rights reserved.
//

#import "ViewController.h"
#import <MCBouncyButton/MCBouncyButton.h>

@interface ViewController ()
{
    MCBouncyButton *textButton;
    MCBouncyButton *imgButton;

    MCBouncyButton *toggleTextButton;
    MCBouncyButton *toggleImgButton;

    BOOL textButtonState;
    BOOL imgButtonState;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // off gray
    self.view.backgroundColor = [UIColor colorWithRed:0.863 green:.8671875 blue:.8828125 alpha:1.000];
    float btnRadius = self.view.frame.size.width*0.1;
    float btnSpace = self.view.frame.size.width*0.2/5.0;
    float heightOffset = 100;

    // NO TOGGLE
    textButton = [[MCBouncyButton alloc] initWithText:@"Hi!" andRadius:btnRadius];
    textButton.center = CGPointMake(btnRadius + btnSpace, btnRadius + heightOffset);
    [self.view addSubview:textButton];

    imgButton = [[MCBouncyButton alloc] initWithImage:[UIImage imageNamed:@"pen"] andRadius:btnRadius];
    imgButton.center = CGPointMake(btnRadius*3 + btnSpace*2, btnRadius + heightOffset);
    [self.view addSubview:imgButton];


    // TOGGLE-ABLE
    toggleTextButton = [[MCBouncyButton alloc] initWithText:@"Hi!" andRadius:btnRadius];
    toggleTextButton.center = CGPointMake(btnRadius*5 + btnSpace*3, btnRadius + heightOffset);
    [toggleTextButton addTarget:self action:@selector(toggleTextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toggleTextButton];

    toggleImgButton = [[MCBouncyButton alloc] initWithImage:[UIImage imageNamed:@"pen"] andRadius:btnRadius];
    toggleImgButton.center = CGPointMake(btnRadius*7 + btnSpace*4, btnRadius + heightOffset);
    [toggleImgButton addTarget:self action:@selector(toggleImgButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toggleImgButton];

    textButtonState = NO;
    imgButtonState = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)toggleTextButtonPressed:(MCBouncyButton *)sender
{
    if (textButtonState) {
        [toggleTextButton setStyle:MCBouncyButtonStyleDefault animated:YES];
    } else {
        [toggleTextButton setStyle:MCBouncyButtonStyleSelected animated:YES];
    }
    textButtonState = !textButtonState;
}

- (void)toggleImgButtonPressed:(MCBouncyButton *)sender
{
    if (imgButtonState) {
        [toggleImgButton setStyle:MCBouncyButtonStyleDefault animated:YES];
    } else {
        [toggleImgButton setStyle:MCBouncyButtonStyleSelected animated:YES];
    }
    imgButtonState = !imgButtonState;
}


@end
