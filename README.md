## MCBouncyButton

![MCBouncyButton in action.](https://raw.githubusercontent.com/Shrugs/MCBouncyButton/master/mcbouncybutton.gif "MCBouncyButton in action.")

It's a button! For iOS! And it bounces delightfully!

## Install

`pod 'MCBouncyButton'`

## Usage

```objc
- (id)initWithImage:(UIImage *)image andRadius:(float)radius;
// OR
- (id)initWithText:(NSString *)text andRadius:(float)radius;
```

Then you can change styles with

```objc
- (void)setStyle:(MCBouncyButtonStyle)style animated:(BOOL)animated;
```

Where `MCBouncyButtonStyle` is defined as:

```objc
typedef enum {
    MCBouncyButtonStyleDefault,
    MCBouncyButtonStyleSelected
} MCBouncyButtonStyle;
```

MCBouncyButton will automatically create a negative of your supplied image to use for the selected style.

## Properties

You can change the following properties of the button.

#### Button Properties

- defaultBodyColor - default button body color (default a system grey)
- defaultShadowColor - default button shadow color (default a system grey)
- defaultTextColor - default text color (default black)
- selectedBodyColor - selected button body color (default a happy blue)
- selectedShadowColor - selected button shadow color (default a happy blue)
- selectedTextColor - selected text color (default white)
- relativeIconInset - distance to inset provided icon based on diameter (default 0.2f);

#### Animation Properties

- scaleValue - maximum value to scale button when pressed (default 0.9f)
- buttonBounciness - POP bounciness value (default 20.0f)
- buttonSpeed - POP speed value (default 15.0f)