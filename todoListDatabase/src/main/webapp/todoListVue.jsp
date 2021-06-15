<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./style.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
  <div class="todo-list-template" id="todoWrap">
    <div class="title">오늘 할 일</div>
    <div class="form-wrapper">
      <div class="form">
        <input type="text" v-model="todoThing" v-on:keyup.13="addTodo"
          class="todoThing">
        <div v-on:click="addTodo" class="create-button">추가</div>
      </div>
    </div>
    <div class="todos-wrapper">
      <div class="todo-item" v-for="todo in todosDone">
        <div class="remove" v-on:click="removeTodo(todo.id)">&times;</div>
        <div class="todo-text checked">
          <div v-on:click="toggleDone(todo.id, todo.isDone)">
          {{ todo.content }}</div>
        </div>
        <div class="check-mark">✓</div>
      </div>
      <div class="todo-item" v-for="todo in todosUnDone">
        <div class="remove" v-on:click="removeTodo(todo.id)">&times;</div>
        <div class="todo-text">
          <div v-on:click="toggleDone(todo.id, todo.isDone)">
          {{ todo.content }}</div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    new Vue({
      el:'#todoWrap',
      data: {
        todos: '',
        todosDone: '',
        todosUnDone: '',
        todoThing: ''
      },
      watch: {
        todoThing: function (val) {
          this.todoThing = val
        }
      },
	  methods: {
        getTodos: function () {
          axios
          .get('list.todo')
          .then(res => {
            this.todos = res.data
            this.todosDone = this.todos.filter(item => item.isDone.includes(true))
            this.todosUnDone = this.todos.filter(item => item.isDone.includes(false))
          })
        },
        addTodo: function () {
          axios.
          post('add.todo', {
            content: this.todoThing
          })
          .then(function () {
            location.reload();
          })
          .catch(function (err) {
            console.log(err)
          })
        },
        toggleDone: function (selectId, selectDone) {
          axios.
          post('isDone.todo', {
            id: selectId,
            isDone: selectDone
          })
          .then(function () {
            location.reload();
          })
          .catch(function (err) {
            console.log(err)
          })
        },
        removeTodo: function (selectId) {
          axios.
          post('remove.todo', {
            id: selectId
          })
          .then(function () {
            location.reload();
          })
          .catch(function (err) {
          	console.log(err)
          })
        }
      },
      created: function() {
        this.getTodos()
      }
    })
  </script>
</body>
</html>