<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="org.apache.commons.io.comparator.DefaultFileComparator"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.dto.Product" %>
<%@ page import="com.example.dao.ProductRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
	
		
		
	
		String productId = request.getParameter("productId");
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		// ProductRepository productRepository = ProductRepository.getInstance();
		String sql = "select * from product where productId = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, productId);
		resultSet = preparedStatement.executeQuery();
		if(resultSet.next()){

			sql = "delete from product where productId = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, productId);
			preparedStatement.executeUpdate();
		}
		else {
			out.println("일치하는 상품이 없습니다.");
		}
		if(resultSet != null){
			resultSet.close();
		}
		if(preparedStatement != null){
			preparedStatement.close();
		}
		if(connection != null){
			connection.close();
		}
		
/* 		Product product = new Product();
		product.setProductId(productId);
		product.setProductName(productName);
		product.setUnitPrice(price);
		product.setDescription(description);
		product.setManufacturer(manufacturer);
		product.setCategory(category);
		product.setUnitsInStock(stock);
		product.setCondition(condition);
		product.setFileName(fileName); */
		
//		productRepository.addProduct(product);
		

//		System.out.println(product);
		
		response.sendRedirect("editProduct.jsp");
	%>

</body>
</html>