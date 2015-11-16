//
//  NSArray+Functional.h
//  Functional Objective C
//
//  Created by Dara on 16/11/2015.
//  Copyright © 2015 Dara. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^mapFuncBlock)(id object);
typedef BOOL (^filterFuncBlock)(id object);
typedef id (^reduceFuncBlock)(id reducedObject, id object);

typedef NSArray *(^mapBlock)(mapFuncBlock block);
typedef NSArray *(^filterBlock)(filterFuncBlock block);
typedef id (^reduceBlock)(reduceFuncBlock block);

@interface NSArray (Functional)

@property (nonatomic, copy, readonly) mapBlock map;
@property (nonatomic, copy, readonly) filterBlock filter;
@property (nonatomic, copy, readonly) reduceBlock reduce;

@end
