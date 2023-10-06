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
		request.setCharacterEncoding("UTF-8");
	
		String sessionMemberId = (String) session.getAttribute("sessionMemberId");
		
		PreparedStatement preparedStatement = null;
		String sql = "DELETE FROM member WHERE memberId = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, sessionMemberId);
		preparedStatement.executeUpdate();
		
		session.invalidate();
		
		response.sendRedirect("resultMember.jsp?msg");

	%>
</body>
</html>