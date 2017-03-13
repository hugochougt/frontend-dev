(function() {
  // load base.js before using TodoItemCollection and TodoView
  window.addEventListener('load', windowLoadHandler, false);
  function windowLoadHandler() {
    var todoItemCollection = new TodoItemCollection();
    var view = new TodoView(todoItemCollection);
  }
}());
