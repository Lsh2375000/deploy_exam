package com.example.mvc.controller;

import com.example.mvc.service.BoardService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"*.do"})
public class BoardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       doPost(req, resp); // get으로 들어오더라도 doPost로 넘기게
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BoardService boardService = BoardService.getInstance();
        String RequestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String command = RequestURI.substring(contextPath.length());
        System.out.println("command" + command);

        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("utf-8");

        switch (command) {
            case "/boardController/boardList.do" -> { // 등록된 글 목록 페이지
                boardService.requestBoardList(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/list.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardAddForm.do" ->{ // 글 작성 페이지
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/addForm.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardAddAction.do" -> { // 글 작성하기
                boardService.addBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
            case "/boardController/boardView.do" -> { // 게시글 보기
                boardService.getBoardView(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/view.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardModifyForm.do" -> { // 글 수정 폼 출력하기
                boardService.getBoardView(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/modifyForm.jsp");
                requestDispatcher.forward(req, resp);
                break;
            }
            case "/boardController/boardModifyAction.do" -> { // 글 수정하기
                boardService.modifyBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
            case "/boardController/boardRemoveAction.do" -> { // 글 수정하기
                boardService.removeBoard(req);
                resp.sendRedirect("./boardList.do");
                break;
            }
        }
    }



}
