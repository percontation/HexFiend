//
//  HFTextSelectionPulseView.m
//  HexFiend_2
//
//  Copyright 2008 ridiculous_fish. All rights reserved.
//

#import <HexFiend/HFTextSelectionPulseView.h>


@implementation HFTextSelectionPulseView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    USE(rect);
    CGContextSetInterpolationQuality([[NSGraphicsContext currentContext] graphicsPort], kCGInterpolationHigh);
    [image drawInRect:[self bounds] fromRect:NSZeroRect operation:NSCompositeCopy fraction:(CGFloat)1.];
}

- (void)setImage:(NSImage *)val {
    image = val;
    [self setNeedsDisplay:YES];
}

@end
