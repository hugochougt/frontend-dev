JavaScript Language Basics
==========================

## Syntax

### Case-sensitivity

JavaScript 中的一切（variables，funciton names，operators）都区分大小写。

### Identifiers

标识符命名规则：

 *  第一个字符必须是字母、下划线（_）或者美元符（$）
 *  后面的字符可以是字母、下划线、美元符或者数字

按照惯例，ECMAScript 标识符采用驼峰大小写格式，例如 `firstSecond`、`doSomethingImportant`。

### Comments

ECMAScript 使用 Java 的注释风格，支持单行注释和块注释：

```javascript

// single line comment

/*
 * This is a
 * multi-line commnet
 */

```

## Data Types

ECMAScript 有 5 种简单数据类型：`Undefined`、`Null`、`Boolean`、`Number`、`String`，1 种复杂数据类型：`Object`，Object 本质上是由一组无序的名值对组成。

## Functions

ECMAScript 中的函数使用 `function` 关键字来声明，后跟一组参数以及函数体。基本语法示例：

```javascript

function functionName(arg0, arg1,...,argN) {
  statements
}

function sayHello(name, message) {
  alert("Hi " + name + ", " + message);
}

```

ECMAScript 没有函数签名的概念，所以函数不能像传统意义上那样重载。如果在 ECMAScript 中定义两个名字相同的函数，则该名字只属于后定义的函数。

