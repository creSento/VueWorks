<%@page import="java.util.*, com.sm.jsp.Cart"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
</head>
<body>
  <form method="post">
    <input name="name" type="text" placeholder="상품명">
    <input name="amount" type="text" placeholder="수량">
    <button>ADD</button>
  </form>
  <%
  String name = request.getParameter("name");
  String amount = request.getParameter("amount");
  Set<Cart> items = (HashSet<Cart>) session.getAttribute("cartItems");
  if (items == null) {
      items = new HashSet<Cart>();
  }
  if (name != null && amount != null && !name.isEmpty() && !amount.isEmpty()) {
      items.add(new Cart(name, Integer.parseInt(amount)));
  }
  session.setAttribute("cartItems", items);
  %>
  <div>
    <ul>
      <c:forEach items="${cartItems }" var="cart">
        <li>${cart }</li>
      </c:forEach>
    </ul>
  </div>  
</body>
</html>