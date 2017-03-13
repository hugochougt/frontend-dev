# `this` All Makes Sense Now!

## Call-site (调用点)

Call-site: the location in code where a function is called (**not where it's delcared**).

What is important is to think about the **call-stack** (the stack of functions that have been called to get us to the current moment in execution).

Demo of call-stack and call-site:

``` javascript
function baz() {
  // call-stack is: `baz`
  // so, our call-site is in the global scope

  console.log("baz");
  bar(); // <-- call-site for `bar`
}

function bar() {
  // call-stack is: `baz` -> `bar`
  // so, our call-site is in `baz`

  console.log("bar");
  foo(); // <-- call-site for `foo`
}

function foo() {
  // call-stack is: `baz` -> `bar` -> `foo`
  // so, our call-site is in `bar`

  console.log("foo");
}

baz(); // <-- call-site for `baz`
```

**Note**: Visualizing a call-stack in your mind is painstaking and error-prone. Use a debugger tool in your browser to see the call-stack.

## Nothing But Rules

### Default Binding

### Implicit Binding

### Explicit Binding

### `new` Binding

## Everything In Order

The order to apply the 4 rules above.

**It should be clear that the default binding is the lowest priority rule of the 4.**

Which is more precedent, *implicit binding* or *explicit binding*? Let's test it:

``` javascript
function foo() {
  console.log( this.a );
}

var obj1 = {
  a: 2,
  foo: foo
};

var obj2 = {
  a: 3,
  foo: foo
};

obj1.foo(); //=> 2
obj2.foo(); //=> 3

obj1.foo.call(obj2); //=> 3
obj2.foo.call(obj1); //=> 2
```

So, *explicit binding* takes precedence over *implicit binding*, which means you should ask **first** if explicit binding applie.

### Determining `this`

Now we can summarize the rules for determining `this` from a function call's call-site, in their order of precedence. Ask these questions in this order, and stop when the first rule applies.

1. Is the function called with `new` (**new binding**)? If so, `this` is the newly constructed object.

    `var bar = new foo()`

2. Is the function called with `call` or `apply` (**explicit binding**), even hidden inside a `bind` hard binding?
 If so, `this` is the explicitly specified object.

    `var bar = foo.call(obj)`

3. Is the function called with a context (**implicit binding**), otherwise known as an owing or containing object? If so, `this` is *that* context object.

    `var bar = obj.foo()`

4. Otherwise, default the `this` (**default binding**). If in `strict mode`, pick `undefined`, otherwise pick the `global` object.

    `var bar = foo()`

## Binding Exception

### Ignored `this`

If you pass `null` or `undefined` as a this binding parameter to `call`, `apply`, or `bind`, those values are effectively ignored, and instead the default binding rule applies to the invocation.

## Lexical `this`
