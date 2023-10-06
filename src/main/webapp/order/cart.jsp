<%@page import="com.example.dto.Product"%>
<%@page import="com.example.dao.ProductRepository"%>
<%@page import="com.example.dto.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
   <jsp:include page="../inc/menu.jsp"/>
   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">장바구니</h1>
      </div>
   </div>
   <div class="container">
      <div class="row">
         <table width="100%">
            <tr>
               <td align="left">
                  <a href="#" class="btn btn-danger btn-removeAll">비우기</a>
                  <a href='#' class="btn btn-danger btn-selected">선택 삭제</a>
                  <a href="./shippingInfo.jsp" class="btn btn-success">주문</a>
               </td>
            </tr>
         </table>
      </div>

      <div style="padding-top: 50px">
         <form name="frmCart" method="post">
            <input type="hidden" name="productId">
            <table class="table table-hover">
               <tr>
                  <td>선택</td>
                  <td>사진</td>
                  <td>상품</td>
                  <td>가격</td>
                  <td>수량</td>
                  <td>소계</td>
                  <td>비고</td>
               </tr>
            <%--
               ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
               if(carts == null) {
                  carts = new ArrayList<Cart>();
                  session.setAttribute("carts", carts);
               }
               int sum = 0;
               ProductRepository productRepository = ProductRepository.getInstance();
               for(Cart cart : carts) {
                  Product product = productRepository.getProductById(cart.getProductId());
                  Integer price = product.getUnitPrice() * cart.getCartCnt();
                  sum += price;
            --%>   
<%@ include file="../inc/dbconn.jsp" %>
            <%
               PreparedStatement preparedStatement = null;
               ResultSet resultSet = null;
               
               String sql = "SELECT * FROM product join cart USING (productId) where orderId=?";
               preparedStatement = connection.prepareStatement(sql);
               preparedStatement.setString(1, orderId);
               resultSet = preparedStatement.executeQuery();
               
               int price = 0;
               int sum =0;
               while(resultSet.next()){
                  price = resultSet.getInt("cnt") * resultSet.getInt("unitPrice");
                  sum += price;
            %>
               <tr>
                  <td><input type="checkbox" name="checkedId" value="<%=resultSet.getString("productId") %>"></td>
                  <td><img src="/upload/<%=resultSet.getString("fileName") %>" style="width:100px;"></td>
                  <td><a href="../product/product.jsp?productId=<%=resultSet.getString("productId") %>"><%=resultSet.getString("productName") %></a></td>
                  <td><%=resultSet.getString("unitPrice") %></td>
                  <td><input type="text" name="cnt_<%=resultSet.getString("productId")%>" value="<%=resultSet.getInt("cnt")%>">
		               <a href="#" class="btn-plus" role="<%=resultSet.getString("productId")%>" about="plus">+</a>
		               <a href="#" class="btn-minus" role="<%=resultSet.getString("productId")%>" about="minus">-</a>
           		 </td>
                  <td><%=price %></td>
                  <td><a href="#" role="<%=resultSet.getString("productId") %>" class="badge badge-danger btn-removeById">삭제</a></td>
               </tr>
            <%
               }
            %>
               <tr>
                  <td colspan="7">합계 : <%=sum %>원</td>
               </tr>
            </table>
         </form>
         <a href="../product/products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
      </div>
   </div>
   <script>
      document.addEventListener("DOMContentLoaded", function(){
         const btnRemove = document.querySelector(".btn-removeAll");
         btnRemove.addEventListener("click", function(e){
            if(!confirm("정말 삭제하시겠습니까?")){
               e.preventDefault();
            }
            else{
               location.href='./processRemoveCart.jsp';   
            }
         });
         
         const btnRemoveSelected = document.querySelector(".btn-selected");
         const frmCart = document.querySelector('form[name=frmCart]');
         btnRemoveSelected.addEventListener("click", function(){
            if(confirm('정말 삭제하시겠습니까?')) {
               frmCart.action ='./processRemoveCartSelected.jsp';
               frmCart.submit();
            }
         });
         
         const btnRemoveByIds = document.querySelectorAll(".btn-removeById");
         btnRemoveByIds.forEach(button => {
            button.addEventListener('click', function(e){
               if(confirm('정말 삭제하시겠습니까?')) {
                  frmCart.productId.value = e.target.role;
                  frmCart.action = './processRemoveCartById.jsp';
                  frmCart.submit();
               }
            });
         });   
      });
   </script>
   <jsp:include page="../inc/footer.jsp"/>
</body>
</html>