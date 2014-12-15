//
//  MCBouncyButton.m
//
//  Created by Matt Condon on 12/13/14.
//  Copyright (c) 2014 Shrugs. All rights reserved.
//

#import "MCBouncyButton.h"
#import "POP.h"
#import "UIImage+NegativeImage.h"

@implementation MCBouncyButton

- (id)initWithImage:(UIImage *)image andRadius:(float)radius
{
    self = [[self class] buttonWithType:UIButtonTypeCustom];
    if (self) {

        // DEFAULTS

        // a system grey
        self.defaultBodyColor = [UIColor colorWithRed:0.98828125f green:0.98828125f blue:0.98828125f alpha:1.0];
        self.defaultShadowColor = [UIColor colorWithRed:0.515625f green:0.51953125f blue:0.53125f alpha:1.0f];
        // a happy blue
        self.selectedBodyColor = [UIColor colorWithRed:0.04296875f green:0.4140625f blue:0.99609375f alpha:1.0];
        self.selectedShadowColor = [UIColor colorWithRed:0.0f green:0.3671875f blue:0.69140625f alpha:1.0f];

        self.scaleValue = 0.9f;
        self.relativeIconInset = 0.2f;
        self.buttonBounciness = 20.0f;
        self.buttonSpeed = 15.0f;

        // if we have an image, deal with it
        if (image) {
            self.icon = image;
            self.iconNegative = [image negativeImage];
            [self setAdjustsImageWhenDisabled:YES];
        }

        // set frame
        self.frame = CGRectMake(0, 0, radius/2.0, radius/2.0);
        float inset = self.relativeIconInset*(radius/2.0);
        [self setImageEdgeInsets:UIEdgeInsetsMake(inset, inset, inset, inset)];
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        self.layer.shadowOpacity = 1.0f;
        self.layer.shadowRadius = 0.0f;

        // set to default style
        [self setStyle:MCBouncyButtonStyleDefault animated:NO];

        // add handlers
        [self addTarget:self action:@selector(touchDownInside:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchAll:) forControlEvents:UIControlEventAllTouchEvents];
    }
    return self;
}

- (void)setStyle:(MCBouncyButtonStyle)style animated:(BOOL)animated
{

    switch (style) {
        case MCBouncyButtonStyleDefault: {
            // if we have an icon, set it
            if (self.icon) {
                [self setImage:self.icon forState:UIControlStateNormal];
            }

            if (animated) {
                [self animateToBackgroundColor:self.defaultBodyColor
                                andShadowColor:self.defaultShadowColor];
            } else {
                self.layer.backgroundColor = [self.defaultBodyColor CGColor];
                self.layer.shadowColor = [self.defaultShadowColor CGColor];
            }

            break;
        }
        case MCBouncyButtonStyleSelected: {
            // if we have an icon, set it
            if (self.icon) {
                [self setImage:self.iconNegative forState:UIControlStateNormal];
            }

            if (animated) {
                [self animateToBackgroundColor:self.selectedBodyColor
                                andShadowColor:self.selectedShadowColor];
            } else {
                self.layer.backgroundColor = [self.selectedBodyColor CGColor];
                self.layer.shadowColor = [self.selectedShadowColor CGColor];
            }

            break;
        }
        default:
            break;
    }
}

- (void)touchDownInside:(MCBouncyButton *)btn
{
    // cancel a previous animation
    POPSpringAnimation *scaleUpAnim = [self.layer pop_animationForKey:@"mcbouncybutton_scaleUp"];
    if (scaleUpAnim) {
        [self.layer removeAnimationForKey:@"mcbouncybutton_scaleUp"];
    }

    // bounce to smaller size
    POPBasicAnimation *anim = [self.layer pop_animationForKey:@"mcbouncybutton_scaleDown"];
    if (!anim) {
        anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    }
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(self.scaleValue, self.scaleValue)];
    // @TODO(Shrugs) this may or may not be a valuable exported variable
    anim.duration = 0.1f;
    [self.layer pop_addAnimation:anim forKey:@"mcbouncybutton_scaleDown"];
}
- (void)touchUpInside:(MCBouncyButton *)btn
{
    // bounce back to normal size
    POPBasicAnimation *oldAnim = [self.layer pop_animationForKey:@"mcbouncybutton_scaleDown"];
    if (oldAnim) {
        // wait for previous animation to finish if necessary
        oldAnim.completionBlock = ^(POPAnimation *oldAnim, BOOL finished) {
            [self scaleUp];
        };
    } else {
        [self scaleUp];
    }

}

// detects when user touches inside button, drags finger outside of the view, and then releases
- (void)touchAll:(MCBouncyButton *)btn
{
    if(![btn isTracking]) {
        [self touchUpInside:btn];
    }
}

- (void)scaleUp
{
    // rescale button to 1.0x1.0
    POPSpringAnimation *anim = [self.layer pop_animationForKey:@"mcbouncybutton_scaleUp"];
    if (!anim) {
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    }
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    anim.springBounciness = self.buttonBounciness;
    anim.springSpeed = self.buttonSpeed;
    [self.layer pop_addAnimation:anim forKey:@"mcbouncybutton_scaleUp"];
}

- (void)animateToBackgroundColor:(UIColor *)bgc andShadowColor:(UIColor *)sc
{
    // animate body
    POPSpringAnimation *colorAnimation = [self.layer pop_animationForKey:@"mcbouncybutton_colorShift"];
    if (!colorAnimation) {
        colorAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    }
    colorAnimation.toValue = (id)[bgc CGColor];
    [self.layer pop_addAnimation:colorAnimation forKey:@"mcbouncybutton_colorShift"];

    // animate shadow
    POPSpringAnimation *shadowAnimation = [self.layer pop_animationForKey:@"mcbouncybutton_shadowShift"];
    if (!shadowAnimation) {
        shadowAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowColor];
    }
    shadowAnimation.toValue = (id)[sc CGColor];
    [self.layer pop_addAnimation:shadowAnimation forKey:@"mcbouncybutton_shadowShift"];
}

@end
