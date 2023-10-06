<%@page import="java.sql.*"%>
<%@page import="com.example.dto.*"%>
<%@page import="java.util.*"%>
<%@page import="com.example.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 추가 프로세스</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp"%>
	<%
		String productId = request.getParameter("productId");
		if(productId == null || productId.trim().equals("")) {
			// null이 반환되거나 빈 문자열이 들오온 경우
			response.sendRedirect("../products.jsp");
			return;
		}
		
/* 		ProductRepository productRepository = ProductRepository.getInstance();
		Product product = productRepository.getProductById(productId);
		if(product == null) {
			response.sendRedirect("../exception/exceptionNoProduct.jsp");
		} */

		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		


		// 동일한 주문번호에 같은 상품번호가 있으면 업데이트
		String sql = "SELECT num FROM cart WHERE (orderId=?) AND (productId=?)";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, orderId);
		preparedStatement.setString(2, productId);
		resultSet = preparedStatement.executeQuery();
		if(resultSet.next()) {
			sql = "UPDATE cart SET cnt = cnt + 1 WHERE num = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, resultSet.getInt("num"));
			preparedStatement.executeUpdate();
		}
		else {
			String memberId = (String) session.getAttribute("sessionMemberId");
			memberId = (memberId == null) ? "Guest" : memberId;
			
			int cnt = 1;
			
			sql = "INSERT INTO cart (orderId, memberId, productId, cnt, addDate)" +
					"VALUES (?, ?, ?, ?, now())";
			
			try{
				preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1, orderId);
				preparedStatement.setString(2, memberId);
				preparedStatement.setString(3, productId);
				preparedStatement.setInt(4, cnt);
				preparedStatement.executeUpdate();
			} catch (SQLException e) {
				throw new RuntimeException(e);
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
		}
		
		
		
		// 장바구니에 파라미터로 전달된 productId와 동일한 데이터가 있는 경우에는
		// 장바구니에 추가하지 말고 갯수만 변경하도로고 수정
		ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts"); // 세션에서 carts 가지고 온다
		if(carts == null) { // 생성된 목록이 없는 경우, 목록 생성 후 세션에 저장.
			carts = new ArrayList<Cart>();
			session.setAttribute("carts", carts);
		}
		boolean isAddCart = false;
		for(Cart crt : carts) {
			
			if(crt.getProductId().equals(productId)){ // 이미 상품이 장바구니에 있으면 
				crt.setCartCnt(crt.getCartCnt()+1); // 상품의 개수만 +1하고
				isAddCart =  true; // true를 반환
				break;
			}
		}
		
		if(!isAddCart) { // 장바구니에 없다면
			Cart cart = new Cart(productId, 1); // 새로운 상품 추가
			carts.add(cart);
		}
		System.out.println(carts);

		response.sendRedirect("../product/product.jsp?productId=" + productId);
	%>
</body>
</html>