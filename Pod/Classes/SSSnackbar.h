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
/**
 *  The duration of time for which the snackbar should be shown on-screen. Changing this value only has effect before the snackbar is presented by sending it the show message.
 */
@property (assign, nonatomic) NSTimeInterval duration;
/**
 *  If this value is set to YES, then the action block is not executed on the main thread to avoid blocking the UI. Instead, it is executed asynchronously on a background queue. 
 */
@property (assign, nonatomic) BOOL actionIsLongRunning;
/**
 *  A block which is called when the user presses the action button on the snackbar.
 *
 *  Generally used to reverse some change made by the user which prompted the snackbar to be displayed.
 */
@property (strong, nonatomic) void (^actionBlock)(SSSnackbar *sender);
/**
 *  A block which is called when the snackbar is dismissed through either remaining on-screen for the specified duration of time, being sent a dismiss message, or being replaced by another snackbar.
 *
 *  In other words, this is called when the snackbar is removed from the screen by any means other than the user pressing the action button.
 *
 *  This can be used to do any work that needs to be done to "finalize" some change made by the user, since at this point the user can no longer undo the action.
 */
@property (strong, nonatomic) void (^dismissalBlock)(SSSnackbar *sender);
/**
 *  Creates and returns a new snackbar object.
 *
 *  @param message        The message displayed on the snackbars's text label.
 *  @param actionText     The text displayed on the snackbar's action button.
 *  @param duration       The duration of time for which the snackbar should remain on the screen.
 *  @param actionBlock    A block to be called when the user presses the action button.
 *  @param dismissalBlock A block to be called when the snackbar is removed from the screen by any means other than the user having pressed the action button. Can be nil.
 *
 */
- (instancetype)initWithMessage:(NSString *)message
                     actionText:(NSString *)actionText
                       duration:(NSTimeInterval)duration
                    actionBlock:(void (^)(SSSnackbar *sender))actionBlock
                 dismissalBlock:(void (^)(SSSnackbar *sender))dismissalBlock;
/**
 *  Convenience constructor
 *
 *  @param message        The message displayed on the snackbars's text label.
 *  @param actionText     The text displayed on the snackbar's action button.
 *  @param duration       The duration of time for which the snackbar should remain on the screen.
 *  @param actionBlock    A block to be called when the user presses the action button.
 *  @param dismissalBlock A block to be called when the snackbar is removed from the screen by any means other than the user having pressed the action button. Can be nil.
 */
+ (instancetype)snackbarWithMessage:(NSString *)message
                         actionText:(NSString *)actionText
                           duration:(NSTimeInterval)duration
                        actionBlock:(void (^)(SSSnackbar *sender))actionBlock
                     dismissalBlock:(void (^)(SSSnackbar *sender))dismissalBlock;
/**
 *  Presents the snackbar to the user for the configured duration of time.
 */
- (void)show;
/**
 *  Removes the snackbar from the screen. Calls the snackbar's dismissal block if one exists, unless the snackbar has its isLongRunning property set to YES and it action button has already been pressed by the user. This message is shorthand for calling dismissAnimated with YES as the argument.
 */
- (void)dismiss;
/**
 *  Removes the snackbar from the screen. Calls the snackbar's dismissal block if one exists, unless the snackbar has its isLongRunning property set to YES and it action button has already been pressed by the user.
 *
 *  @param animated Determines whether the snackbars's removal from the screen is animated or not.
 */
- (void)dismissAnimated:(BOOL)animated;
@end
