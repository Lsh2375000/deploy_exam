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
		String memberName = request.getParameter("memberName");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthyy") + "-" + request.getParameter("birthmm") + "-" + request.getParameter("birthdd");
		String email = request.getParameter("mail1") + "@" + request.getParameter("mail2");
		String phone = request.getParameter("phone"); 
		String zipCode = request.getParameter("zipCode");
		String address01 = request.getParameter("address01");
		String address02 = request.getParameter("address02");


		
		PreparedStatement preparedStatement = null;
		
		String sql = "INSERT INTO member (memberId, passwd, memberName, gender, birthday, " +
						"email, phone, zipCode, address01, address02, " +
						"addDate) " +
						"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, memberId);
		preparedStatement.setString(2, passwd);
		preparedStatement.setString(3, memberName);
		preparedStatement.setString(4, gender);
		preparedStatement.setString(5, birthday);
		preparedStatement.setString(6, email);
		preparedStatement.setString(7, phone);
		preparedStatement.setString(8, zipCode);
		preparedStatement.setString(9, address01);
		preparedStatement.setString(10, address02);
		
		if(preparedStatement.executeUpdate() == 1) { // insert가 성공적으로 수행
			response.sendRedirect("resultMember.jsp?msg=1");
		}
		else { // msg - message 줄임말
			response.sendRedirect("addMember.jsp?msg=1");
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