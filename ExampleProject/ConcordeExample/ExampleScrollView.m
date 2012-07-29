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
@property (nonatomic, strong, readonly) NSTextField *textField;
@end

@implementation ExampleScrollView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self == nil) return nil;

	self.wantsLayer = YES;
	self.layer.backgroundColor = [NSColor colorWithCalibratedWhite:0.9 alpha:1.0].tui_CGColor;
	
	_scrollView = [[TUIScrollView alloc] initWithFrame:self.bounds];
	_scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	_scrollView.scrollIndicatorStyle = TUIScrollViewIndicatorStyleDark;
	[self addSubview:_scrollView];
	
	NSImage *image = [NSImage imageNamed:@"large-image.jpeg"];
	self.scrollView.contentSize = image.size;

	NSImageView *imageView = [[NSImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	imageView.image = image;
	[self.scrollView addSubview:imageView];

	_textField = [[NSTextField alloc] initWithFrame:CGRectMake(200, 200, 100, 22)];
	_textField.wantsLayer = YES;
	_textField.target = self;
	_textField.action = @selector(rotateTextField:);
	_textField.backgroundColor = [NSColor whiteColor];
	_textField.drawsBackground = YES;
	[_textField.cell setUsesSingleLineMode:YES];
	[_textField.cell setScrollable:YES];

	[self.scrollView addSubview:self.textField];
	return self;
}

- (void)rotateTextField:(id)sender {
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	animation.duration = 5;
	animation.values = @[
		[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)],
		[NSValue valueWithCATransform3D:CATransform3DMakeRotation(2 * M_PI, 0, 0, 1)]
	];

	[self.textField.layer addAnimation:animation forKey:@"transform"];
}

@end
