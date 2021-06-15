package com.todo;

import org.json.simple.JSONArray;

public interface TodoRepository {

    JSONArray getTodoList() throws Exception;

    void addTodo(String content) throws Exception;

    void chagneDone(String id, String isDone) throws Exception;

    void removeTodo(String id) throws Exception;

}
