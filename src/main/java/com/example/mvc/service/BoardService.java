package com.example.mvc.service;

import com.example.mvc.model.BoardDAO;
import com.example.mvc.model.BoardDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

public class BoardService {
    static final int LISTCOUNT = 5;
    private static BoardService instance;

    private BoardService() {

    }

    public static BoardService getInstance() {
        if (instance == null)
            instance = new BoardService();
        return instance;

    }

    public void requestBoardList(HttpServletRequest request) {
        // 등록된 글 목록 가져오기
        BoardDAO dao = BoardDAO.getInstance();
        List<BoardDTO>boardList;

        int pageNum = 1; // 페이지 번호의 기본값
        int limit = LISTCOUNT; // 페이지당 게시물 수
        if (request.getParameter("pageNum") !=null ) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }

        String items = request.getParameter("items"); // 검색어
        String text = request.getParameter("text");

        int totalRecord = dao.getListCount(items,text); // 전체 게시물 수
        boardList = dao.getBoardList(pageNum,limit,items,text);

        int totalPage; // 전체 페이지 계산
        if (totalRecord % limit == 0) {
            totalPage = totalRecord/limit;
            Math.floor(totalPage);
        }
        else {
            totalPage = totalRecord/limit;
            Math.floor(totalPage);
            totalPage = totalPage +1;
        }

        // 페이지 시작 일련 번호 작업
        int startNum = totalRecord - (pageNum - 1) * limit;
        System.out.println("startNum : " + startNum);


        request.setAttribute("pageNum", pageNum);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalRecord", totalRecord);
        request.setAttribute("boardList", boardList);
        request.setAttribute("startNum", startNum);
    }

    public void addBoard(HttpServletRequest request) {
        BoardDAO dao = BoardDAO.getInstance();
        HttpSession session = request.getSession();
        BoardDTO board = new BoardDTO();
        board.setMemberId((String) session.getAttribute("sessionMemberId"));
        board.setName(request.getParameter("name"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));

        System.out.println(request.getParameter("name"));
        System.out.println(request.getParameter("subject"));
        System.out.println(request.getParameter("content"));

        board.setHit(0);
        board.setIp(request.getRemoteAddr());

        dao.insertBoard(board);

    }// 새로운 글 등록 하기


    public void getBoardView(HttpServletRequest request) {
        // 선택된 글 상세 페이지 가져오기
        BoardDAO dao = BoardDAO.getInstance();
        int num = Integer.parseInt(request.getParameter("num"));
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));

        BoardDTO board = dao.getBoardByNum(num);

        request.setAttribute("pageNum", pageNum);
        request.setAttribute("board", board);
    }


    public void modifyBoard(HttpServletRequest request) {
        // 선택된 글 내용 수정하기
        // request로 넘어온 값을 BoardDTO 객체에 저장해서 DAO에 전달
        int num = Integer.parseInt(request.getParameter("num"));

        BoardDAO dao = BoardDAO.getInstance();

        BoardDTO board = new BoardDTO();
        board.setNum(num);
        board.setName(request.getParameter("name"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));

        dao.updateBoard(board);
    }

    public void removeBoard(HttpServletRequest request) {
        int num = Integer.parseInt(request.getParameter("num"));

        BoardDAO dao = BoardDAO.getInstance();
        dao.deleteBoard(num);
    }

}
