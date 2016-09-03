## Appandix A: Dynamic Scope

JavaScript **does not, in fact, have dynamic scope**. It has lexical scope. Plain and simple. But the `this` mechanism is kind of like dynamic scope.

The key contrast: **lexical scope is write-time, whereas dynamic scope (and `this`!) are runtime.** Lexical scope cares where a function was declared, but dynamic scope cares where a function was called from.

Finally: `this` cares how a function was called, which shows how closely related the `this` mechanism is to the idea of dynamic scoping.

## Appandix B: Polyfilling Block Scope

A polyfill for block scope in pre-ES6 environments:

``` javascript
try {
    throw 2
} catch(a) {
    console.log(a); // 2
}

console.log(a); // Uncaught ReferenceError: a is not defined
```

### Perfromance

Why not just use an IIFE to create the scope?

Firstly, the performance of `try/catch` is slower, but there's no reasonable assumption that it has to be that way, or even that it always be that way.

Secondly, IIFE is not a fair apples-to-apples comparison with `try/catch`, because a function wrapped around any arbitrary code changes the meaning, inside of that code, of `this`, `return`, `break`, and `continue`.

The question really becomes: do you want block-scoping, or not. If you do, these tools provide you that option. If not, keep using `var` and go on about your coding!

## Appendix C: Lexical-this

``` javascript
var obj = {
    id: "awesome",
    cool: function coolFn() {
        console.log(this.id);
    }
};

var id = "not awesome";
obj.cool(); //=> awesome
setTimeout(obj.cool, 100); //=> not awesome
```

The problem is the loss of `this` binding on the `cool()` function.

There are various ways to address that problem, but one often-repeated solution is `var self = this;`.

``` javascript
var obj = {
    count: 0,
    cool: function coolFn() {
        var self = this;

        if (self.count < 1) {
            setTimeout(function timer() {
                self.count++;
                console.log("awesome?");
            }, 100);
        }
    }
};

obj.cool(); //=> awesome?
```

The ES6 solution, the arrow-function, introduces a behavior called "lexical this".

``` javascript
var obj = {
    count: 0,
    cool: function coolFn() {
        if (this.count < 1) {
            setTimeout(() => { //<= arrow-function wtf?
                this.count++;
                console.log("awesome?");
            }, 100)
        }
    }
};

obj.cool(); //=> awesome?
```

The short explanation it that arrow-function do not behave at all like normal functions when it comes ot their `this` binding.

A more appropriate approach to this "problem", is to use and embrace the `this` mechanism correctly.

``` javascript
var obj = {
    count: 0,
    cool: function coolfn() {
          setTimeout(function timer() {
              this.count++; // `this` si safe because of `bind(..)`
              console.log("more awesome");
          }.bind(this), 100); // look, `bind()`!
    }
};

obj.cool(); //=> more awesome
```

Whether you prefer the new lexical-this behavior of arrow-functions, or you prefer the tried-and-true `bind()`, it's important to note that arrow-functions are **not** just about less typing of "function".
