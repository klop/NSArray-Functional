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

- (NSArray *)unique
{
    return [self uniqueFunc];
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

- (NSArray *)uniqueFunc
{
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:self];
    return set.array;
}


@end