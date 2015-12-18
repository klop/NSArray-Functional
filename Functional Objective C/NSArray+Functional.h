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
typedef NSArray *(^pluckBlock)(NSString *keyPath);
typedef NSArray *(^headBlock)(NSUInteger sample);
typedef NSArray *(^tailBlock)(NSUInteger sample);

@interface NSArray (Functional)

@property (nonatomic, copy, readonly) mapBlock map;
@property (nonatomic, copy, readonly) filterBlock filter;
@property (nonatomic, copy, readonly) reduceBlock reduce;
@property (nonatomic, copy, readonly) pluckBlock pluck;
@property (nonatomic, copy, readonly) headBlock head;
@property (nonatomic, copy, readonly) tailBlock tail;
@property (nonatomic, copy, readonly) NSArray *uniq;
@property (nonatomic, copy, readonly) NSArray *shuf;

@end
