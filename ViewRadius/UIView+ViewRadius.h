//
//  UIView+ViewRadius.h
//  ViewRadius
//
//  Created by Howe on 2020/3/24.
//  Copyright © 2020 howe. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ViewRadius)
- (void)ViewRadius_addRadius:(CGFloat)radius
                     corners:(UIRectCorner)corners
                     bgColor:(UIColor *)bgColor;
@end

NS_ASSUME_NONNULL_END
