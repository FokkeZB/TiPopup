//
//  ComPopupViewController.m
//  TiPopup
//
//  Created by Shive, Alex on 3/4/14.
//
//

#import "ComPopupViewController.h"

@interface ComPopupViewController ()

@end

@implementation ComPopupViewController

-(void)showController {
    [self becomeFirstResponder];
    UIMenuController* controller = [UIMenuController sharedMenuController];
    
    UIMenuItem * item1 = [[[UIMenuItem alloc] initWithTitle:@"Fish" action:@selector(customMenu)] autorelease];
    UIMenuItem * item2 = [[[UIMenuItem alloc] initWithTitle:@"Stripes" action:@selector(customMenu)] autorelease];
    UIMenuItem * item3 = [[[UIMenuItem alloc] initWithTitle:@"Grass" action:@selector(customMenu)] autorelease];
    
    [controller setMenuItems:[NSArray arrayWithObjects:item1, item2, item3, nil]];
    
    [controller setTargetRect:CGRectMake(0,0,320,460) inView:self.view];
    [controller setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan called");
    CGPoint tapPoint = [[touches anyObject] locationInView:self.view];
    
}
*/

- (void)customMenu {
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(customMenu)) {
        return YES;
    }
    return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView {
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
