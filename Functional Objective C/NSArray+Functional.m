//
//  NSArray+Functional.m
//  Functional Objective C
//
//  Created by Dara on 16/11/2015.
//  Copyright © 2015 Dara. All rights reserved.
//

#import "NSArray+Functional.h"
#import <objc/objc-runtime.h>

@implementation NSArray (Functional)

#pragma mark - Property getters

- (mapBlock)map
{
    mapBlock wrapper = ^NSArray *(mapFuncBlock block) {
        return [self mapFunc:block];
    };
    return wrapper;
}

- (filterBlock)filter
{
    filterBlock wrapper = ^NSArray *(filterFuncBlock block) {
        return [self filterFunc:block];
    };
    return wrapper;
}

- (reduceBlock)reduce
{
    reduceBlock wrapper = ^id (reduceFuncBlock block) {
        return [self reduceFunc:block];
    };
    return wrapper;
}

- (pluckBlock)pluck
{
    pluckBlock pluck = ^NSArray *(NSString *keyPath) {
        return [self pluckFunc:keyPath];
    };
    return pluck;
}

- (headBlock)head
{
    headBlock head = ^NSArray *(NSUInteger sample) {
        return [self headFunc:sample];
    };
    return head;
}

- (tailBlock)tail
{
    tailBlock tail = ^NSArray *(NSUInteger sample) {
        return [self tailFunc:sample];
    };
    return tail;
}

- (NSArray *)uniq
{
    return [self uniqFunc];
}

- (NSArray *)shuf
{
    return [self shufFunc];
}

#pragma mark - Higher-order functions

- (NSArray *)mapFunc:(mapFuncBlock)block
{
    NSMutableArray *array = [NSMutableArray array];
    for (id object in self) {
        id mapped = block(object);
        if (mapped) [array addObject:mapped];
    }
    return [array copy];
}

- (NSArray *)filterFunc:(filterFuncBlock)block
{
    NSMutableArray *array = [NSMutableArray array];
    for (id object in self) {
        if (block(object)) {
            [array addObject:object];
        }
    }
    return [array copy];
}

- (id)reduceFunc:(reduceFuncBlock)block
{
    NSMutableArray *array = [self mutableCopy];
    id reduced = array.firstObject;
    [array removeObject:array.firstObject];
    for (id object in array) {
        reduced = block(reduced, object);
    }
    return reduced;
}

- (NSArray *)pluckFunc:(NSString *)keyPath
{
    NSMutableArray *array = [NSMutableArray array];
    for (id object in self) {
        [array addObject:[object valueForKeyPath:keyPath]];
    }
    return [array copy];
}

- (NSArray *)headFunc:(NSUInteger)sample
{
    NSRange range = NSMakeRange(0, MIN(self.count, sample));
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    return [self objectsAtIndexes:indexSet];
}

- (NSArray *)tailFunc:(NSUInteger)sample
{
    NSUInteger capped = MIN(self.count, sample);
    NSRange range = NSMakeRange(self.count - capped, self.count - 1);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    return [self objectsAtIndexes:indexSet];
}

- (NSArray *)uniqFunc
{
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:self];
    return set.array;
}

- (NSArray *)shufFunc
{
    NSMutableArray *array = [self mutableCopy];
    NSUInteger count = array.count;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [array copy];
}

@end