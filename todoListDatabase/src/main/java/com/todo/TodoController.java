package com.todo;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@WebServlet(urlPatterns = "*.todo")
public class TodoController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private static String indexUrl = "/todoListVue.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String command = req.getRequestURI().substring(req.getContextPath().length());
        req.setCharacterEncoding("utf-8");
        TodoRepository ts = TodoDbRepository.getInstance();
        if ("/list.todo".equals(command)) {
            try {
                JSONArray todosJsonArray = ts.getTodoList();
                resp.setContentType("application/json;");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().println(JSONArray.toJSONString(todosJsonArray));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String command = req.getRequestURI().substring(req.getContextPath().length());
        req.setCharacterEncoding("utf-8");
        TodoRepository ts = TodoDbRepository.getInstance();
        StringBuffer sbuff = new StringBuffer();
        String params = null;
        if ("/add.todo".equals(command)) {
            try {
                BufferedReader reader = req.getReader();
                while ((params = reader.readLine()) != null) {
                    sbuff.append(params);
                }
                JSONParser parser = new JSONParser();
                JSONObject jobj = (JSONObject) parser.parse(sbuff.toString());
                ts.addTodo((String) jobj.get("content"));
                req.getRequestDispatcher(indexUrl).forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("/isDone.todo".equals(command)) {
            try {
                BufferedReader reader = req.getReader();
                while ((params = reader.readLine()) != null) {
                    sbuff.append(params);
                }
                JSONParser parser = new JSONParser();
                JSONObject jobj = (JSONObject) parser.parse(sbuff.toString());
                ts.chagneDone((String) jobj.get("id"), (String) jobj.get("isDone"));
                req.getRequestDispatcher(indexUrl).forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("/remove.todo".equals(command)) {
            try {
                BufferedReader reader = req.getReader();
                while ((params = reader.readLine()) != null) {
                    sbuff.append(params);
                }
                JSONParser parser = new JSONParser();
                JSONObject jobj = (JSONObject) parser.parse(sbuff.toString());
                ts.removeTodo((String) jobj.get("id"));
                req.getRequestDispatcher(indexUrl).forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
}
