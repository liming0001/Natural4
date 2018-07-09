//
//  UIImagePickerController+CustomShowPicker.h
//  ProjectSource_Demo
//
//  Created by Liu on 15/11/26.
//  Copyright © 2015年 AngryBear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PickerVCDismissBlock)(UIImagePickerController *picker, UIImage *image, BOOL finished);

@interface UIImagePickerController (CustomShowPicker)<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) PickerVCDismissBlock dismissBlock;

+ (instancetype)showImagePickerWithSourceVC:(UIViewController *)sourceVC sourceType:(UIImagePickerControllerSourceType)sourceType dismissBlock:(PickerVCDismissBlock)dismiss;

@end
