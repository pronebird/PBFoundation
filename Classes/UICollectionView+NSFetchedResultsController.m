//
//  UICollectionView+NSFetchedResultsController.m
//
//  A simple category on UICollectionView to perform content changes in UITableView fashion.
//  Comes handy with NSFetchedResultsController.
//
//  Created by pronebird on 20/04/14.
//  Copyright (c) 2014 pronebird. All rights reserved.
//

#import "UICollectionView+NSFetchedResultsController.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

static const void* kHasBegunUpdatesKey = &kHasBegunUpdatesKey;
static const void* kBatchUpdateBlocksKey = &kBatchUpdateBlocksKey;

@implementation UICollectionView (NSFetchedResultsController)

- (NSMutableArray*)pb_batchUpdateBlocks {
	NSMutableArray* blocks = objc_getAssociatedObject(self, kBatchUpdateBlocksKey);
	
	if(blocks == nil) {
		blocks = [NSMutableArray new];
		objc_setAssociatedObject(self, kBatchUpdateBlocksKey, blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
	return blocks;
}

- (void)pb_addBatchUpdateBlock:(void(^)(void))block {
	[[self pb_batchUpdateBlocks] addObject:[block copy]];
}

- (void)pb_removeAllBatchUpdateBlocks {
	[[self pb_batchUpdateBlocks] removeAllObjects];
}

- (void)pb_setBeginUpdates:(BOOL)flag {
	objc_setAssociatedObject(self, kHasBegunUpdatesKey, @(flag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pb_hasBegunUpdates {
	NSNumber* flag = objc_getAssociatedObject(self, kHasBegunUpdatesKey);
	
	return [flag boolValue];
}

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self swizzleMethod:@selector(insertSections:) withMethod:@selector(pb_insertSections:)];
		[self swizzleMethod:@selector(deleteSections:) withMethod:@selector(pb_deleteSections:)];
		[self swizzleMethod:@selector(reloadSections:) withMethod:@selector(pb_reloadSections:)];
		[self swizzleMethod:@selector(moveSection:toSection:) withMethod:@selector(pb_moveSection:toSection:)];
		[self swizzleMethod:@selector(insertItemsAtIndexPaths:) withMethod:@selector(pb_insertItemsAtIndexPaths:)];
		[self swizzleMethod:@selector(deleteItemsAtIndexPaths:) withMethod:@selector(pb_deleteItemsAtIndexPaths:)];
		[self swizzleMethod:@selector(reloadItemsAtIndexPaths:) withMethod:@selector(pb_reloadItemsAtIndexPaths:)];
		[self swizzleMethod:@selector(moveItemAtIndexPath:toIndexPath:) withMethod:@selector(pb_moveItemAtIndexPath:toIndexPath:)];
	});
}

- (void)pb_insertSections:(NSIndexSet *)sections {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_insertSections:sections];
		}];
		return;
	}
	
	[self pb_insertSections:sections];
}

- (void)pb_deleteSections:(NSIndexSet *)sections {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_deleteSections:sections];
		}];
		return;
	}
	
	[self pb_deleteSections:sections];
}

- (void)pb_reloadSections:(NSIndexSet *)sections {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_reloadSections:sections];
		}];
		return;
	}
	
	[self pb_reloadSections:sections];
}

- (void)pb_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_moveSection:section toSection:newSection];
		}];
		return;
	}
	
	[self pb_moveSection:section toSection:newSection];
}

- (void)pb_insertItemsAtIndexPaths:(NSArray *)indexPaths {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_insertItemsAtIndexPaths:indexPaths];
		}];
		return;
	}
	
	[self pb_insertItemsAtIndexPaths:indexPaths];
}

- (void)pb_deleteItemsAtIndexPaths:(NSArray *)indexPaths {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_deleteItemsAtIndexPaths:indexPaths];
		}];
		return;
	}
	
	[self pb_deleteItemsAtIndexPaths:indexPaths];
}

- (void)pb_reloadItemsAtIndexPaths:(NSArray *)indexPaths {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_reloadItemsAtIndexPaths:indexPaths];
		}];
		return;
	}
	
	[self pb_reloadItemsAtIndexPaths:indexPaths];
}

- (void)pb_moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
	if([self pb_hasBegunUpdates]) {
		[self pb_addBatchUpdateBlock:^{
			[self pb_moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
		}];
		return;
	}
	
	[self pb_moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (void)beginUpdates {
	[self pb_removeAllBatchUpdateBlocks];
	[self pb_setBeginUpdates:YES];
}

- (void)endUpdatesWithCompletion:(void(^)(BOOL finished))completion {
	NSArray* blocks = [self pb_batchUpdateBlocks];
	
	// A workaround for a weird bug when UICollectionView is not on screen
	if(self.window)
	{
		[self performBatchUpdates:^{
			for(void(^block)(void) in blocks) {
				block();
			}
		} completion:completion];
	}
	else
	{
		[self reloadData];
		
		if(completion) {
			completion(YES);
		}
	}
	
	[self pb_removeAllBatchUpdateBlocks];
	[self pb_setBeginUpdates:NO];
}

@end
