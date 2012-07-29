//
//  TUINSView+Private.h
//  TwUI
//
//  Created by Justin Spahr-Summers on 17.07.12.
//
//  Portions of this code were taken from Velvet,
//  which is copyright (c) 2012 Bitswift, Inc.
//  See LICENSE.txt for more information.
//

#import "TUINSView.h"

/*
 * Private functionality of TUINSView that needs to be exposed to other parts of
 * the framework.
 */
@interface TUINSView ()

- (TUIView *)viewForLocalPoint:(NSPoint)p;
- (NSPoint)localPointForLocationInWindow:(NSPoint)locationInWindow;

@end
