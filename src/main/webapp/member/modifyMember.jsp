<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.dto.Member" %>
<jsp:useBean id="memberDAO" class="com.example.dao.MemberRepository" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>정보수정</title>
</head>
<body> <%-- 이유가 명확하지 않거나 중복적인 오류가 떳을 때는 자바 코드가 들어간 부분을 하나씩 지워 가면서 원인을 찾는다. --%>
   <jsp:include page="../inc/menu.jsp" />
   	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">정보수정</h1>
		</div>
	</div>
   <%@ include file="../inc/dbconn.jsp"%>
   <%
   		String sessionMemberId = (String) session.getAttribute("sessionMemberId");
   
   		PreparedStatement preparedStatement = null;
   		ResultSet resultSet = null;
   		
   		String sql = "SELECT * FROM member WHERE memberId = ?";
   		preparedStatement = connection.prepareStatement(sql);
   		preparedStatement.setString(1, sessionMemberId);
   		resultSet = preparedStatement.executeQuery();
   		
   		if(resultSet.next()) {
   			String passwd = resultSet.getString("passwd");
   			String memberName = resultSet.getString("memberName");
   			String gender = resultSet.getString("gender");
   			String birthday = resultSet.getString("birthday");
   			String[] birthdayArr = birthday.split("-");
   			String birthyy = birthdayArr[0];
   			String birthmm = birthdayArr[1];
   			String birthdd = birthdayArr[2];
   			String email = resultSet.getString("email");
   			String[] emailArr = email.split("@");
   			String phone = resultSet.getString("phone");
   			String zipCode = resultSet.getString("zipCode");
   			String address01 = resultSet.getString("address01");
   			String address02 = resultSet.getString("address02");
   		
   %>

	<div class="container">
		<form name="frmMember" action="./processModifyMember.jsp" method="post">
			<%-- 아이디 --%>
			<div class="form-group row">
   				<label class="col-sm-2">아이디</label>
   				<div class="col-sm-5">
   					<p><%=sessionMemberId%></p>
   				</div>
   			</div>
			<%-- 비밀번호 --%>
			<div class="form-group row">
   				<label class="col-sm-2">비밀번호</label>
   				<div class="col-sm-5">
   					<input type="password" name="passwd" value="<%=passwd%>">
   				</div>
   			</div>
			<%-- 이름 --%>
			<div class="form-group row">
   				<label class="col-sm-2">이름</label>
   				<div class="col-sm-5">
   					<input type="text" name="memberName" value="<%=memberName%>">
   				</div>
   			</div>
			<%-- 연락처 --%>
			<div class="form-group row">
   				<label class="col-sm-2">연락처</label>
   				<div class="col-sm-5">
   					<input type="text" name="phone" value="<%=phone%>">
   				</div>
   			</div>
			<%-- 성별 --%>			
	   		<div class="form-group row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<input name="gender" type="radio" value="남"<%if(resultSet.getString("gender").equals("남")){out.println(" checked");} %>>
					 남
					<input name="gender" type="radio" value="여"<%if(resultSet.getString("gender").equals("여")){out.println(" checked");} %>>
					 여
				</div>
			</div>
			<%-- 생일 --%>	
			<div class="form-group row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-4  ">
					<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6" value="<%=birthyy%>">
					<select name="birthmm">
						<option value="">월</option>
						<%
							for(int i = 1; i <= 12; i++) {
								String month = String.format("%02d", i);
								out.println("<option value=\"" + month + "\"");
								if(birthmm.equals(month)) {
									out.println(" selectedl");
								}
								out.println(">" + i + "</option>");
							}
						%>
					</select>
					<input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" value="<%=birthdd%>">
				</div>
			</div>
			<%-- 이메일 --%>
			<div class="form-group row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50" value="<%=emailArr[0]%>">@
					<select name="mail2">
						<option <% if(emailArr[1].equals("naver.com")) {out.println(" selected"); }%>>naver.com</option>
						<option <% if(emailArr[1].equals("daum.net")) {out.println(" selected"); }%>>daum.net</option>
						<option <% if(emailArr[1].equals("gmail.com")) {out.println(" selected"); }%>>gmail.com</option>
						<option <% if(emailArr[1].equals("nate.com")) {out.println(" selected"); }%>>nate.com</option>
					</select>
				</div>
			</div>
			<%-- 우편번호 --%>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" name="zipCode" id="zipcode" value="<%=zipCode%>" disabled>
				</div>
				<div class="col-sm-3">
					<input type="button" name="zipCodeBtn" class="zipCodeBtn" value="주소찾기">
				</div>				
			</div>
			<%-- 주소1 --%>
			<div class="form-group row">
				<label class="col-sm-2">주소 1</label>
				<div class="col-sm-3">
					<input type="text" name="address01" id="address01" value="<%=address01%>" disabled>
				</div>
			</div>
			<%-- 주소2 --%>
			<div class="form-group row">
				<label class="col-sm-2">주소 2</label>
				<div class="col-sm-3">
					<input type="text" name="address02" id="address02" value="<%=address02%>">
				</div>
			</div>
	   		<div class="form-group row">
	   			<div class="col-sm-10">
	   				<input type="submit" class="btn btn-primary" value="수정">
	   				<a href="processRemoveMember.jsp" class="btn btn-primary">회원 탈퇴</a>
	   			</div>
			</div>
		
		</form>
	</div>
		    		<%
   		}
	%>
	   <script type="text/javascript">
		        document.addEventListener('DOMContentLoaded', function() { // 우편번호 팝업 API (Daum)
		            document.querySelector('.zipCodeBtn').addEventListener('click', execDaumPostcode);
		        });
		    	</script>
		    	<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
		    	<script>
		        /* 
		        카카오 우편번호 검색 가이드 페이지 :  https://postcode.map.daum.net/guide
		        */
		        function execDaumPostcode() {
		            /* 상황에 맞춰서 변경해야 하는 부분 */
		            const zipcode = document.getElementById('zipcode');
		            const address01 = document.getElementById('address01');
		            const address02 = document.getElementById('address02');

		            /* 수정없이 사용 하는 부분 */
		            new daum.Postcode({
		                oncomplete: function(data) {
		                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                    var fullAddr = ''; // 최종 주소 변수
		                    var extraAddr = ''; // 조합형 주소 변수

		                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                        fullAddr = data.roadAddress;
		                    }
		                    else { // 사용자가 지번 주소를 선택했을 경우(J)
		                        fullAddr = data.jibunAddress;
		                    }

		                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		                    if(data.userSelectedType === 'R'){
		                        //법정동명이 있을 경우 추가한다.
		                        if(data.bname !== ''){
		                            extraAddr += data.bname;
		                        }
		                        // 건물명이 있을 경우 추가한다.
		                        if(data.buildingName !== ''){
		                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                        }
		                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                        fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                    }

		                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                    zipcode.value = data.zonecode; //5자리 새우편번호 사용
		                    address01.value = fullAddr;

		                    // 커서를 상세주소 필드로 이동한다.
		                    address02.focus();
		                }
		            }).open();
		        }
		    	</script>

	<jsp:include page="../inc/footer.jsp"/>
   
</body>
</html>