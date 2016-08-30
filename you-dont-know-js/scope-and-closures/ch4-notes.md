# Hoisting

## Chicken Or The Egg?

``` javascript
a = 2;
var a;
console.log(2) //=> 2

//////////////////////

console.log(a);
var a = 2; //=> undefined
```

**So, what's going on here?** Which comes first, the declaration ("egg"), or the assignment ("chicken")?

The best way to think about things is that all declarations, both variables and functions, are processed first, before any part of your code is executed.

The second snippet is actually processed as:

``` javascript
var a; // processed during the compilation phase
```

``` javascript
console.log(a);
a = 2; // left in place for the execution phase
```

So, one way of thinking, sort of metaphorically, about this process, is that variable and function declarations are "moved" from where they appear in the flow of the code to the top of the code. **This gives rise to the name "Hoisting".**

In other words, **the egg (declaration) comes before the chicken (assignment).**

Note: Only the declarations themselves are hoisted, while any assignments or other executable logic are left in place.

``` javascript
foo();

function foo() {
    console.log(a);
    var a = 2;
}

// Code above can perhaps be more accurately interpreted like this:

function foo() { //<= hoisted
    var a; // <= hoisted
    console.log(a); //=> undefined
    a = 2;
}

foo();
```

Function declarations are hoisted. But function expressions are not.

``` javascript
foo(); // not ReferenceError, but TypeError!
var foo = function bar() {
    // ...
};

/////////////////////////
foo(); // TypeError
bar(); // ReferenceError
var foo = function bar() {
    // ...
}
```

### Functions First

Both function declarations and variable declarations are hoisted. But a subtle detail is that functions are hoisted first, and then variables.

``` javascript
foo(); //=> 1

var foo;

function foo() {
    console.log(1);
}

foo = function() {
    console.log(2);
}
```
