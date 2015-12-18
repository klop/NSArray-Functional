# NSArray+Functional

Higher order functions on `NSArray` with chainable syntax in Objective-C.

```Objective-C

NSArray *array = @[ @(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10) ];

NSNumber *sum = array.map(^NSNumber *(NSNumber *number){

    return @( pow(number.integerValue, 2) );

}).filter(^BOOL (NSNumber *number){

    return number.integerValue <= 25;

}).reduce(^NSNumber *(NSNumber *a, NSNumber *b){

    return @( a.integerValue + b.integerValue );

});

NSLog(@"The sum is: %li!", (long)sum.integerValue); // "The sum is: 55!"
```
## Functions

__Example array__: `NSArray *array = @[ @(1), @(2), @(3), @(3), @(3), @(4), @(4), @(5) ];`

### map
Returns an array containing the results of calling a function on each element of the array.
```Objective-C
array.map(^NSNumber *(NSNumber *number){

        return @( pow(number.integerValue, 2) );

    }); // Returns @[ @(1), @(4), @(9), @(9), @(9), @(16), @(16), @(25) ]
```
### filter
Returns an array of elements that pass a test.
```Objective-C
array.filter(^BOOL (NSNumber *number){

        return number.integerValue < 3;

    }); // Returns @[ @(1), @(2) ]
```
### reduce
Returns a single element that is the result of applying a function of two arguments cumulatively, from `firstObject` to `lastObject`, on the elements of the array.
```Objective-C
array.reduce(^NSNumber *(NSNumber *a, NSNumber *b){

        return @( a.integerValue + b.integerValue );

    }); // Returns @(25)
```
### pluck
Returns an array of property values for a given key path; a common use case of the `map` function.
```Objective-C
array.pluck(@"stringValue"); // Returns @[ @"1", @"2", @"3", @"3", @"3", @"4", @"4", @"5" ]
```
### head
Returns an array containing the first `n` elements of the array.
```Objective-C
array.head(4); // Returns @[ @(1), @(2), @(3), @(3) ]
```
### tail
Returns an array containing the last `n` elements of the array.
```Objective-C
array.tail(2); // Returns @[ @(4), @(5) ]
```
### uniq
Returns an array of unique objects.
```Objective-C
array.uniq; // Returns @[ @(1), @(2), @(3), @(4), @(5) ]
```
### shuf
Returns an randomly sorted array.
```Objective-C
array.shuf; // Returns @[ @(3), @(3), @(1), @(3), @(4), @(5), @(4), @(2) ] (or any other random order)
```
