package dao;

import com.example.mvc.model.BoardDAO;
import com.example.mvc.model.BoardDTO;
import org.junit.jupiter.api.Test;

public class BoardTests {
    @Test
    public void testBoardInsert(){
        BoardDAO boardDAO = BoardDAO.getInstance();
        BoardDTO boardDTO = new BoardDTO();
        boardDTO.setMemberId("test");
        boardDTO.setSubject("제목");
        boardDTO.setContent("내용");
        boardDTO.setName("작성자");
        boardDTO.setHit(1);
        boardDTO.setIp("0.0.0.0.0.1");
        boardDTO.setAddDate("2020-01-01");
        boardDAO.insertBoard(boardDTO);
    }
    @Test // 아래의 메소드는 테스트 코드라는 것을 알려주는 어노테이션
    public void testGetBoardByNum() { // board의 해당 글번호의 글속성을 들고오는 테스트 코드
        // 테스트 메소드는 public void로 시작하고 매개변수를 선언하지 않음.
        int num = 1; // 테이블에 존재하는 primary key.

        BoardDAO boardDAO = BoardDAO.getInstance();
        BoardDTO boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO);

    }

    @Test
    public void testCode() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        for (int i = 0; i < 101; i++) {
            BoardDTO boardDTO = new BoardDTO();
            boardDTO.setMemberId("test" + i);
            boardDTO.setSubject("제목" + i);
            boardDTO.setContent("내용" + i);
            boardDTO.setName("작성자" + i);
            boardDTO.setHit(0);
            boardDTO.setIp("0.0.0.0.0.1");
            boardDTO.setAddDate("2020-01-01");
            boardDAO.insertBoard(boardDTO);
        }
    }

    @Test
    public void testUpdateBoard() {
        // 변경전 데이터 출력 후 변경후 데이터 출력
        int num = 293; // 테이블에 존재하는 primary key.
        BoardDAO boardDAO = BoardDAO.getInstance();

        // 변경전 데이터 출력
        BoardDTO boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO);

        // 변경
        BoardDTO board= new BoardDTO();
        board.setNum(num);
        board.setSubject("수정제목");
        board.setContent("수정내용");
        board.setName("수정작성자");
        boardDAO.updateBoard(board);

        // 변경후 데이터 출력
        boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO);

    }

    @Test
    public void testDeleteBoard() {
        int num = 293; // 테이블에 존재하는 primary key.
        BoardDAO boardDAO = BoardDAO.getInstance();

        // 삭제전 데이터 출력
        BoardDTO boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO);

        // 삭제
        boardDAO.deleteBoard(num);

        // 변경후 데이터 출력
        boardDTO = boardDAO.getBoardByNum(num);
        System.out.println(boardDTO);

    }

}
