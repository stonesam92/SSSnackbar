# SSSnackbar

[![Version](https://img.shields.io/cocoapods/v/SSSnackbar.svg?style=flat)](http://cocoapods.org/pods/SSSnackbar)
[![License](https://img.shields.io/cocoapods/l/SSSnackbar.svg?style=flat)](http://cocoapods.org/pods/SSSnackbar)
[![Platform](https://img.shields.io/cocoapods/p/SSSnackbar.svg?style=flat)](http://cocoapods.org/pods/SSSnackbar)

## Author

Sam Stone, sam@samstonedev.com

## About 

[Snackbars are a Android UI component](http://www.google.co.uk/design/spec/components/snackbars-toasts.html#) which present a stylish, actionable alert to the user. Google also uses their own iOS snackbar implementation in some of their iOS apps, such as Gmail.

Snackbar's are useful for presenting a brief message to the user which they can then act on. A common usage pattern is to display a snackbar after a user has performed some destructive action, providing the user with a grace period during which they can undo this action.

This use-case is demonstrated in the iOS Google Gmail app:
![Gmail implementation](http://i.imgur.com/xnlQguQ.gif)

Below is a demonstration of the snackbar as realized by this project:
![SSSnackbar implementation](http://i.imgur.com/9vJ8GOO.gif)

## Example Project
The included example project provides a demonstration of SSSnackbar. It displays a tableView containing a shopping list. When an item is deleted from the shopping list, a snackbar is presented allowing the user to undo that deletion.

The shopping list is divided into two sections:

* Normal Examples: deleting items from this sections demonstrates the standard use of a snackbar, with which the action block (executed when the user presses the snackbar's button), is executed on the main thread.
* Long-Running Action Examples: deleting items from this section demonstrates the use of a snackbar object with a long-running action block which is executed in the background.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

This project is available via CocoaPods. In order to install, simply add `"SSSnackbar"` to your Podfile. 

You can also integrate SSSnackbar manually by downloading SSSnackbar.h and SSSnackbar.m and adding them to your project.

## Usage

This project contains a single class: `SSSnackbar`. 

`SSSnackbar` objects cannot be "stacked" on-screen. If you display a snackbar while another is on-screen, the currently shown snackbar will be replaced, and it will act as though it had been dismissed after being on-screen for its configured length of time.

All messages sent to `SSSnackbar` objects should be sent from the main thread.

### Creating instances of `SSSnackbar`

New snackbar objects can be created using the following methods:

    - (instancetype)initWithMessage:(NSString *)message
                     actionText:(NSString *)actionText
                       duration:(NSTimeInterval)duration
                    actionBlock:(void (^)(SSSnackbar *sender))actionBlock
                 dismissalBlock:(void (^)(SSSnackbar *sender))dismissalBlock
                 
    + (instancetype)snackbarWithMessage:(NSString *)message
                         actionText:(NSString *)actionText
                           duration:(NSTimeInterval)duration
                        actionBlock:(void (^)(SSSnackbar *sender))actionBlock
                     dismissalBlock:(void (^)(SSSnackbar *sender))dismissalBlock 

* `message` is the text to be displayed on the snackbar's text label.
* `actionText` is the text to be used as the title for the snackbar's button.
* `duration` is the length of time for which the snackbar should remain on the screen before it is dismissed
* `actionBlock` is a block to be called if the user presses the snackbar's button. Unless the snackbar object is configured otherwise, this block is executed on the main thread.
* `dismissalBlock` is a block to be called when the snackbar is dismissed from the screen without having its action button pressed. This can be used to finalize any action the user has taken, since at this poin the user's grace period to undo the change is over.

### Configuring `SSSnackbar` instances.

The properties set wusing the initialiser method can be changed after the object is created, but should not be altered once the snackbar has been presented on-screen.

By default, `actionBlock` is executed on the main thread. If the block will take significant time to execute, then it can be run on a background thread by setting the snackbar's `actionIsLongRunning` property to `YES`. 

In this case, the block will be executed on a background thread and a `UIActivityIndicator` will replace the snackbar's action button. 

### Displaying `SSSnackbar` instances to the user

Once created and configured, a snackbar object can be shown on the screen by sending it the `show` message.

### Dismissing `SSSnackbar` instances

Snackbar objects dismiss themselves either after they have remained on-screen for their configured duration of time, or if the user presses the snackbar's button and the snackbar's action block has finished executing.

It is sometimes necessary however, to dismiss a snackbar object manually. This can be done by sending the object either the `dismiss` or `dismissAnimated:(BOOL)animated` messages.
