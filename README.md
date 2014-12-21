## MCBouncyButton

![MCBouncyButton in action.](https://raw.githubusercontent.com/Shrugs/MCBouncyButton/master/mcbouncybutton.gif "MCBouncyButton in action.")

A bouncy button.

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