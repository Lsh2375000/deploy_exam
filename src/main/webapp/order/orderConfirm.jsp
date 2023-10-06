<%@page import="com.example.dto.Product"%>
<%@page import="com.example.dao.ProductRepository"%>
<%@page import="com.example.dto.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>주문 정보</title>
</head>
<body>
<%
	String encoding = "UTF-8";
	request.setCharacterEncoding(encoding);

	String orderId = "", orderName = "", tel = "", zipCode = "", address01 = "", address02 = "";
	orderId = (String) session.getAttribute("orderId");
	orderName = (String) session.getAttribute("orderName");
	tel = (String) session.getAttribute("tel");
	zipCode = (String) session.getAttribute("zipCode");
	address01 = (String) session.getAttribute("address01");
	address02 = (String) session.getAttribute("address02");
	
	
/* 	Cookie[] cookies = request.getCookies();
	if(cookies != null) {
		for(Cookie cookie : cookies) {
			String cookieName = cookie.getName();
			switch(cookieName) {
			case "orderId":
				orderId = URLDecoder.decode(cookie.getValue(), encoding);
				break;
			case "orderName":
				orderName = URLDecoder.decode(cookie.getValue(), encoding);
				break;
			case "tel":
				tel = URLDecoder.decode(cookie.getValue(), encoding);
				break;
			case "zipCode":
				zipCode = URLDecoder.decode(cookie.getValue(), encoding);
				break;
			case "address01":
				address01 = URLDecoder.decode(cookie.getValue(), encoding);
				break;
			case "address02":
				address02 = URLDecoder.decode(cookie.getValue(), encoding);
				break;
			}
			
		}
	} */
%>
   <jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	<div class="container col-8 alert alert-info">
	 	<div class="text-center">
	 		<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br>
				성명 : <%=orderName%><br>
				연락처 : <%=tel%><br>
				우편번호 : <%=zipCode%><br>
				주소 : <%=address01%><br>
				<%=address02%>
			</div>
		</div>
		<div>
			<table class="table table-hover">
				<tr>
					<th class="text-center">상품</th>
					<th class="text-center">가격</th>
					<th class="text-center">수량</th>
					<th class="text-center">소계</th>					
				</tr>
				<%
					int sum = 0;
					ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
					if (carts == null){
						carts = new ArrayList<Cart>();
					}
					for(Cart cart : carts) {
						Product product = ProductRepository.getInstance().getProductById(cart.getProductId());
						int total = product.getUnitPrice() * cart.getCartCnt();
						sum = sum + total;
					
				%>
				<tr>
					<td class="text-center"><em><img src="/upload/<%=product.getFileName()%>" style="width:100px"></em></td>
					<td class="text-center"><em><%=product.getProductName()%></em></td>
					<td class="text-center"><%=product.getUnitPrice()%>원</td>
					<td class="text-center"><%=cart.getCartCnt()%></td>
					<td class="text-center"><%=total%>원</td>
				</tr>
				<%
					}
				%>
				<tr>
					<td></td>
					<td></td>
					<td class="text-right"><strong>총액 : </strong></td>
					<td class="text-right text-danger"><strong><%=sum%></strong></td>
				</tr>
			</table>
			<a href="./shippingInfo.jsp" class="btn btn-secondary" role="button"> 이전 </a>
			<a href="./thankCustomer.jsp" class="btn btn-success" role="button"> 주문 완료 </a>
			<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
		</div>
	</div>
	
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>