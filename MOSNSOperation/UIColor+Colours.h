//
//  UIColor+Colours.h
//  ColoursDemo
//
//  Created by Jesper on 4/4/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

// Color Scheme Creation Enum
typedef enum
{
    ColorSchemeAnalagous = 0,
    ColorSchemeMonochromatic,
    ColorSchemeTriad,
    ColorSchemeComplementary
	
} ColorScheme;

@interface UIColor (Colours)

#pragma mark - Color from Hex/RGBA/HSBA
/**
 Creates a UIColor from a Hex representation string
 @param hexString   Hex string that looks like @"#FF0000" or @"FF0000"
 @return    UIColor
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString;

/**
 Creates a UIColor from an array of 4 NSNumbers (r,g,b,a)
 @param rgbaArray   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromRGBAArray:(NSArray *)rgbaArray;

/**
 Creates a UIColor from a dictionary of 4 NSNumbers
 Keys: @"r",@"g",@"b",@"a"
 @param rgbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromRGBADictionary:(NSDictionary *)rgbaDict;

/**
 Creates a UIColor from an array of 4 NSNumbers (h,s,b,a)
 @param hsbaArray   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromHSBAArray:(NSArray *)hsbaArray;

/**
 Creates a UIColor from a dictionary of 4 NSNumbers
 Keys: @"h",@"s",@"b",@"a"
 @param hsbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromHSBADictionary:(NSDictionary *)hsbaDict;


#pragma mark - Hex/RGBA/HSBA from Color
/**
 Creates a Hex representation from a UIColor
 @return    NSString
 */
- (NSString *)hexString;

/**
 Creates an array of 4 NSNumbers representing the float values of r, g, b, a in that order.
 @return    NSArray
 */
- (NSArray *)rgbaArray;

/**
 Creates an array of 4 NSNumbers representing the float values of h, s, b, a in that order.
 @return    NSArray
 */
- (NSArray *)hsbaArray;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "r", "g", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)rgbaDictionary;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "h", "s", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)hsbaDictionary;


#pragma mark - 4 Color Scheme from Color
/**
 Creates an NSArray of 4 UIColors that complement the UIColor.
 @param type ColorSchemeAnalagous, ColorSchemeMonochromatic, ColorSchemeTriad, ColorSchemeComplementary
 @return    NSArray
 */
- (NSArray *)colorSchemeOfType:(ColorScheme)type;


#pragma mark - Contrasting Color from Color
/**
 Creates either [UIColor whiteColor] or [UIColor blackColor] depending on if the color this method is run on is dark or light.
 @return    UIColor
 */
- (UIColor *)blackOrWhiteContrastingColor;


#pragma mark - Colors
// System Colors
+ (UIColor *)infoBlueColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)successColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)warningColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)dangerColorWithAlpha:(CGFloat)alpha;

// Whites
+ (UIColor *)antiqueWhiteColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)oldLaceColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)ivoryColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)seashellColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)ghostWhiteColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)snowColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)linenColorWithAlpha:(CGFloat)alpha;

// Grays
+ (UIColor *)black25PercentColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)black50PercentColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)black75PercentColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)warmGrayColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)coolGrayColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)charcoalColorWithAlpha:(CGFloat)alpha;

// Blues
+ (UIColor *)tealColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)steelBlueColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)robinEggColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)pastelBlueColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)turquoiseColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)skyBlueColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)indigoColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)denimColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)blueberryColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)cornflowerColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)babyBlueColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)midnightBlueColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)fadedBlueColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)icebergColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)waveColorWithAlpha:(CGFloat)alpha;

// Greens
+ (UIColor *)emeraldColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)grassColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)pastelGreenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)seafoamColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)paleGreenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)cactusGreenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)chartreuseColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)hollyGreenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)oliveColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)oliveDrabColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)moneyGreenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)honeydewColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)limeColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)cardTableColorWithAlpha:(CGFloat)alpha;

// Reds
+ (UIColor *)salmonColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)brickRedColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)easterPinkColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)grapefruitColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)pinkColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)indianRedColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)strawberryColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)coralColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)maroonColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)watermelonColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)tomatoColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)pinkLipstickColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)paleRoseColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)crimsonColorWithAlpha:(CGFloat)alpha;

// Purples
+ (UIColor *)eggplantColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)pastelPurpleColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)palePurpleColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)coolPurpleColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)violetColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)plumColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)lavenderColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)raspberryColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)fuschiaColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)grapeColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)periwinkleColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)orchidColorWithAlpha:(CGFloat)alpha;

// Yellows
+ (UIColor *)goldenrodColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)yellowGreenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)bananaColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)mustardColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)buttermilkColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)goldColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)creamColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)lightCreamColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)wheatColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)beigeColorWithAlpha:(CGFloat)alpha;

// Oranges
+ (UIColor *)peachColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)burntOrangeColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)pastelOrangeColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)cantaloupeColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)carrotColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)mandarinColorWithAlpha:(CGFloat)alpha;

// Browns
+ (UIColor *)chiliPowderColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)burntSiennaColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)chocolateColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)coffeeColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)cinnamonColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)almondColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)eggshellColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)sandColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)mudColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)siennaColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)dustColorWithAlpha:(CGFloat)alpha;

// RandomColor
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

// GetColorFromHex
+ (UIColor *) getColorFromHEX:(NSString*)hex
                        Alpha:(CGFloat)alpha;
@end
