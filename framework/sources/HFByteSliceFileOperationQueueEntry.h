//
//  HFByteSliceFileOperationQueueEntry.h
//  HexFiend_2
//
//  Copyright 2008 ridiculous_fish. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HFByteSliceFileOperationQueueEntry : NSObject {
	@public
	NSUInteger length;
	unsigned long long offset; //target location
	unsigned char *bytes;
	unsigned long long source; //for debugging
}

@end

@class HFFileReference, HFProgressTracker;

@interface HFByteSliceFileOperationContext : NSObject {
	@public
	NSUInteger softMaxAllocatedMemory;
	NSUInteger totalAllocatedMemory;

	HFFileReference *file; 
	HFProgressTracker *progressTracker;
	NSMutableArray *queue;
}

- (void *)allocateMemoryOfLength:(NSUInteger)len;
- (void)freeMemory:(void *)buff ofLength:(NSUInteger)len;
- (NSUInteger)suggestedAllocationLengthForMinimum:(NSUInteger)minimum maximum:(NSUInteger)maximum;

@end
