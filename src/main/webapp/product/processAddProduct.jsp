<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="org.apache.commons.io.comparator.DefaultFileComparator"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
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
	
		String folder = "c:\\upload";
		int maxSize = 5 * 1024 * 1024;
		String encType = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, folder, maxSize, encType, new DefaultFileRenamePolicy());
		
		
	
	
	
		String productId = multipartRequest.getParameter("productId");
		String productName = multipartRequest.getParameter("productName");
		String unitPrice = multipartRequest.getParameter("unitPrice");
		String description = multipartRequest.getParameter("description");
		String manufacturer = multipartRequest.getParameter("manufacturer");
		String category = multipartRequest.getParameter("category");
		String unitsInStock = multipartRequest.getParameter("unitsInStock"); 
		String condition = multipartRequest.getParameter("condition");
		String fileName = multipartRequest.getFilesystemName("fileName");
		
		
		// 문자열을 변경
		Integer price = unitPrice.isEmpty() ? 0 : Integer.parseInt(unitPrice);
		Long stock = unitsInStock.isEmpty() ? 0L : Long.parseLong(unitsInStock);
		
		PreparedStatement preparedStatement = null;
		
		// ProductRepository productRepository = ProductRepository.getInstance();
		String sql = "insert into product values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, productId);
		preparedStatement.setString(2, productName);
		preparedStatement.setInt(3, price);
		preparedStatement.setString(4, description);
		preparedStatement.setString(5, manufacturer);
		preparedStatement.setString(6, category);
		preparedStatement.setLong(7, stock);
		preparedStatement.setString(8, condition);
		preparedStatement.setString(9, fileName);
		preparedStatement.executeUpdate();
		
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
		
		response.sendRedirect("products.jsp");
	%>

</body>
</html>