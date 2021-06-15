<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sm.jsp.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>Hello world</h1>
  <%
  // new -> allocate new memory address
  Person person1 = new Person("홍길동",  25);
  Person person2 = new Person("홍길동",  25);
  %>
  <%=
  person1.equals(person2) // false : value
  %>
  <br>
  <%=
  person1 == person2  // false : reference
  %>
  <br>
  <h1>HashCode</h1>
  <%
  out.print(person1); // random hashcode
  out.print("<br>");
  out.print(person2);
  %>
  <br>
  <h3>List</h3>
  <%
  // reference - by order - duplicate
  List<Person> items = new ArrayList<Person>();
  items.add(person1);
  items.add(person2);
  out.print(items);
  %>
  <br>
  <h3>Set</h3>
  <%
  // hashcode - set - not duplicate
  Set<Person> itemSet = new HashSet<Person>();
  itemSet.add(person1);
  itemSet.add(person1);
  itemSet.add(person1);
  itemSet.add(person2);
  out.print(itemSet);
  %>
  <hr>
  <%!
  // parameter type이 더 추상적일수록 더 많은 type을 처리가능
  // List > ArrayList, LinkedList, ...
  void foo(ArrayList<Person> list, Person person) { // only use 'ArrayList'
      list.add(person);
  }
  void foo2(List<Person> list, Person person) { // use all 'List' type
      list.add(person);
  }
  %>
  <%
  ArrayList<Person> items2 = new ArrayList<Person>();
  // List<Person> items2 = new ArrayList<Person>();
  foo(items2, person1);
  out.print(items2);
  foo2(items2, person1);
  %>
  <br>
  <!-- set Serializable to use useBean -->
  <jsp:useBean id="Person3" class="com.sm.jsp.Person" scope="page"/>
</body>
</html>