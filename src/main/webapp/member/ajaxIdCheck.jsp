<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
	%>
	<%@ include file="../inc/dbconn.jsp"%>
	<% // 실행해서 jsp뒤에 테스트할 값을 입력 해서 먼저 확인 한다. ex) jsp?id=zaqxsw327
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String sql = "SELECT * FROM member WHERE memberId = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, id);
		resultSet = preparedStatement.executeQuery();
		if(resultSet.next()) {
			out.println("{\"result\":\"true\"}");
		}
		else {
			out.println("{\"result\":\"false\"}");
		}
		if(resultSet != null) resultSet.close();
		if(preparedStatement != null) preparedStatement.close();
		if(connection != null) connection.close();
	%>
