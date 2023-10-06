<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dto.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body>
   <jsp:include page="../inc/menu.jsp" />
   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">상품 목록</h1>
      </div>
   </div>
   <%
/* 		ProductRepository productRepository = ProductRepository.getInstance();
   		ArrayList<Product> products = productRepository.getAllProducts(); */
   		
   		DecimalFormat formatter = new DecimalFormat("###,###.##"); // 숫자 표시되는 형식 변경

   %>
   <div class="container">
   		<div class="row" align="center">
		    <%@ include file="../inc/dbconn.jsp"%>
   			<%
		   		PreparedStatement preparedStatement = null; 
		   		ResultSet resultSet = null; // ResultSet 값을 저장하면 표형식으로 저장 / 값을 가져올 때 행단위로 불러 올 수 있음
		   		String sql = "select * from product";
		   		preparedStatement = connection.prepareStatement(sql);
		   		resultSet = preparedStatement.executeQuery();
		   		while(resultSet.next()) {
   				/* for(Product product : products) { */
   			%> 
   			<div class="col-md-4">
   				<img src="/upload/<%=resultSet.getString("fileName")%>" style="width:100%">
   				<h3><%=resultSet.getString("productName")%></h3>
   				<p><%=resultSet.getString("description")%></p>
   				<p><%=formatter.format(Integer.parseInt(resultSet.getString("unitPrice")))%>원</p>
   				<p><a href="./product.jsp?productId=<%=resultSet.getString("productId")%>" class="btn btn-secondary" role="button">
   				상세 정보 >> </a></p>
   			</div>
   			<%
   				}
   				if(resultSet != null) {
   					resultSet.close();
   				}
   				if(preparedStatement != null) {
   					preparedStatement.close();
   				}
   				if(connection != null) {
   					connection.close();
   				}
   			%>
   		</div>
   		<hr>
   </div>
   <jsp:include page="../inc/footer.jsp"/>
</body>
</html>