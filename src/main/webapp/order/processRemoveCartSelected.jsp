<%@page import="com.example.dto.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp"%>
	<%
	String[] checkedId = request.getParameterValues("checkedId");
	
	PreparedStatement preparedStatement = null;
	String sql = "delete from cart where productId = ?";

	if(checkedId != null){
		for(String productId : checkedId){
			try {
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
		}
	}
/* 		ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
		String[] checkedId = request.getParameterValues("checkedId");
			if(checkedId != null) {
				for(String s : checkedId) {
					for(int i = 0; i < carts.size(); i++) {
						Cart cart = carts.get(i);
						if(cart.getProductId().equals(s)) {
							carts.remove(cart);
							break;
						}
					}
				}
			} */
			response.sendRedirect("./cart.jsp");
	%>
</body>
</html>