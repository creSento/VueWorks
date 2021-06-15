package com.todo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import org.json.simple.JSONArray;

public class TodoDbRepository implements TodoRepository {
    
    private static TodoDbRepository instance;
    public static TodoDbRepository getInstance() {
        if (instance == null) {
            instance = new TodoDbRepository();
        }
        return instance;
    }
    private TodoDbRepository() {
    }
    
    private Connection connect() throws Exception {
        Class.forName(Const.DRIVER);
        Connection conn = DriverManager.getConnection(Const.DB_URL, Const.USER, Const.PASSWD);
        return conn;
    }

    private void disConnect(Connection conn) throws SQLException {
        conn.close();
    }

    @Override
    public JSONArray getTodoList() throws Exception {
        Connection conn = connect();
        Statement stmt = conn.createStatement();
        ResultSet todos = stmt.executeQuery("select * from todos order by id desc");
        JSONArray todosJsonArray = new JSONArray();
        while (todos.next()) {
            HashMap<String, String> temp = new HashMap<String, String>();
            temp.put("id", String.valueOf(todos.getInt(1)));
            temp.put("content", todos.getString(2));
            temp.put("isDone", String.valueOf(todos.getBoolean(3)));
            todosJsonArray.add(temp);
        }
        disConnect(conn);
        return todosJsonArray;
    }

    @Override
    public void addTodo(String content) throws Exception {
        Connection conn = connect();
        String sql = "insert into todos (content) values (?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, content);
        pstmt.executeUpdate();
        disConnect(conn);
    }

    @Override
    public void chagneDone(String id, String isDone) throws Exception {
        Connection conn = connect();
        String sql = "update todos set isDone = ? where id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setBoolean(1, !Boolean.valueOf(isDone));
        pstmt.setString(2, id);
        pstmt.executeUpdate();
        disConnect(conn);
    }

    @Override
    public void removeTodo(String id) throws Exception {
        Connection conn = connect();
        String sql = "delete from todos where id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.executeUpdate();
        disConnect(conn);
    }

}
