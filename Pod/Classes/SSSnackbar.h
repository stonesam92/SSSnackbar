//
//  SSSnackBar.h
//  SSSnackBar Example
//
//  Created by Sam Stone on 04/07/2015.
//  Copyright (c) 2015 Sam Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SSSnackbar : UIView
@property (assign, nonatomic) NSTimeInterval duration;
@property (assign, nonatomic) BOOL shouldShowActivityIndictatorDuringAction;
@property (strong, nonatomic) void (^actionBlock)(SSSnackbar *sender);
@property (strong, nonatomic) void (^dismissalBlock)(SSSnackbar *sender);
- (instancetype)initWithMessage:(NSString *)message
                     actionText:(NSString *)actionText
                       duration:(NSTimeInterval)duration
                    actionBlock:(void (^)(SSSnackbar *sender))actionBlock
                 dismissalBlock:(void (^)(SSSnackbar *sender))dismissalBlock;
- (void)show;
- (void)dismiss;
@end
