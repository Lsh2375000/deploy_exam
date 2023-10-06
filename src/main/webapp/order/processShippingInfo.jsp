<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>배송 프로세스</title>
</head>
<body>
   <jsp:include page="../inc/menu.jsp" />
   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">배송 프로세스</h1>
      </div>
   </div>
<%
	String encoding = "UTF-8";
	request.setCharacterEncoding(encoding);
	// 주문 정보를 쿠키에 저장
/* 	Cookie orderId = new Cookie("orderId", URLEncoder.encode(request.getParameter("orderId"), encoding));
	Cookie orderName = new Cookie("orderName", URLEncoder.encode(request.getParameter("orderName"), encoding));
	Cookie tel = new Cookie("tel", URLEncoder.encode(request.getParameter("tel"), encoding));
	Cookie zipCode = new Cookie("zipCode", URLEncoder.encode(request.getParameter("zipCode"), encoding));
	Cookie address01 = new Cookie("address01", URLEncoder.encode(request.getParameter("address01"), encoding));
	Cookie address02 = new Cookie("address02", URLEncoder.encode(request.getParameter("address02"), encoding)); */
	

	
	session.setAttribute("orderId", request.getParameter("orderId"));
	session.setAttribute("orderName", request.getParameter("orderName"));
	session.setAttribute("tel", request.getParameter("tel"));
	session.setAttribute("zipCode", request.getParameter("zipCode"));
	session.setAttribute("address01", request.getParameter("address01"));
	session.setAttribute("address02", request.getParameter("address02"));
	

	
	
/* 	int maxAge = 24 * 60 * 60;
	orderId.setMaxAge(maxAge);
	orderName.setMaxAge(maxAge);
	tel.setMaxAge(maxAge);
	zipCode.setMaxAge(maxAge);
	address01.setMaxAge(maxAge);
	address02.setMaxAge(maxAge); */
	
/* 	response.addCookie(orderId);
	response.addCookie(orderName);
	response.addCookie(tel);
	response.addCookie(zipCode);
	response.addCookie(address01);
	response.addCookie(address02); */
	
	response.sendRedirect("orderConfirm.jsp");
%>
	<%-- <p>주문 번호 : <%=orderId%></p>
	<p>이름 : <%=orderName%></p>
	<p>전화번호 : <%=tel%></p>
	<p>우편번호 : <%=zipCode%></p>
	<p>주소1 : <%=address01%></p>
	<p>주소2 : <%=address02%></p> --%>
   
   <div class="container">
   		<div class="row">
   			<div class="col-md-6">
   			</div>
   		</div>
   </div>
   <jsp:include page="../inc/footer.jsp" />
</body>
</html>