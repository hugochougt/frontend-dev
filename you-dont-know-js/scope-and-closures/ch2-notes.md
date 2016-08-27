# Lexical Scope

There are two predominant (主要的) models for how scope works:

1. Lexical Scope (Used by JavaScript)
2. Dynamic Scope (Used by Bash scripting, some modes in Perl, etc.)

## Cheating Lexical

JavaScript has two mechanisms to "modify" (aka, cheat) lexical scope at run-time.

### eval

``` javascript
function foo(str, a) {
    eval(str); // cheating
    console.log(a, b);
}

var b = 2 ;
foo("var b = 3;", 1); //=> 1 3
```

**Note:** `eval(..)` when used in a strict-mode program operates in its own lexical scope, which means declarations made inside of the `eval()` do not actually modify the enclosing scope.

``` javascript
function foo(str) {
    "use strict";
    eval(str);
    console.log(a); //=> ReferenceError: a is not defined
}

foo("var a = 2;");
```

## Performance

**Cheating lexical scope leads to poorer performance.**

Why?

JavaScript Engine 在编译的时候会进行好多优化。但当遇到 `eval(..)` 或者 `with` 的时候，就不会进行编译优化，所以会导致性能问题。
