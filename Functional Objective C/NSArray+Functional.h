//
//  NSArray+Functional.h
//  Functional Objective C
//
//  Created by Dara on 16/11/2015.
//  Copyright © 2015 Dara. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^mapBlock)(id object);
typedef BOOL (^filterBlock)(id object);
typedef id (^reduceBlock)(id reducedObject, id object);

@interface NSArray (Functional)

- (NSArray *)map:(mapBlock)block;
- (NSArray *)filter:(filterBlock)block;
- (id)reduce:(reduceBlock)block;

@end
