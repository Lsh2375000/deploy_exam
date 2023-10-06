<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	Connection connection = null;
	try{
		String url = "jdbc:mariadb://localhost:3308/sample";
		String user = "root";
		String password = "1460";
	 	// JDBC 로딩
		Class.forName("org.mariadb.jdbc.Driver");
	 	// DriverManager 클래스에서 connection 객체를 가져옴
		connection = DriverManager.getConnection(url, user, password);
	} catch (SQLException e) {
		out.println("데이터베이스 연결이 실패했습니다.<br>");
		out.println("SQLException : " + e.getMessage());
	}
%>
<%
	String orderId = (String) session.getAttribute("orderId");
	if(orderId == null){
		// 세션 아이디 가져오기
		String sessionId = session.getId();
	
		// 현재 날짜와 시간 가져오기
		java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		String currentDateTime = simpleDateFormat.format(new java.util.Date());
		
		orderId = currentDateTime + "-" + sessionId;
		session.setAttribute("orderId", orderId);
}
%>