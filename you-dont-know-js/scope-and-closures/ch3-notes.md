# Function vs. Block Scope

JavaScript 在什么情况下会创建新的作用域？

## Scope From Functions

The most common answer to those questions is that JavaScript has function-based scope.

## Hiding In Plain Scope

Why would "hiding" variables and functions be a useful technique?

"Principle of Least Privilege", alse sometimes called "Least Authority" or "Least Exposere".

``` javascript
// Bad

function doSomething(a) {
    b = a + doSomethingElse(a * 2);
    console.log(b * 3);
}

function doSomethingElse(a) {
    return a - 1;
}

var b;
doSomething(2); //=> 15

// Good
// Because the `b` variable and the `doSomethingElse(..)` function are likely "private" details of how `doSomething(..)` does its job.

function doSomething(a) {
    function doSomethingElse(a) {
        return a - 1;
    }

    var b;
    b = a + doSomethingElse(a * 2);

    console.log(b * 3);
}

doSomething(2); //=> 15
```

## Functions As Scopes

```
var a = 2;

(function foo() {
    var a = 3;
    console.log(a); //=> 3
})(); // IIFE: Immediately Invoked Function Expression

console.log(a); //=> 2
```

Instead of treating the funciton as a standard declaration, the function is treated as a function-expression.

区分函数声明和函数表达式的简单方法：If "function" is the very first thing in the statement, then it's a function declaration. Otherwise, it's a function expression.

The key difference we can observe here between a function declaration and a function expression relates to where its name is bound as an identifier.

### Anonymous vs. Named

Different style of IIFE:

1. `(function foo(){ ... })()`
2. `(function (){ ... }())`

Look closely to see the difference. In the first form, the function expression is wrapped in `()`, and then the invoking `()` pair is on the outside right after it. In the second form, the invoking `()` pair is moved to the inside of the outer `()` wrapping pair.

These two forms are identical in functionality. **It's purely a stylistic choice which you prefer.**

## Blocks As Scopes

Declaring variables as close as possible, as local as possible, to where they will be used.

### `try/catch`

It's a very little known fact that JavaScript in ES3 specified the variable declaration in the `catch` clause of a `try/catch` to be block-scoped to the `catch` block.

``` javascript
try {
    undefined();
}
catch (err) {
    console.log(err); // works!
}

console.log(err); // ReferenceError: err is not definded
```

### Garbage Collection

``` javascript
function process(data) {
    // do sth interesting
}

// Bad:
// It's quite likely that the JS engine will still have to keep the structure around,
// since the `click` function has a closure over the entire scope.
var someReallyBigData = { .. };
process(somereallybigdata);

// Good:
// Anything declared inside this block can go away after!
{
  let someReallybigdata = { .. };
  process(somereallybigdata);
}

btn.addEventListener( "click", function click(evt){
    console.log("button clicked");
}, /*capturingPhase=*/false );
```

Declaring explicit blocks for variables to locally bind to is a powerful tool that you can add to your code toolbox.
