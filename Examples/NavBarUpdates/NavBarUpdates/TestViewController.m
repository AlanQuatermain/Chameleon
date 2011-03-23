//
//  TestViewController.m
//  NavBarUpdates
//
//  Created by Jim Dovey on 11-03-22.
//  Copyright 2011 Jim Dovey. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

- (void) dealloc
{
	[_progress release];
	[super dealloc];
}

- (void) viewDidLoad
{
	UINSCellControl * checkbox = [UINSCellControl checkboxWithFrame: CGRectMake(20.0, 20.0, 140.0, 40.0)];
	checkbox.title = @"I'm unchecked";
	checkbox.selected = NO;
	[checkbox addTarget: self action: @selector(toggledCheckbox:) forControlEvents: UIControlEventValueChanged];
	
	[self.view addSubview: checkbox];
	
	_progress = [[UIProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
	_progress.frame = CGRectMake(20.0, 60.0, 100.0, 24.0);
	_progress.progress = 0.0;
	
	[self.view addSubview: _progress];
}

- (void) viewDidUnload
{
	[_progress release]; _progress = nil;
}

- (void) viewDidAppear: (BOOL) animated
{
	[self.navigationItem performSelector: @selector(setTitle:) withObject: @"New Title" afterDelay: 5.0];
	[NSTimer scheduledTimerWithTimeInterval: 0.05 target: self selector: @selector(updateProgress:) userInfo: nil repeats: YES];
}

- (void) toggledCheckbox: (UINSCellControl *) checkbox
{
	if ( checkbox.selected )
		checkbox.title = @"I'm checked!";
	else
		checkbox.title = @"I'm unchecked";
}

- (void) updateProgress: (NSTimer *) timer
{
	_progress.progress = MIN(_progress.progress + 0.01, 1.0);
	if ( _progress.progress == 1.0 )
		[timer invalidate];
}

@end
