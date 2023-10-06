<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원 정보</title>
</head>
<body>
   <jsp:include page="../inc/menu.jsp" />
   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">회원 정보</h1>
      </div>
   </div>
	<div class="container">
		<div class="row">
			<h2 class="alert alert-success">
				<%@ include file="../inc/dbconn.jsp"%>
				<%
					String msg = request.getParameter("msg");
					
					
					if(msg != null) { // processAddMember에서 executeUpdate if문에서 msg가 반환하는 값에 따라 출력되는 값이 다르게 나오게 하는 조건문
						if(msg.equals("0")){
						out.println("회원 정보가 수정되었습니다.");
						}
						else if (msg.equals("1")) {
							out.println("회원 가입을 축하드립니다.");
						}
						else if (msg.equals("2")) {
							out.println(session.getAttribute("sessionMemberName") + "님 환영합니다.");
						}
						else {
							out.println("회원 정보가 삭제되었습니다.");
						}
					}
				%>
			</h2>
		</div>
	</div>
   <jsp:include page="../inc/footer.jsp" />
</body>
</html>