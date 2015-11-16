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
    mapBlock wrapper = objc_getAssociatedObject(self, @selector(map));
    if (wrapper) return wrapper;

    wrapper = ^NSArray *(mapFuncBlock block) {
        return [self mapFunc:block];
    };

    objc_setAssociatedObject(self, @selector(map), wrapper, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return wrapper;
}

- (filterBlock)filter
{
    filterBlock wrapper = objc_getAssociatedObject(self, @selector(filter));
    if (wrapper) return wrapper;

    wrapper = ^NSArray *(filterFuncBlock block) {
        return [self filterFunc:block];
    };

    objc_setAssociatedObject(self, @selector(filter), wrapper, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return wrapper;
}

- (reduceBlock)reduce
{
    reduceBlock wrapper = objc_getAssociatedObject(self, @selector(reduce));
    if (wrapper) return wrapper;

    wrapper = ^id (reduceFuncBlock block) {
        return [self reduceFunc:block];
    };

    objc_setAssociatedObject(self, @selector(reduce), wrapper, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return wrapper;
}

#pragma mark - Higher-order functions

- (NSArray *)mapFunc:(mapFuncBlock)block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id object in self) {
        id mapped = block(object);
        if (mapped) [array addObject:mapped];
    }
    return [array copy];
}

- (NSArray *)filterFunc:(filterFuncBlock)block
{
    NSMutableArray *array = [NSMutableArray new];
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


@end