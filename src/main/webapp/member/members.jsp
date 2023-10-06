<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dto.Member" %>
<%@ page import="com.example.dao.MemberRepository" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원목록</title>
</head>
<body>
   <jsp:include page="../inc/menu.jsp" />
   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">회원목록</h1>
      </div>
   </div>
   <%
      MemberRepository memberRepository = MemberRepository.getInstance();
      ArrayList<Member> members = memberRepository.getAllMembers();
   %>
   <div class="container">
   		<div class="row" align="center">
   			<%
   				for(Member member : members) {
   			%> 
   			
   			<div class="col-md-4">
   				<h3>이름 : <%=member.getMemberName()%></h3>
   				<p>아이디 : <%=member.getMemberId()%></p>
   				<p>성별 : <%=member.getGender()%></p>
   				<p><a href="./member.jsp?memberId=<%=member.getMemberId()%>" class="btn btn-secondary" role="button">
   				상세 정보 >> </a></p>
   			<%
   				}
   			%>
   		</div>
   		<hr>
   </div>
   <jsp:include page="../inc/footer.jsp"/>
</body>
</html>