/*
 * Copyright (c) 2011, The Iconfactory. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of The Iconfactory nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE ICONFACTORY BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UIProgressView.h"
#import "UIImage.h"
#import "UIBezierPath.h"
#import "UIColor.h"

@implementation UIProgressView
@synthesize progressViewStyle=_progressViewStyle, progress=_progress;

- (id)initWithProgressViewStyle:(UIProgressViewStyle)style
{
	if ((self=[super initWithFrame:CGRectMake(0,0,0,0)])) {
		_progressViewStyle = style;
	}
	return self;
}

- (void)setProgressViewStyle:(UIProgressViewStyle)style
{
	if (style != _progressViewStyle) {
		_progressViewStyle = style;
		[self setNeedsDisplay];
	}
}

- (void)setProgress:(float)p
{
	if (p != _progress) {
		_progress = MIN(1,MAX(0,p));
		[self setNeedsDisplay];
	}
}

- (NSString *)accessibilityLabel
{
	return NSLocalizedStringFromTableInBundle(@"Progress", nil, [NSBundle bundleForClass: [self class]], @"accessibility label");
}

- (NSString *)accessibilityHint
{
	return NSLocalizedStringFromTableInBundle(@"Progress bar", nil, [NSBundle bundleForClass: [self class]], @"accessibility hint");
}

- (NSString *)accessibilityValue
{
	return [NSString stringWithFormat: @"%.02f", _progress];
}

- (void)drawRect:(CGRect)rect
{
	if (CGRectIsEmpty(self.bounds))
		return;
	
	// thanks to Bryan Spitz of Kobo, who wrote our custom one for us. That uses images, such as the #if 0 bit below (we don't have images yet *cough*Iconfactory*cough*)
	CGFloat width = self.bounds.size.width - 4.0;
	CGFloat filledWidth = width * _progress;
	
#if 0
	NSInteger sections = (NSInteger)(width / 2.0);
	NSInteger filledSections = (NSInteger)(filledWidth / 2.0);
	
	UIImage *leftFull = [UIImage imageNamed:@"<UIProgressView> left-full.png"];
	UIImage *leftEmpty = [UIImage imageNamed:@"<UIProgressView> left-empty.png"];
	UIImage *centerFull = [UIImage imageNamed:@"<UIProgressView> center-full.png"];
	UIImage *centerEmpty = [UIImage imageNamed:@"<UIProgressView> center-empty.png"];
	UIImage *rightFull = [UIImage imageNamed:@"<UIProgressView> right-full.png"];
	UIImage *rightEmpty = [UIImage imageNamed:@"<UIProgressView> right-empty.png"];
	
	for (NSInteger i = 0; i < sections; i++) {
		if (i < filledSections) {
			if (i == 0) {
				[leftFull drawAtPoint:CGPointZero];
			} else if (i == sections - 1) {
				[rightFull drawAtPoint:CGPointMake(i*2 + 2, 0.0)];
			} else {
				[centerFull drawAtPoint:CGPointMake(i*2 + 2, 0.0)];
			}
		} else {
			if (i == 0) {
				[leftEmpty drawAtPoint:CGPointZero];
			} else if (i == sections - 1) {
				[rightEmpty drawAtPoint:CGPointMake(i*2 + 2, 0.0)];
			} else {
				[centerEmpty drawAtPoint:CGPointMake(i*2 + 2, 0.0)];
			}
		}
	}
#else
	// since we have no images right now, let's go for the hand-drawn approach
	// I pray this works...
	
	// this should give us a nicely rounded end cap
	CGRect outer = CGRectInset(self.bounds, 1.0, 1.0);
	CGRect inner = CGRectInset(self.bounds, 4.0, 4.0);
	inner.size.width = filledWidth;
	
	UIBezierPath *emptyPath = [UIBezierPath bezierPathWithRoundedRect:outer cornerRadius:outer.size.height * 2.0];
	UIBezierPath * fillPath = [UIBezierPath bezierPathWithRoundedRect:inner cornerRadius:inner.size.height * 2.0];
	
	emptyPath.lineWidth = 2.0;
	[[UIColor blackColor] set];
	
	[emptyPath stroke];
	[emptyPath fill];
	
	fillPath.lineWidth = 0.0;
	
	[[UIColor whiteColor] setFill];
	[fillPath fill];
#endif
}

@end
