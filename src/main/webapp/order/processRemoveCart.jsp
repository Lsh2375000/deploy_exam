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
		PreparedStatement preparedStatement = null;
   		String sql = "delete from cart";
		
		try {
	   		preparedStatement = connection.prepareStatement(sql);
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
		response.sendRedirect("./cart.jsp");
	%>
</body>
</html>