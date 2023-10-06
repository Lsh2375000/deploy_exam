<%@ page import="com.example.mvc.model.BoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    BoardDTO board = (BoardDTO) request.getAttribute("board");
    String pageNum = request.getParameter("pageNum");
    String sessionMemberId = (String)  session.getAttribute("sessionMemberId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <title>상품 목록</title>
</head>
<body>
<jsp:include page="../inc/menu.jsp" />
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3">상품목록</h1>
    </div>
</div>

<div class="container">
    <div class="form-group row">
        <label class="col-sm-2 control-label">성명</label>
        <div class="col-sm-3">
            <%=board.getName()%>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 control-label">제목</label>
        <div class="col-sm-5">
            <%=board.getSubject()%>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 control-label">내용</label>
        <div class="col-sm-8" style="word-break: break-all;">
            <%=board.getContent()%>
        </div>
    </div>
    <div class="form-group row user-ripple-list">
        <ul>

        </ul>
    </div>
    <%-- 리플 목록 출력 영역 --%>
    <form name="frmRippleView" method="post">
        <input type="hidden" name="num" value="<%=board.getNum()%>">
    </form>
    <script>
        const xhr = new XMLHttpRequest();

        const getRipples = function () {
            const num = document.querySelector('form[name=frmRippleView] input[name=num]').value;
            xhr.open('GET', '/ripple/get?num=' + num);
            xhr.send();
            xhr.onreadystatechange = function () {
                if (xhr.readyState !== XMLHttpRequest.DONE) return;

                if (xhr.status === 200) {
                    console.log(xhr.response);
                    const json = JSON.parse(xhr.response);
                    for (let data of json) {
                        console.log(data);
                    }
                    addRippleTag(json);
                }
                else {
                    console.error('Error', xhr.status, xhr.statusText);
                }
            }
        }
        const addRippleTag = function (items) {

            const tagUl = document.querySelector('.user-ripple-list ul');
            tagUl.innerHTML = '';
            for (const item of items) {
                const tagLi = document.createElement('li');
                tagLi.innerHTML = item.content + ' | ' + item.name + ' | ' + item.insertDate;
                if (item.isLogin === true) {
                    tagLi.innerHTML +=
                        '<span class="btn btn-danger" onclick="goRippleDelete(\'' + item.rippleId + '\');">>삭제</span>'
                }
                tagLi.setAttribute('class', 'list-group-item');
                tagUl.append(tagLi);
            }

        };
        document.addEventListener('DOMContentLoaded', function () {
            getRipples();
        });
    </script>
    <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
            <%
                if(sessionMemberId != null && sessionMemberId.equals(board.getMemberId())) {
                // if(sessionMemberId.equals(board.getMemberId()) && sessionMemberId != null) {
                // AND연산자를 쓸때 순서를 잘보고 사용해야 한다. 이 코드는 아이디 값에 null이 들어가는데 equals는 문자열만 비교하지 null은 인식하지 않는다. 그래서 바로 false를 반환한다.
            %>
            <form name="frmView" method="post">
                <input type="hidden" name="pageNum" value="<%=pageNum%>">
                <input type="hidden" name="num" value="<%=board.getNum()%>">
            </form>
            <span class="btn btn-danger btn-remove"> 삭제 </span>
            <span class="btn btn-success btn-modify"> 수정 </span>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const btnModify = document.querySelector('.btn-modify');
                    const btnRemove = document.querySelector('.btn-remove');
                    const frmView = document.querySelector('form[name=frmView]');

                    btnModify.addEventListener('click', function () {
                        frmView.action = './boardModifyForm.do';
                        frmView.submit();
                    });
                    btnRemove.addEventListener('click', function () {
                        confirm("정말 삭제 하시겠습니까?");
                        frmView.action = './boardRemoveAction.do';
                        frmView.submit();
                    });
                });
            </script>
            <%
                }
            %>
            <a href="./boardList.do?pageNum=<%=pageNum%>" class="btn btn-primary"> 목록 </a>
        </div>
    </div>
    <hr>
    <%-- 리플 시작 --%>
    <c:if test="${sessionMemberId != null}">
        <form name="frmRipple" method="post">
            <input type="hidden" name="num" value="${board.num}">
            <div class="form-group row">
                <div class="col-sm-3">
                    <input name="name" type="text" class="form-control" value="${sessionMemberName}" placeholder="name">
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-8">
                    <textarea name="content" class="form-control" cols="50" rows="3"></textarea>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-4">
                    <span class="btn btn-primary" id="goRippleSubmit">등록</span>
                </div>
            </div>
        </form>
        <script>
            const goRippleDelete = function (rippleId) { // 리플 삭제
                if (confirm("삭제하시겠습니까?")) {
                    xhr.open('POST', '/ripple/remove?rippleId=' + rippleId);
                    xhr.send();
                    xhr.onreadystatechange = () => {
                        if (xhr.readyState !== XMLHttpRequest.DONE) {
                            return;
                        }
                        if (xhr.status === 200) {
                            console.log(xhr.response);
                            const json = JSON.parse(xhr.response);
                            if (json.result === 'true') {
                                getRipples();
                            }
                            else {
                                alert("삭제에 실패했습니다.");
                            }
                        }
                        else {
                            console.error('Error', xhr.status, xhr.statusText);
                        }
                    }
                }
            };


            document.addEventListener('DOMContentLoaded', function () {
                const xhr = new XMLHttpRequest(); // ajax 작업을 위한 객체 생성
                const btnRippleSubmit = document.querySelector('#goRippleSubmit'); // 리플 등록 버튼
                const frmRipple = document.querySelector('form[name=frmRipple]');

                btnRippleSubmit.addEventListener('click', function () { // 등록 버튼 클릭시
                    // form 안에 input 태그가 있지만 form을 submit하는 것이 아니라 ajax로 값을 남겨야 되어서 값을 추출 함.
                    const num = frmRipple.num.value;
                    const name = frmRipple.name.value;
                    const content = frmRipple.content.value;

                    xhr.open('POST', '/ripple/add?num=' + num + '&name=' + name + '&content=' + content);
                    xhr.send();
                    xhr.onreadystatechange = () => {
                        if (xhr.readyState !== XMLHttpRequest.DONE)
                            return;

                        if (xhr.status === 200) {
                            console.log(xhr.response);
                            const json = JSON.parse(xhr.response);
                            if (json.result === 'true') {
                                frmRipple.content.value = '';
                                getRipples();
                            }
                            else {
                                alert('등록에 실패했습니다.');
                            }
                        }
                        else {
                            console.error(xhr.status, xhr.statusText);
                        }
                    }
                });
            });
        </script>
    </c:if>
</div>

<jsp:include page="../inc/footer.jsp" />
</body>
</html>