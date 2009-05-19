//
//  HFBTree.h
//  HexFiend
//
//  Created by Peter Ammon on 2/6/09.
//

#import <Foundation/Foundation.h>

typedef unsigned long long HFBTreeIndex;

@class HFBTreeNode;

#define HFTEST_BTREES 1

@interface HFBTree : NSObject {
    unsigned int depth;
    HFBTreeNode *root;
}

- (void)insertEntry:(id)entry atOffset:(HFBTreeIndex)offset;
- (id)entryContainingOffset:(HFBTreeIndex)offset beginningOffset:(HFBTreeIndex *)outBeginningOffset;
- (void)removeEntryAtOffset:(HFBTreeIndex)offset;
- (void)removeAllEntries;

#if HFTEST_BTREES
- (void)checkIntegrityOfCachedLengths;
- (void)checkIntegrityOfBTreeStructure;
#endif

- (NSEnumerator *)entryEnumerator;
- (NSArray *)allEntries;

- (HFBTreeIndex)length;

/* Applies the given function to the entry at the given offset, continuing with subsequent entries until the function returns NO.  Do not modify the tree from within this function. */
- (void)applyFunction:(BOOL (*)(id entry, HFBTreeIndex offset, void *userInfo))func toEntriesStartingAtOffset:(HFBTreeIndex)offset withUserInfo:(void *)userInfo;

@end

@protocol HFBTreeEntry <NSObject>
- (unsigned long long)length;
@end