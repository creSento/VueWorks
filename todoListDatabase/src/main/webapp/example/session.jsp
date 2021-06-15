<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.sm.jsp.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function nextPage() {
    location.href = 'next.jsp';
  }
</script>
</head>
<body>
  <%
  session.setAttribute("name","홍길동");
  out.print(session.getAttribute("name"));
  out.print("<br>");
  session.setAttribute("profile", new Person("홍길동", 25));
  Person person = (Person) session.getAttribute("profile");
  out.print(person);
  out.print("<br>");
  List<Person> items = new ArrayList<Person>();
  items.add(person);
  items.add(new Person("홍길동", 14));
  session.setAttribute("list", items);
  out.print(session.getAttribute("list"));
  out.print("<br>");
  %>
  
  <button onclick="nextPage()">move</button>
</body>
</html>