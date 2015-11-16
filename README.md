# NSArray-Functional

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
