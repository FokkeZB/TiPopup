/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComAlexshivePopupPopupMenuProxy.h"
#import "ComAlexshivePopupPopupMenu.h"
#import "TiUtils.h"

@implementation ComAlexshivePopupPopupMenuProxy

// This is to prevent errors from showing up. Thanks BeK0suke
#ifndef USE_VIEW_FOR_UI_METHOD
#define USE_VIEW_FOR_UI_METHOD(methodname)\
-(void)methodname:(id)args\
{\
[self makeViewPerformSelector:@selector(methodname:) withObject:args createIfNeeded:YES waitUntilDone:NO];\
}
#endif

USE_VIEW_FOR_UI_METHOD(show);
USE_VIEW_FOR_UI_METHOD(hide);
USE_VIEW_FOR_UI_METHOD(create);

@end
