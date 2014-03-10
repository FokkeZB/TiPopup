/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import <UIKit/UIKit.h>
#import "TiUIView.h"

@interface ComPopupView : TiUIView {
    @private UIView *square;
}

-(void)show:(id)args;
-(void)hide:(id)args;
-(void)create:(id)args;

@end
