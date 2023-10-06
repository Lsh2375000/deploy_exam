<%@page import="java.sql.*"%>
<%@page import="com.example.dto.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 추가 프로세스</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp"%>
	<%
		String productId = request.getParameter("productId");
		if(productId == null || productId.trim().equals("")) {
			// null이 반환되거나 빈 문자열이 들오온 경우
			response.sendRedirect("../products.jsp");
			return;
		}

		PreparedStatement preparedStatement = null;


		try {
	   		String sql = "delete from cart where productId = ?";
	   		preparedStatement = connection.prepareStatement(sql);
	   		preparedStatement.setString(1, productId);
	   		preparedStatement.executeQuery();
		} catch (SQLException e) {
			out.println("SQLException : " + e.getMessage());
		}
		if(preparedStatement != null) {
			preparedStatement.close();
		}
		if(connection != null) {
			connection.close();
		}
		
		/* 		// 유효한 productId인지 확인
		ProductRepository productRepository = ProductRepository.getInstance();
		Product product = productRepository.getProductById(productId);
		if(product == null) {
			response.sendRedirect("../exception/exceptionNoProduct.jsp");
		}
		
		// 세션에서 장바구니 목록 가져옴
		ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
		for(int i = 0; i < carts.size(); i++) {
			Cart cart = carts.get(i);
			if(cart.getProductId().equals(productId)) {
				carts.remove(cart);
				break;
			}
		} */
		response.sendRedirect("./cart.jsp");
	%>
</body>
</html>