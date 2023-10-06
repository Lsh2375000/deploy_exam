<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mvc.model.BoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.mvc.model.BoardDTO" %>
<%
    // String sessionId = (String) session.getAttribute("sessionMemberId");
    List boardList = (List) request.getAttribute("boardList"); // 속성값이 object이기 떄문에 다운 캐스팅을 한것
    int totalRecord = (Integer) request.getAttribute("totalRecord");
    int pageNum = (Integer) request.getAttribute("pageNum"); // 현재 페이지 번호
    int totalPage = (Integer) request.getAttribute("totalPage"); // 전체 페이지 수
    int startNum = (Integer) request.getAttribute("startNum"); // 전체 페이지 수


    String items = "", text = "";
    if(request.getParameter("items") != null && request.getParameter("text") != null) {
        items = request.getParameter("items");
        text = request.getParameter("text");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <title>상품 목록</title>
    <script type="text/javascript">
        function checkForm() {
            location.href = "./boardAddForm.do";
        }
    </script>
</head>
<body>
<jsp:include page="../inc/menu.jsp"/>
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3">게시판</h1>
    </div>
</div>
<div class="container">
    <div>
        <div class="text-right">
            <span class="badge badge-success"> 전체<%=totalRecord%>건</span>
        </div>
    </div>
    <div style="padding-top: 50px">
        <table class="table table-hover">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
                <th>조회</th>
                <th>글쓴이</th>
            </tr>
            <%
                if (boardList != null) {
                    for (int j = 0; j < boardList.size(); j++) {
                        BoardDTO board = (BoardDTO) boardList.get(j);
            %>
            <tr>
                <td><%=startNum%>
                </td>
                <td>
                    <a href="./boardView.do?num=<%=board.getNum()%>&pageNum=<%=pageNum%>&items=<%=items%>&text=<%=text%>"><%=board.getSubject()%>
                    </a></td>
                <td><%=board.getAddDate()%>
                </td>
                <td><%=board.getHit()%>
                </td>
                <td><%=board.getName()%>
                </td>
            </tr>
            <%
                        startNum--;
                    }
                }
            %>
        </table>
    </div>
    <div align="center">
        <c:set var="pageNum" value="<%=pageNum%>"/>
        <c:forEach var="i" begin="1" end="<%=totalPage%>">
            <%
                   if(items.equals("") && text.equals("")) {}

            %>

            <a href="./boardList.do?pageNum=${i}&text=<%=text%>">
                <c:choose>
                    <c:when test="${pageNum==i}">
                        <font color="4C5317"><b> [${i}]</b></font>
                    </c:when>
                    <c:otherwise>
                        <font color="4C5317"> [${i}]</font>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:forEach>
    </div>
    <div align="left">
        <form action="./boardList.do?pageNum=<%=pageNum%>text=<%=text%>" method="get">
            <table>
                <tr>
                    <td width="100%" align="left">
                        <select name="items" class="txt">
                            <option value="subject">제목에서</option>
                            <option value="content">본문에서</option>
                            <option value="name">글쓴이에서</option>
                        </select> <input type="text" name="text"/>
                        <input type="submit" id="btnAdd" class="btn btn-primary" value="검색"/>
                    </td>
                    <td width="100%" align="right">
                        <a href="#" onclick="checkForm(); return false;" class="btn btn-primary">글쓰기</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>