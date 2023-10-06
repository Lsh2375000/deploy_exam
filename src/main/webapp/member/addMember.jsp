<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dto.Member" %>
<jsp:useBean id="memberDAO" class="com.example.dao.MemberRepository" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원가입</title>
</head>
<body>
   <jsp:include page="../inc/menu.jsp" />
   
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원가입</h1>
		</div>
	</div>
   
	<div class="container">
		<form name="frmMember" action="./processAddMember.jsp" method="post">
			<%-- 아이디 --%>
			<div class="form-group row">
   				<label class="col-sm-2">아이디</label>
   				<div class="col-sm-5">
   					<input type="text" name="memberId" class="form-control">
   					<span class="memberIdCheck"></span>
   					<br><input type="button" name="btnIsDuplication" value="팝업 아이디 중복 확인">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
   					<input type="button" name="btnIsDuplication2nd" value="ajax 아이디 중복 확인">
   				</div>
   			</div>
   			<script type="text/javascript">
   				document.addEventListener("DOMContentLoaded", function() {
   					const btnIsDuplication = document.querySelector('input[name=btnIsDuplication]');
   					// 1. 팝업을 이용한 Id 중복확인
   					// 팝업을 띄우는 이유는, 현재 페이지에서 데이터베이스에 중복 조회를 할려면 페이지 새로고침 이외에는 방법이 없음
   					btnIsDuplication.addEventListener('click', function() {
   						const memberId = frmMember.memberId.value; // 아이디 input에 있는 값.
   						if(memberId === "") {
   							alert('아이디를 입력해 주세요.');
   							frmMember.memberId.focus();
   							return;
   						}
   						// 아이디 중복 확인을 위해 팝업을 띄움
   						window.open('popupIdCheck.jsp?id=' + memberId, 'idCheck', 'width = 500, height = 500, top = 100, left = 200, location = no');
   					});
   					
   					const xhr = new XMLHttpRequest();
   					const btnIsDuplication2nd = document.querySelector('input[name=btnIsDuplication2nd]');
   					
   					// 2. ajax을 이용한 Id 중복확인
   					btnIsDuplication2nd.addEventListener('click', function() {
   						const memberId = frmMember.memberId.value; // 아이디 input에 있는 값.
   						console.log(memberId);
						xhr.open('GET', 'ajaxIdCheck.jsp?id=' + memberId); // HTTP 요청 초기화. 통신 방식과 url 설정
   						xhr.send(); // url에 요청을 보냄
   						// 이벤트 등록. XMLHttpRequest 객체의 readyState 프로퍼티 값이 변할 때마다 자동으로 호출
   						xhr.onreadystatechange = () => {
   							// readyState 프로퍼티의 값이 DONE : 요철한 데이터의 처리가 완료되어 응답할 준비가 완료됨.
   							if(xhr.readyState !== XMLHttpRequest.DONE) return;
   							if(memberId === "") {
   								alert('아이디를 입력해 주세요');
   								return;
   							}
   							if(xhr.status === 200) { // 서버(url)에 문서가 존재함
   								const json = JSON.parse(xhr.response);
   								if(json.result === 'true') {
   									alert('동일한 아이디가 있습니다.');
   								}
   								else {
   									alert('동일한 아이디가 없습니다.');   								
   								}
   							}
   							else { // 서버(url)에 문서가 존재하지 않음.
   								console.error('Error', xhr.status, xhr.statusText);
   							}
   						}
   					});
   					
   					// 3. ajax를 이용한 실시간 Id 중복 확인
   					// 2번에서 작업된 차일을 이용
   					const inputId = document.querySelector('input[name=memberId]');
   					inputId.addEventListener('keyup', function () {
   						const id = frmMember.memberId.value;
   						const memberIdCheck = document.querySelector('.memberIdCheck');
						xhr.open('GET', 'ajaxIdCheck.jsp?id=' + id); // HTTP 요청 초기화. 통신 방식과 url 설정
   						xhr.send(); // url에 요청을 보냄
   						// 이벤트 등록. XMLHttpRequest 객체의 readyState 프로퍼티 값이 변할 때마다 자동으로 호출
   						xhr.onreadystatechange = () => {
   							// readyState 프로퍼티의 값이 DONE : 요철한 데이터의 처리가 완료되어 응답할 준비가 완료됨.
   							if(xhr.readyState !== XMLHttpRequest.DONE) return;
   							if(xhr.status === 200) { // 서버(url)에 문서가 존재함
   								const json = JSON.parse(xhr.response);
   								if(json.result === 'true') {
   									memberIdCheck.style.color = 'red';
   									memberIdCheck.innerHTML = '동일한 아이디가 있습니다.';
   								}
   								else {
   									memberIdCheck.style.color = 'green';
   									memberIdCheck.innerHTML = '동일한 아이디가 없습니다.';   								
   								}
   							}
   							else { // 서버(url)에 문서가 존재하지 않음.
   								console.error('Error', xhr.status, xhr.statusText);
   							}
   						}
   					});
   					
   					
   				});
   			</script>
			<%-- 비밀번호 --%>
			<div class="form-group row">
   				<label class="col-sm-2">비밀번호</label>
   				<div class="col-sm-5">
   					<input type="password" name="passwd" class="form-control">
   				</div>
   			</div>
			<%-- 이름 --%>
			<div class="form-group row">
   				<label class="col-sm-2">이름</label>
   				<div class="col-sm-5">
   					<input type="text" name="memberName" class="form-control">
   				</div>
   			</div>
			<%-- 연락처 --%>
			<div class="form-group row">
   				<label class="col-sm-2">연락처</label>
   				<div class="col-sm-5">
   					<input type="text" name="phone" class="form-control">
   				</div>
   			</div>
			<%-- 성별 --%>			
	   		<div class="form-group row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<input name="gender" type="radio" value="남"> 남
					<input name="gender" type="radio" value="여"> 여
				</div>
			</div>
			<%-- 생일 --%>	
			<div class="form-group row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-4  ">
					<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6">
					<select name="birthmm">
						<option value="">월</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
					</select> <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4">
				</div>
			</div>
			<%-- 이메일 --%>
			<div class="form-group row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50">@
					<select name="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>
			</div>
			<%-- 우편번호 --%>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-2">
					<input type="text" name="zipCode" id="zipcode" class="form-control" readonly>
				</div>
				<div class="col-sm-3">
					<input type="button" name="zipCodeBtn" class="zipCodeBtn" value="주소찾기">
				</div>				
			</div>
			<%-- 주소1 --%>
			<div class="form-group row">
				<label class="col-sm-2">주소 1</label>
				<div class="col-sm-4">
					<input type="text" name="address01" id="address01" class="form-control" readonly>
				</div>
			</div>
			<%-- 주소2 --%>
			<div class="form-group row">
				<label class="col-sm-2">주소 2</label>
				<div class="col-sm-4">
					<input type="text" name="address02" id="address02" class="form-control">
				</div>
			</div>
	   		<div class="form-group row">
	   			<div class="col-sm-10">
	   				<input type="submit" class="btn btn-primary" value="등록">
	   			</div>
			</div>
		
		</form>
	</div>
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