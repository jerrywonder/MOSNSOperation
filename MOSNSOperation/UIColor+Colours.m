//
//  UIColor+Colours.m
//  ColoursDemo
//
//  Created by Jesper on 4/4/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "UIColor+Colours.h"

@implementation UIColor (Colours)

#pragma mark - randomColor
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;
{
    CGFloat red = arc4random() % 256 / 256.0;
    CGFloat green = arc4random() % 256 / 256.0;
    CGFloat blue = arc4random() % 256 / 256.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - UIColor from Hex
+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
	
    [scanner scanHexInt:&rgbValue];
	
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


#pragma mark - Hex from UIColor
- (NSString *)hexString
{
    NSArray *colorArray	= [self rgbaArray];
    int r = [colorArray[0] floatValue] * 255;
    int g = [colorArray[1] floatValue] * 255;
    int b = [colorArray[2] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
	
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}


#pragma mark - UIColor from RGBA
+ (UIColor *)colorFromRGBAArray:(NSArray *)rgbaArray
{
    if (rgbaArray.count < 4) {
        return [UIColor clearColor];
    }
    // Takes an array of RGBA float's as NSNumbers, and makes a UIColor (shorthand colorWithRed:Green:Blue:Alpha:
    return [UIColor colorWithRed:[rgbaArray[0] floatValue] green:[rgbaArray[1] floatValue] blue:[rgbaArray[2] floatValue] alpha:[rgbaArray[3] floatValue]];
}

+ (UIColor *)colorFromRGBADictionary:(NSDictionary *)rgbaDict
{
    if (rgbaDict[@"r"] && rgbaDict[@"g"] && rgbaDict[@"b"] && rgbaDict[@"a"]) {
        return [UIColor colorWithRed:[rgbaDict[@"r"] floatValue] green:[rgbaDict[@"g"] floatValue] blue:[rgbaDict[@"b"] floatValue] alpha:[rgbaDict[@"a"] floatValue]];
    }
    
    return [UIColor clearColor];
}


#pragma mark - RGBA from UIColor
- (NSArray *)rgbaArray
{
    // Takes a UIColor and returns R,G,B,A values in NSNumber form
    CGFloat r=0,g=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    return @[@(r),
             @(g),
             @(b), 
             @(a)];
}

- (NSDictionary *)rgbaDictionary
{
    // Takes UIColor and returns RGBA values in a dictionary as NSNumbers
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"r":@(r), @"g":@(g), @"b":@(b), @"a":@(a)};
}


#pragma mark - HSBA from UIColor
- (NSArray *)hsbaArray
{
    // Takes a UIColor and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
    CGFloat h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    
    return @[@(h),
             @(s),
             @(b), 
             @(a)];
}

- (NSDictionary *)hsbaDictionary
{
    // Takes a UIColor and returns Hue,Saturation,Brightness,Alpha values in NSNumber form
    CGFloat h=0,s=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [self getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    
    return @{@"h":@(h), @"s":@(s), @"b":@(b), @"a":@(a)};
}


#pragma mark - UIColor from HSBA
+ (UIColor *)colorFromHSBAArray:(NSArray *)hsbaArray
{
    if (hsbaArray.count < 4) {
        return [UIColor clearColor];
    }
    
    return [UIColor colorWithHue:[hsbaArray[0] doubleValue] saturation:[hsbaArray[1] doubleValue] brightness:[hsbaArray[2] doubleValue] alpha:[hsbaArray[3] doubleValue]];
}

+ (UIColor *)colorFromHSBADictionary:(NSDictionary *)hsbaDict
{
    if (hsbaDict[@"h"] && hsbaDict[@"s"] && hsbaDict[@"b"] && hsbaDict[@"a"]) {
        return [UIColor colorWithHue:[hsbaDict[@"h"] doubleValue] saturation:[hsbaDict[@"s"] doubleValue] brightness:[hsbaDict[@"b"] doubleValue] alpha:[hsbaDict[@"a"] doubleValue]];
    }
    
    return [UIColor clearColor];
}


#pragma mark - Generate Color Scheme
- (NSArray *)colorSchemeOfType:(ColorScheme)type
{
    NSArray *hsbArray = [self hsbaArray];
    float hue = [hsbArray[0] floatValue] * 360;
    float sat = [hsbArray[1] floatValue] * 100;
    float bright = [hsbArray[2] floatValue] * 100;
    float alpha = [hsbArray[3] floatValue];
    
    switch (type) {
        case ColorSchemeAnalagous:
            return [UIColor analagousColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeMonochromatic:
            return [UIColor monochromaticColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeTriad:
            return [UIColor triadColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        case ColorSchemeComplementary:
            return [UIColor complementaryColorsFromHue:hue saturation:sat brightness:bright alpha:alpha];
        default:
            return nil;
    }
}


#pragma mark - Color Scheme Generation - Helper methods
+ (NSArray *)analagousColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:[UIColor addDegrees:15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:[UIColor addDegrees:30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:[UIColor addDegrees:-15 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-5)/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:[UIColor addDegrees:-30 toDegree:h]/360 saturation:(s-5)/100 brightness:(b-10)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)monochromaticColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:h/360 saturation:s/100 brightness:(b/2)/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:h/360 saturation:(s/2)/100 brightness:(b/3)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:h/360 saturation:(s/3)/100 brightness:(2*b/3)/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)triadColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:[UIColor addDegrees:120 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:[UIColor addDegrees:120 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:[UIColor addDegrees:240 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:[UIColor addDegrees:240 toDegree:h]/360 saturation:(7*s/6)/100 brightness:(b-5)/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (NSArray *)complementaryColorsFromHue:(float)h saturation:(float)s brightness:(float)b alpha:(float)a
{
    UIColor *colorAbove1 = [UIColor colorWithHue:h/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    UIColor *colorAbove2 = [UIColor colorWithHue:h/360 saturation:s/100 brightness:(4*b/5)/100 alpha:a];
    UIColor *colorBelow1 = [UIColor colorWithHue:[UIColor addDegrees:180 toDegree:h]/360 saturation:s/100 brightness:b/100 alpha:a];
    UIColor *colorBelow2 = [UIColor colorWithHue:[UIColor addDegrees:180 toDegree:h]/360 saturation:(5*s/7)/100 brightness:b/100 alpha:a];
    
    return @[colorAbove2,colorAbove1,colorBelow1,colorBelow2];
}

+ (float)addDegrees:(float)addDeg toDegree:(float)staticDeg
{
    staticDeg += addDeg;
    if (staticDeg > 360) {
        float offset = staticDeg - 360;
        return offset;
    }
    else if (staticDeg < 0) {
        return -1 * staticDeg;
    }
    else {
        return staticDeg;
    }
}


#pragma mark - Contrasting Color
- (UIColor *)blackOrWhiteContrastingColor
{
    NSArray *rgbaArray = [self rgbaArray];
    double a = 1 - ((0.299 * [rgbaArray[0] doubleValue]) + (0.587 * [rgbaArray[1] doubleValue]) + (0.114 * [rgbaArray[2] doubleValue]));
    return a < 0.5 ? [UIColor blackColor] : [UIColor whiteColor];
}


#pragma mark - System Colors
+ (UIColor *)infoBlueColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:alpha];
}

+ (UIColor *)successColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:83/255.0f green:215/255.0f blue:106/255.0f alpha:alpha];
}

+ (UIColor *)warningColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:221/255.0f green:170/255.0f blue:59/255.0f alpha:alpha];
}

+ (UIColor *)dangerColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:229/255.0f green:0/255.0f blue:15/255.0f alpha:alpha];
}


#pragma mark - Whites
+ (UIColor *)antiqueWhiteColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:250/255.0f green:235/255.0f blue:215/255.0f alpha:alpha];
}

+ (UIColor *)oldLaceColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:253/255.0f green:245/255.0f blue:230/255.0f alpha:alpha];
}

+ (UIColor *)ivoryColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:255/255.0f blue:240/255.0f alpha:alpha];
}

+ (UIColor *)seashellColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:245/255.0f blue:238/255.0f alpha:alpha];
}

+ (UIColor *)ghostWhiteColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:248/255.0f green:248/255.0f blue:255/255.0f alpha:alpha];
}

+ (UIColor *)snowColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:250/255.0f blue:250/255.0f alpha:alpha];
}

+ (UIColor *)linenColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:250/255.0f green:240/255.0f blue:230/255.0f alpha:alpha];
}


#pragma mark - Grays
+ (UIColor *)black25PercentColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithWhite:0.25 alpha:alpha];
}

+ (UIColor *)black50PercentColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithWhite:0.5  alpha:alpha];
}

+ (UIColor *)black75PercentColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithWhite:0.75 alpha:alpha];
}

+ (UIColor *)warmGrayColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:133/255.0f green:117/255.0f blue:112/255.0f alpha:alpha];
}

+ (UIColor *)coolGrayColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:118/255.0f green:122/255.0f blue:133/255.0f alpha:alpha];
}

+ (UIColor *)charcoalColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:alpha];
}


#pragma mark - Blues
+ (UIColor *)tealColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:alpha];
}

+ (UIColor *)steelBlueColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:103/255.0f green:153/255.0f blue:170/255.0f alpha:alpha];
}

+ (UIColor *)robinEggColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:141/255.0f green:218/255.0f blue:247/255.0f alpha:alpha];
}

+ (UIColor *)pastelBlueColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:99/255.0f green:161/255.0f blue:247/255.0f alpha:alpha];
}

+ (UIColor *)turquoiseColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:112/255.0f green:219/255.0f blue:219/255.0f alpha:alpha];
}

+ (UIColor *)skyBlueColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:0/255.0f green:178/255.0f blue:238/255.0f alpha:alpha];
}

+ (UIColor *)indigoColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:13/255.0f green:79/255.0f blue:139/255.0f alpha:alpha];
}

+ (UIColor *)denimColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:67/255.0f green:114/255.0f blue:170/255.0f alpha:alpha];
}

+ (UIColor *)blueberryColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:89/255.0f green:113/255.0f blue:173/255.0f alpha:alpha];
}

+ (UIColor *)cornflowerColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:100/255.0f green:149/255.0f blue:237/255.0f alpha:alpha];
}

+ (UIColor *)babyBlueColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:190/255.0f green:220/255.0f blue:230/255.0f alpha:alpha];
}

+ (UIColor *)midnightBlueColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:13/255.0f green:26/255.0f blue:35/255.0f alpha:alpha];
}

+ (UIColor *)fadedBlueColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:23/255.0f green:137/255.0f blue:155/255.0f alpha:alpha];
}

+ (UIColor *)icebergColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:200/255.0f green:213/255.0f blue:219/255.0f alpha:alpha];
}

+ (UIColor *)waveColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:102/255.0f green:169/255.0f blue:251/255.0f alpha:alpha];
}


#pragma mark - Greens
+ (UIColor *)emeraldColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:1/255.0f green:152/255.0f blue:117/255.0f alpha:alpha];
}

+ (UIColor *)grassColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:99/255.0f green:214/255.0f blue:74/255.0f alpha:alpha];
}

+ (UIColor *)pastelGreenColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:126/255.0f green:242/255.0f blue:124/255.0f alpha:alpha];
}

+ (UIColor *)seafoamColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:77/255.0f green:226/255.0f blue:140/255.0f alpha:alpha];
}

+ (UIColor *)paleGreenColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:176/255.0f green:226/255.0f blue:172/255.0f alpha:alpha];
}

+ (UIColor *)cactusGreenColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:99/255.0f green:111/255.0f blue:87/255.0f alpha:alpha];
}

+ (UIColor *)chartreuseColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:69/255.0f green:139/255.0f blue:0/255.0f alpha:alpha];
}

+ (UIColor *)hollyGreenColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:32/255.0f green:87/255.0f blue:14/255.0f alpha:alpha];
}

+ (UIColor *)oliveColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:91/255.0f green:114/255.0f blue:34/255.0f alpha:alpha];
}

+ (UIColor *)oliveDrabColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:107/255.0f green:142/255.0f blue:35/255.0f alpha:alpha];
}

+ (UIColor *)moneyGreenColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:134/255.0f green:198/255.0f blue:124/255.0f alpha:alpha];
}

+ (UIColor *)honeydewColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:216/255.0f green:255/255.0f blue:231/255.0f alpha:alpha];
}

+ (UIColor *)limeColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:56/255.0f green:237/255.0f blue:56/255.0f alpha:alpha];
}

+ (UIColor *)cardTableColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:87/255.0f green:121/255.0f blue:107/255.0f alpha:alpha];
}


#pragma mark - Reds
+ (UIColor *)salmonColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:233/255.0f green:87/255.0f blue:95/255.0f alpha:alpha];
}

+ (UIColor *)brickRedColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:151/255.0f green:27/255.0f blue:16/255.0f alpha:alpha];
}

+ (UIColor *)easterPinkColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:241/255.0f green:167/255.0f blue:162/255.0f alpha:alpha];
}

+ (UIColor *)grapefruitColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:228/255.0f green:31/255.0f blue:54/255.0f alpha:alpha];
}

+ (UIColor *)pinkColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:95/255.0f blue:154/255.0f alpha:alpha];
}

+ (UIColor *)indianRedColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:205/255.0f green:92/255.0f blue:92/255.0f alpha:alpha];
}

+ (UIColor *)strawberryColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:190/255.0f green:38/255.0f blue:37/255.0f alpha:alpha];
}

+ (UIColor *)coralColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:240/255.0f green:128/255.0f blue:128/255.0f alpha:alpha];
}

+ (UIColor *)maroonColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:80/255.0f green:4/255.0f blue:28/255.0f alpha:alpha];
}

+ (UIColor *)watermelonColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:242/255.0f green:71/255.0f blue:63/255.0f alpha:alpha];
}

+ (UIColor *)tomatoColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:99/255.0f blue:71/255.0f alpha:alpha];
}

+ (UIColor *)pinkLipstickColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:105/255.0f blue:180/255.0f alpha:alpha];
}

+ (UIColor *)paleRoseColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:228/255.0f blue:225/255.0f alpha:alpha];
}

+ (UIColor *)crimsonColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:187/255.0f green:18/255.0f blue:36/255.0f alpha:alpha];
}


#pragma mark - Purples
+ (UIColor *)eggplantColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:105/255.0f green:5/255.0f blue:98/255.0f alpha:alpha];
}

+ (UIColor *)pastelPurpleColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:207/255.0f green:100/255.0f blue:235/255.0f alpha:alpha];
}

+ (UIColor *)palePurpleColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:229/255.0f green:180/255.0f blue:235/255.0f alpha:alpha];
}

+ (UIColor *)coolPurpleColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:140/255.0f green:93/255.0f blue:228/255.0f alpha:alpha];
}

+ (UIColor *)violetColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:191/255.0f green:95/255.0f blue:255/255.0f alpha:alpha];
}

+ (UIColor *)plumColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:139/255.0f green:102/255.0f blue:139/255.0f alpha:alpha];
}

+ (UIColor *)lavenderColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:204/255.0f green:153/255.0f blue:204/255.0f alpha:alpha];
}

+ (UIColor *)raspberryColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:135/255.0f green:38/255.0f blue:87/255.0f alpha:alpha];
}

+ (UIColor *)fuschiaColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:255/255.0f green:20/255.0f blue:147/255.0f alpha:alpha];
}

+ (UIColor *)grapeColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:54/255.0f green:11/255.0f blue:88/255.0f alpha:alpha];
}

+ (UIColor *)periwinkleColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:135/255.0f green:159/255.0f blue:237/255.0f alpha:alpha];
}

+ (UIColor *)orchidColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:218/255.0f green:112/255.0f blue:214/255.0f alpha:alpha];
}


#pragma mark - Yellows
+ (UIColor *)goldenrodColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:215/255.0f green:170/255.0f blue:51/255.0f alpha:alpha];
}

+ (UIColor *)yellowGreenColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:192/255.0f green:242/255.0f blue:39/255.0f alpha:alpha];
}

+ (UIColor *)bananaColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:229/255.0f green:227/255.0f blue:58/255.0f alpha:alpha];
}

+ (UIColor *)mustardColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:205/255.0f green:171/255.0f blue:45/255.0f alpha:alpha];
}

+ (UIColor *)buttermilkColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:254/255.0f green:241/255.0f blue:181/255.0f alpha:alpha];
}

+ (UIColor *)goldColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:139/255.0f green:117/255.0f blue:18/255.0f alpha:alpha];
}

+ (UIColor *)creamColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:240/255.0f green:226/255.0f blue:187/255.0f alpha:alpha];
}

+ (UIColor *)lightCreamColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:alpha];
}

+ (UIColor *)wheatColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:240/255.0f green:238/255.0f blue:215/255.0f alpha:alpha];
}

+ (UIColor *)beigeColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:245/255.0f green:245/255.0f blue:220/255.0f alpha:alpha];
}


#pragma mark - Oranges
+ (UIColor *)peachColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:242/255.0f green:187/255.0f blue:97/255.0f alpha:alpha];
}

+ (UIColor *)burntOrangeColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:184/255.0f green:102/255.0f blue:37/255.0f alpha:alpha];
}

+ (UIColor *)pastelOrangeColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:248/255.0f green:197/255.0f blue:143/255.0f alpha:alpha];
}

+ (UIColor *)cantaloupeColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:250/255.0f green:154/255.0f blue:79/255.0f alpha:alpha];
}

+ (UIColor *)carrotColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:237/255.0f green:145/255.0f blue:33/255.0f alpha:alpha];
}

+ (UIColor *)mandarinColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:247/255.0f green:145/255.0f blue:55/255.0f alpha:alpha];
}


#pragma mark - Browns
+ (UIColor *)chiliPowderColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:199/255.0f green:63/255.0f blue:23/255.0f alpha:alpha];
}

+ (UIColor *)burntSiennaColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:138/255.0f green:54/255.0f blue:15/255.0f alpha:alpha];
}

+ (UIColor *)chocolateColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:94/255.0f green:38/255.0f blue:5/255.0f alpha:alpha];
}

+ (UIColor *)coffeeColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:141/255.0f green:60/255.0f blue:15/255.0f alpha:alpha];
}

+ (UIColor *)cinnamonColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:123/255.0f green:63/255.0f blue:9/255.0f alpha:alpha];
}

+ (UIColor *)almondColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:196/255.0f green:142/255.0f blue:72/255.0f alpha:alpha];
}

+ (UIColor *)eggshellColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:252/255.0f green:230/255.0f blue:201/255.0f alpha:alpha];
}

+ (UIColor *)sandColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:222/255.0f green:182/255.0f blue:151/255.0f alpha:alpha];
}

+ (UIColor *)mudColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:70/255.0f green:45/255.0f blue:29/255.0f alpha:alpha];
}

+ (UIColor *)siennaColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:160/255.0f green:82/255.0f blue:45/255.0f alpha:alpha];
}

+ (UIColor *)dustColorWithAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:236/255.0f green:214/255.0f blue:197/255.0f alpha:alpha];
}

+ (UIColor *) getColorFromHEX:(NSString*)hex
                        Alpha:(CGFloat)alpha
{
    hex = [[hex uppercaseString]substringFromIndex:1];
    CGFloat valueArray[3];
    NSArray * strArray = [NSArray arrayWithObjects:[hex substringWithRange:NSMakeRange(0, 2)],[hex substringWithRange:NSMakeRange(2, 2)],[hex substringWithRange:NSMakeRange(4, 2)],nil];
    for (int i = 0; i<strArray.count; i++) {
        hex = strArray[i];
        CGFloat value = ([hex characterAtIndex:0]>'9'?[hex characterAtIndex:0]-'A'+10:[hex characterAtIndex:0]-'0')*16.0f+([hex characterAtIndex:1]>'9'?[hex characterAtIndex:1]-'A'+10:[hex characterAtIndex:1]-'0');
        valueArray[i] = value;
    }
    return [UIColor colorWithRed:valueArray[0]/255 green:valueArray[1]/255 blue:valueArray[2]/255 alpha:alpha];
}

@end
