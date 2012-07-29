/*
 Copyright 2011 Twitter, Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this work except in compliance with the License.
 You may obtain a copy of the License in the LICENSE file, or at:
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ExampleScrollView.h"

@interface ExampleScrollView ()
@property (nonatomic, strong, readonly) TUIScrollView *scrollView;
@property (nonatomic, strong, readonly) TUIViewNSViewContainer *textFieldContainer;
@end

@implementation ExampleScrollView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self == nil) return nil;

	self.backgroundColor = [NSColor colorWithCalibratedWhite:0.9 alpha:1.0];
	
	_scrollView = [[TUIScrollView alloc] initWithFrame:self.bounds];
	_scrollView.autoresizingMask = TUIViewAutoresizingFlexibleSize;
	_scrollView.scrollIndicatorStyle = TUIScrollViewIndicatorStyleDark;
	[self addSubview:_scrollView];
	
	TUIImageView *imageView = [[TUIImageView alloc] initWithImage:[NSImage imageNamed:@"large-image.jpeg"]];
	[self.scrollView addSubview:imageView];
	[self.scrollView setContentSize:imageView.frame.size];

	NSTextField *textField = [[NSTextField alloc] initWithFrame:CGRectMake(200, 200, 100, 22)];
	textField.target = self;
	textField.action = @selector(rotateTextField:);
	textField.backgroundColor = [NSColor whiteColor];
	textField.drawsBackground = YES;
	[textField.cell setUsesSingleLineMode:YES];
	[textField.cell setScrollable:YES];

	_textFieldContainer = [[TUIViewNSViewContainer alloc] initWithNSView:textField];
	textField.frame = textField.bounds;
	[self.scrollView addSubview:_textFieldContainer];

	return self;
}

- (void)rotateTextField:(id)sender {
	[TUIView animateWithDuration:2 animations:^{
		self.textFieldContainer.transform = CGAffineTransformMakeRotation(M_PI);
	} completion:^(BOOL finished){
		[TUIView animateWithDuration:2 animations:^{
			self.textFieldContainer.transform = CGAffineTransformIdentity;
		}];
	}];

	// TODO: Applying animations directly to the layer hierarchy currently does
	// not work.
	#if 0
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	animation.duration = 5;
	animation.values = @[
		[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)],
		[NSValue valueWithCATransform3D:CATransform3DMakeRotation(2 * M_PI, 0, 0, 1)]
	];

	[self.textFieldContainer.layer addAnimation:animation forKey:@"transform"];
	#endif
}

@end
