/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComPopupView.h"

@implementation ComPopupView

-(void)dealloc {
    [super dealloc];
    NSLog(@"dealloc");
}

-(UIView*)square
{
	// Return the square view. If this is the first time then allocate and
	// initialize it.
	if (square == nil) {
		NSLog(@"[VIEW LIFECYCLE EVENT] square");
        square = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        square.backgroundColor = [UIColor redColor];
	}
	return square;
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
    NSLog(@"Hide dialog");
    UIMenuController* controller = [UIMenuController sharedMenuController];
    [controller setMenuVisible:NO animated:YES];
}

-(void)show:(id)args {
    NSLog(@"Show dialog");
    
    [self becomeFirstResponder];
    
    UIMenuController* controller = [UIMenuController sharedMenuController];
    
    [controller setTargetRect:CGRectMake(0,0,1,1) inView:self];
    [controller setMenuVisible:YES animated:YES];
    
}

-(void)create:(id)args {
    
    [self becomeFirstResponder];
    
    // test
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

-(void)customMenu {
    NSLog(@"It works!");
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

-(void)setSquare_:(id)shape
{
    // pretty cool stuff
    // example:
    // popup.createView({ square: 'yes' });
    
	NSLog(@"[VIEW LIFECYCLE EVENT] Property Set: setSquare_");
    
}

-(void)setColor_:(id)color
{
	// This method is a property 'setter' for the 'color' property of the
	// view. View property methods are named using a special, required
	// convention (the underscore suffix).
    
	NSLog(@"[VIEW LIFECYCLE EVENT] Property Set: setColor_");
    
	// Use the TiUtils methods to get the values from the arguments
	TiColor *newColor = [TiUtils colorValue:color];
	UIColor *clr = [newColor _color];
	UIView *sq = [self square];
	sq.backgroundColor = clr;
    
	// Signal a property change notification to demonstrate the use
	// of the proxy for the event listeners
	[self notifyOfColorChange:newColor];
}

#pragma Finding the MenuItemIndex
// Credit:
// http://stackoverflow.com/questions/9146670/ios-uimenucontroller-uimenuitem-how-to-determine-item-selected-with-generic-sel

- (void)tappedMenuItem:(NSString *)buttonText {
    NSLog(@"Index tapped: %@", buttonText);
}
/*
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(customMenu)) {
        return YES;
    }
    return NO;
}
*/
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
