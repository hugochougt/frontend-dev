# What is Scope?

这章主要回答两个问题：

1. Where are those variables stored?
2. How does our program find them when it needs them?

## Compiler Theory

JavaScript is in fact a compiled language.

编译源码的过程大致上分三步：

1. Tokening/Lexing: beaking up a string of characters into meaningful (to the language) chunks, called tokens.
2. Parsing: taking a stream (array) of tokens and turning it into a tree of nested elementes, which collectively represent the grammatical structure of the program.
3. Code-Generation: the process of taking an AST and turning it into executable code.

## Understanding Scope

### The Cast

1. Engine: responsible for start-to-finish compilation and execution of our JavaScript program.
2. Compiler: handles all the dirty work of parsing and code-generation.
3. Scope: collects and maintains a look-up list of all the declared identifiers (variables), and enforces a strict set of rules as to how these are accessible to currently executing code.

解释、执行 `var a = 2;` 这条语句的过程：first, Compiler declares a variable (if not previously declared in the current scope), and second, when executing, Engine looks up the variable in Scope and ssings to it, if found.

变量查询（look-up）的两种类型：

1. "LHS" (Left-hand Side): LHS look-up is tring to find the variable container itself.
2. "RHS" (Right-hand Side, more accurately, not left-hand side): RHS look-up means retrieve his/her source (value).

## Nested Scope

Scope 是可以嵌套的。

If a variable cannot be found in the immediate scope, Engine consults the next outer containing scope, continuing until found or until the outermost (aka, global) scope has been reached.

例子：

``` javascript
function foo(a) {
  console.log( a + b);
}

var b = 2;
foo(2); //=> 4
```
