//
//  UIView+ViewRadius.m
//  ViewRadius
//
//  Created by Howe on 2020/3/24.
//  Copyright © 2020 howe. All rights reserved.
//

#import "UIView+ViewRadius.h"

@implementation UIView (ViewRadius)
- (void)ViewRadius_addRadius:(CGFloat)radius
             corners:(UIRectCorner)corners
             bgColor:(UIColor *)bgColor{
    UIImageView *imgView = [self m_addCornerImageView];
    CGRect bounds = self.bounds;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self m_addCornerRadius:radius corners:corners imageView:imgView bounds:bounds bgColor:bgColor];
    });
}
#pragma mark - private method
- (UIImageView *)m_addCornerImageView{
    UIImageView *imageView = nil;
    for (UIView *subView in self.subviews) {
        if (subView.tag == 1234567) {
            imageView = (UIImageView *)subView;
            break;
        }
    }
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.userInteractionEnabled = NO;
        imageView.opaque = YES;
        imageView.tag = 1234567;//防重复添加
        //置顶
        imageView.layer.zPosition = 999;
        [self addSubview:imageView];
        [self bringSubviewToFront:imageView];
    }
    
    return imageView;
}
- (void)m_addCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners imageView:(UIImageView *)imageView bounds:(CGRect)bounds bgColor:(UIColor *)bgColor{
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
    UIBezierPath *cornerPath = [[UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)] bezierPathByReversingPath];
    
    [path appendPath:cornerPath];
    //裁剪出圆角路径
    CGContextAddPath(context, path.CGPath);
    //用背景色填充路径
    [bgColor set];
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView.image = image;
    });
}

@end
