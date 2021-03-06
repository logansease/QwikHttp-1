//
//  MBProgressHUD+Singleton.m
//  Pods
//
//  Created by Logan Sease on 12/13/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+Singleton.h"
#import "NSThread+Helpers.h"

@implementation MBProgressHUD (Singleton)


static MBProgressHUD * commonHUD = nil;

+(id)commonHUD
{
    if(commonHUD == nil)
    {
        [MBProgressHUD setupCommonHUDWithView:nil];
    }
    
    return commonHUD;
}

+(void)showWithTitle:(NSString*)title
{
    [NSThread mainThread:^{
        MBProgressHUD * hud = [self commonHUD];
        hud.labelText = title;
        hud.labelFont = [UIFont systemFontOfSize:20];
#if TARGET_OS_TV
        hud.labelFont = [UIFont systemFontOfSize:60];
#endif
        
        [hud show:YES];
    }];

}

+(void)hide
{
    [NSThread mainThread:^{
    MBProgressHUD * hud = [self commonHUD];
    [hud hide:YES];
    }];
}

+(void)setupCommonHUDWithView:(UIView*)view
{
    if(view ==nil && ![UIApplication sharedApplication].keyWindow)
    {
        NSLog(@"tried to create the common HUD without a view");
        return;
    }
    if(view == nil)
    {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    if(view == nil)
    {
        return;
    }
    
    if(commonHUD == nil)
    {
        commonHUD = [[MBProgressHUD alloc]initWithView:view];
    }
    [view addSubview:commonHUD];
    [view bringSubviewToFront:commonHUD];
    
}


@end
