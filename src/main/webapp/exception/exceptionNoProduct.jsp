<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dto.Product" %>
<%@ page import="com.example.dao.ProductRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록 오류</title>
</head>
<body>
   <jsp:include page="../inc/menu.jsp" />
   <div class="jumbotron">
      <div class="container">
         <h2 class="alert alert-danger">해당 상품이 존재하지 않습니다.</h2>
      </div>
   </div>
   <div class="container">
   		<p><%=request.getQueryString()%></p>
   		<p><a href="../product/products.jsp" class="btn btn-secondary">상품 목록 >></a></p>
   </div>
   <jsp:include page="../inc/footer.jsp" />
</body>
</html>