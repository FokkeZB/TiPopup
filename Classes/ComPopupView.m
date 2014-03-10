/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComPopupView.h"

@implementation ComPopupView

//@synthesize controller;
//@synthesize view;
// Add native view to titanium
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

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(customMenu)) {
        return YES;
    }
    return NO;
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
    
    UIMenuController* controller = [UIMenuController sharedMenuController];
    
    UIMenuItem * item1 = [[[UIMenuItem alloc] initWithTitle:@"Fish" action:@selector(customMenu)] autorelease];
    UIMenuItem * item2 = [[[UIMenuItem alloc] initWithTitle:@"Stripes" action:@selector(customMenu)] autorelease];
    UIMenuItem * item3 = [[[UIMenuItem alloc] initWithTitle:@"Grass" action:@selector(customMenu)] autorelease];
    
    [controller setMenuItems:[NSArray arrayWithObjects:item1, item2, item3, nil]];
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
	// This method is a property 'setter' for the 'color' property of the
	// view. View property methods are named using a special, required
	// convention (the underscore suffix).
    
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


@end
