# Scope Closure

**Closure is all around you in JavaScript, you just have to recognize and embrace it.**

The enlightenment moment should be: **oh, closures are already occuring all over my code, I can finally see them now.**

## Nitty Gritty (细节)

A down-n-dirty definition of what you need to know to understand and recognize closures:

> Closure is when a function is able to remember and access its lexical scope even when that function is executing outside its lexical scope.

``` javascript
function foo() {
    var a = 2;

    function bar() {
        console.log(a);
    }

    return bar;
} // 返回函数的函数

var baz = foo();

baz(); //=> 2 -- Whoa, closure was just observed, man.
```

**`bar()` still has a reference to the inner scope of `foo()`, and that reference is called closure.**

Any of the various ways that functions can be passed around as values, and indeed invoked in other locations, are all examples of observing/exercising closure.

``` javascript
function foo() {
    var a = 2;

    function baz() {
        console.log(a);
    }

    bar(baz);
}

function bar(fn) {
    fn(); // look ma, I saw closure!
}
```

The passings-around of functions can be indirect, too.

``` javascript
var fn;

function foo() {
    var a = 2;

    function baz() {
        console.log(a);
    }

    fn = baz; // assign `baz` to global variable
}

function bar() {
    fn(); // CLOSURE!
}

foo();

bar(); //=> 2
```

## Now I Can See

Essentially whenever and wherever you treat functions (which access their own respective lexical scopes) as first-class values and pass them around, you are likely to see those functions exercising closure.

## Loops + Closure

``` javascript
for (var i = 1; i <= 5; i++) {
    setTimeout(function timer() {
        console.log(i);
    }, i * 1000);
}

// We would normally *expect* for the behavior to be that the numbers "1", "2", .. "5" would be printed out.
// In fact, if you run this code, you get "6" printed out 5 times.
```

What's missing is that we are trying to imply that each iteration of the loop "captures" its own copy of `i`, at the time of the iteration. But, the way scope works, all 5 of those functions, though they are defined separately in each loop iteration, all **are closed over the same shared global scope**, which has, in fact, only one `i` in it.

正确的写法：

``` javascript
for (var i = 1; i <= 5; i++) {
    (function(j) {
        setTimeout(function timer() {
            console.log(j);
        }, j * 1000);
    })(i);
}
```

一个使用 `let` 的解法：

``` javascript
for (let i = 1; i <= 5; i++) {
    setTimeout(function timer() {
        console.log(i);
    }, i * 1000);
}
```

## Modules

``` javascript
function CoolModule() {
    var something = "cool";
    var another = [1, 2, 3];

    function doSomething() {
        console.log(something);
    }

    function doAnother() {
        console.log(another.join(" ! "));
    }

    return {
        doSomething: doSomething,
        doAnother: doAnother
    };
}

var foo = CoolModule();

foo.doSomething(); //=> coll
foo.doAnother(); //=> 1 ! 2 ! 3
```

This is the patern in JavaScript we call *module*. The most common way of implementing the module pattern is often called "Revealing Module", and it's the variation we present here.

**Note**: It is not required that we return an actual object (literal) from our module. We could just return back an inner function directly.

There are two "retuirements" for the module pattern to be exercised:

1. There must be an outer enclosing function, and it must be invoked at least once (each time creates a new module instance).
2. The enclosing function must return back at least one inner function, so that this inner function has closure over the private scope, and can access and/or modify that private state.

A slight variation on this pattern is when you only care to have one instance, a "singleton" of sorts:

``` javascript
var foo = (function CoolModule() {
    var something = "cool";
    var another = [1, 2, 3];

    function doSomething() {
        console.log( something );
    }

    function doAnother() {
        console.log( another.join( " ! " ) );
    }

    return {
        doSomething: doSomething,
        doAnother: doAnother
    };
})();

foo.doSomething(); // cool
foo.doAnother(); // 1 ! 2 ! 3
```

Modules are just functions, so they can receive parameters. Another slight but powerful variation on the module pattern is to name the object you are returning as your public API:

``` javascript
var foo = (function CoolModule(id) {
    function change() {
        // modifying the public API
        publicAPI.identify = identify2;
    }

    function identify1() {
        console.log(id);
    }

    function identify2() {
        console.log(id.toUpperCase());
    }

    var publicAPI = {
        change: change,
        identify: identify1
    };

    return publicAPI;
})("foo module");


foo.identify(); // foo module
foo.change();
foo.identify(); // FOO MODULE
```

By retaining an inner reference to the public API object inside your module instance, you can modify that module instance **from the inside**, including adding and removing methods, properties, and changing their values.

### Modern Modules

A very simple proof of concept **for illustration purposes (only)**:

``` javascript
var MyModules = (function Manager() {
    var modules = {};

    function define(name, deps, impl) {
        for (var i = 0; i < deps.length; i++) {
            deps[i] = modules[deps[i]];
        }
        modules[name] = impl.apply(impl, deps); // the key part of this code
        // This is invoking the definition wrapper function for a module (passing in any dependencies),
        // and storing the return value, the module's API, into an internal list of modules tracked by name.
    }

    function get(name) {
        return modules[name];
    }

    return {
        define: define,
        get: get
    };
})();
```

Here's how I might use it to define some modules:

``` javascript
MyModules.define("bar", [], function() {
    function hello(who) {
        return "Let me introduce: " + who;
    }

    return {
        hello: hello
    };
});

MyModules.define("foo", ["bar"], function(bar) {
    var hungry = "hippo";

    function awesome() {
        console.log(bar.hello(hungry).toUpperCase());
    }

    return {
        awesome: awesome
    }
});

var bar = MyModules.get("bar");
var foo = MyModules.get("foo");

console.log(bar.hello("hippo")); //=> Let me introduce: hippo

foo.awesome(); //=> LET ME INTRODUCE: HIPPO
```

The key take-away is that there's not really any particular "magic" to module managers. They fulfill both characteristics of the module patter I listed above: invoking a function definition wrapper, and keeping its return value as the API for that module.
