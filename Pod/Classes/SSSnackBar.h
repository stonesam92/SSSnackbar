//
//  SSSnackBar.h
//  SSSnackBar Example
//
//  Created by Sam Stone on 04/07/2015.
//  Copyright (c) 2015 Sam Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SSSnackBar : UIView
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) NSTimeInterval duration;
@property (assign, nonatomic) BOOL shouldShowActivityIndictatorDuringAction;
@property (strong, nonatomic) void (^actionHandler)(SSSnackBar *sender);
@property (strong, nonatomic) void (^dismissalHandler)(SSSnackBar *sender);
- (instancetype)initWithMessage:(NSString *)message
                     actionText:(NSString *)actionText
                       duration:(NSTimeInterval)duration
                    actionBlock:(void (^)(SSSnackBar *sender))actionBlock
                 dismissalBlock:(void (^)(SSSnackBar *sender))dismissalBlock;
- (void)show;
- (void)dismiss;
@end
