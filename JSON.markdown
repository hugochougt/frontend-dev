JSON
====

JSON 可以使用以下三中类型值：

 *  **Simple values**: strings, numbers, Booleans, and `null`
 *  **Objects**: key-values pairs
 *  **Arrays**: Includes simple values, objects and other arrays

JSON 字符串与 JavaScript 字符串最大的区别在于，JSON 字符串必须使用双引号（单引号会导致语法错误）。且对象的属性必须加双引号。

## Parsing and Serialization

### The JSON Object

对于新的浏览器，可以使用全局对象 `JSON`。

而对于早期版本的浏览器，可引用 [JSON-js](https://github.com/douglascrockford/JSON-js)

使用 `eval()` 对 JSON 数据求值存在风险，因为可能会执行一些恶意代码。

