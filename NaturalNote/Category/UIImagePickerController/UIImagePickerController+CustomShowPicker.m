//
//  UIImagePickerController+CustomShowPicker.m
//  ProjectSource_Demo
//
//  Created by Liu on 15/11/26.
//  Copyright © 2015年 AngryBear. All rights reserved.
//

#import "UIImagePickerController+CustomShowPicker.h"
#import <objc/runtime.h>

const NSString *kDismissBlockKey = @"kDismissBlockKey";
@implementation UIImagePickerController (CustomShowPicker)

- (void)setDismissBlock:(PickerVCDismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, &kDismissBlockKey, dismissBlock, OBJC_ASSOCIATION_COPY);
}

- (PickerVCDismissBlock)dismissBlock
{
    return objc_getAssociatedObject(self, &kDismissBlockKey);
}

+ (instancetype)showImagePickerWithSourceVC:(UIViewController *)sourceVC sourceType:(UIImagePickerControllerSourceType)sourceType dismissBlock:(PickerVCDismissBlock)dismiss
{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return nil;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = picker;
    picker.sourceType = sourceType;
    picker.dismissBlock = dismiss;
    [sourceVC presentViewController:picker animated:YES completion:^{
        
    }];
    
    return picker;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (picker.dismissBlock) {
        picker.dismissBlock(picker, nil, NO);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (picker.dismissBlock) {
        picker.dismissBlock(picker, image, YES);
    }
}

@end
