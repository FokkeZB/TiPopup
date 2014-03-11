/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComPopupPopupMenu.h"
#import "TiUtils.h"
#import "TiViewProxy.h"

@implementation ComPopupPopupMenu

-(void)dealloc {
    [super dealloc];
    NSLog(@"dealloc");
}

- (id)init {
    self = [super init];
    if (self != nil) {
        NSLog(@"Init called");
        UIMenuController* controller = [UIMenuController sharedMenuController];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

-(void)hide:(id)args {
    //NSLog(@"Hide dialog");
    UIMenuController* controller = [UIMenuController sharedMenuController];
    [controller setMenuVisible:NO animated:YES];
}

-(void)show:(id)args {
    //NSLog(@"Show dialog");
    
    [self becomeFirstResponder];
    NSDictionary *arguments = [args objectAtIndex:0];
    
    TiViewProxy *viewProx = [arguments objectForKey:@"view"];
    UIView *_view = viewProx.view;
    CGSize _size = _view.frame.size;
    
    UIMenuController* controller = [UIMenuController sharedMenuController];
    
    [controller setTargetRect:CGRectMake(0,0,_size.width,_size.height) inView:_view];
    
    [controller setMenuVisible:YES animated:YES];
    
}

-(void)create:(id)args {
    
    [self becomeFirstResponder];
    
    // test
    ENSURE_ARRAY(args);
    NSDictionary *arguments = [args objectAtIndex:0];
    NSArray * menuItems = [arguments objectForKey:@"items"];
    // NSLog(menuItems[0]);
    
    NSMutableArray * menuControllerItems = [[NSMutableArray alloc] init];
    
    [menuItems enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        // do something with object
        // NSString *menuItemName = menuItems[idx];
        NSString *menuItemName = [NSString stringWithFormat:@"magic_%lu", (unsigned long)idx];
        //NSLog(menuItemName);
        [menuControllerItems addObject:[[[UIMenuItem alloc] initWithTitle:menuItems[idx] action:NSSelectorFromString(menuItemName)] autorelease]];
    }];
    
    
    UIMenuController* controller = [UIMenuController sharedMenuController];
    
    [controller setMenuItems:menuControllerItems];
    
    [menuControllerItems release];
    
}

-(void)notifyOfColorChange:(TiColor*)newColor
{
	NSLog(@"[VIEW LIFECYCLE EVENT] notifyOfColorChange");
    
	// The event listeners for a view are actually attached to the view proxy.
	// You must reference 'self.proxy' to get the proxy for this view
    
	// It is a good idea to check if there are listeners for the event that
	// is about to fired. There could be zero or multiple listeners for the
	// specified event.
	if ([self.proxy _hasListeners:@"colorChange"]) {
		NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
							   newColor,@"color",
							   nil
							   ];
        
		[self.proxy fireEvent:@"colorChange" withObject:event];
	}
}

/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan called, where are ya?");
    CGPoint tapPoint = [[touches anyObject] locationInView:self];
    NSLog(@"x: %f", tapPoint.x);
    NSLog(@"y: %f", tapPoint.y);
    [self becomeFirstResponder];
    
    UIMenuController* controller = [UIMenuController sharedMenuController];
    
    [controller setTargetRect:CGRectMake(tapPoint.x,tapPoint.y,1,1) inView:self];
    [controller setMenuVisible:YES animated:YES];
}
 */

#pragma Finding the MenuItemIndex
// Credit:
// http://stackoverflow.com/questions/9146670/ios-uimenucontroller-uimenuitem-how-to-determine-item-selected-with-generic-sel

- (void)tappedMenuItem:(NSString *)buttonText {
    // NSLog(@"Index tapped: %@", buttonText);
    NSDictionary *indexReturn = [NSDictionary dictionaryWithObjectsAndKeys:buttonText,@"index",nil];
    [self.proxy fireEvent:@"click" withObject:indexReturn];
    UIMenuController* controller = [UIMenuController sharedMenuController];
    [controller setMenuVisible:NO animated:YES];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSString *sel = NSStringFromSelector(action);
    NSRange match = [sel rangeOfString:@"magic_"];
    if (match.location == 0) {
        return YES;
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if ([super methodSignatureForSelector:sel]) {
        return [super methodSignatureForSelector:sel];
    }
    return [super methodSignatureForSelector:@selector(tappedMenuItem:)];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *sel = NSStringFromSelector([invocation selector]);
    NSRange match = [sel rangeOfString:@"magic_"];
    if (match.location == 0) {
        [self tappedMenuItem:[sel substringFromIndex:6]];
    } else {
        [super forwardInvocation:invocation];
    }
}


@end
