//
//  NSArray+Functional.m
//  Functional Objective C
//
//  Created by Dara on 16/11/2015.
//  Copyright © 2015 Dara. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

- (NSArray *)map:(mapBlock)block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id object in self) {
        id mapped = block(object);
        if (mapped) [array addObject:mapped];
    }
    return [array copy];
}

- (NSArray *)filter:(filterBlock)block
{
    NSMutableArray *array = [NSMutableArray new];
    for (id object in self) {
        if (block(object)) {
            [array addObject:object];
        }
    }
    return [array copy];
}

- (id)reduce:(reduceBlock)block
{
    NSMutableArray *array = [self mutableCopy];
    id reduced = array.firstObject;
    [array removeObject:array.firstObject];
    for (id object in self) {
        reduced = block(reduced, object);
    }
    return reduced;
}


@end