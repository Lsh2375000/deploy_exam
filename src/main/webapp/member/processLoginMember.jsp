<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.dto.Member" %>
<%-- <%@ page import="dao.MemberRepository" %> --%>
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
	

	
		String memberId = request.getParameter("memberId");
		String passwd = request.getParameter("passwd");
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		String sql = "select * from member where memberId = ? and passwd = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, memberId);
		preparedStatement.setString(2, passwd);
		resultSet = preparedStatement.executeQuery();
		
		if(resultSet.next()) {
			String memberName = resultSet.getString("memberName");
			session.setAttribute("sessionMemberId", memberId);
			session.setAttribute("sessionMemberName", memberName);

			sql = "UPDATE cart SET memberId = ? WHERE orderId = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, memberId);
			preparedStatement.setString(2, orderId);
			preparedStatement.executeUpdate();
			
			sql = "UPDATE cart SET orderId = ? WHERE memberId = ? AND orderId != ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, orderId);
			preparedStatement.setString(2, memberId);
			preparedStatement.setString(3, orderId);
			preparedStatement.executeUpdate();
			
			
			response.sendRedirect("resultMember.jsp?msg=2");
		}
		
		else {
			response.sendRedirect("loginMember.jsp?error");
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
		
		
/* 		MemberRepository memberRepository = MemberRepository.getInstance();
		
		Member member = new Member();
		
		member.setMemberId(memberId);
		member.setPasswd(passwd);
		member.setMemberName(memberName);
		member.setGender(gender);
		member.setBirthday(birthday);
		member.setEmail(email);
		member.setPhone(phone);
		member.setAddress(address);
		
		memberRepository.addMember(member);
		

		System.out.println(member); */
		
/* 		response.sendRedirect("members.jsp"); */
	%>

</body>
</html>