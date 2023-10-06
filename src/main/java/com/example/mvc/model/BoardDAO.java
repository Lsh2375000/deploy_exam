package com.example.mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.example.mvc.database.DBConnection;

public class BoardDAO {
	// 싱글톤 타입으로 작성
	private static BoardDAO instance;
	
	private BoardDAO() {
		
	}
	
	public static BoardDAO getInstance() {
		if(instance == null)
			instance = new BoardDAO();
		return instance;
	}
	
	public int getListCount(String items, String text) {
		// board 테이블의 전체 레코드 개수 반환
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		int cnt = 0;
		
		String sql;
		
		if(items == null || text == null) { // 검색어가 없는 경우
			sql = "SELECT count(*) FROM board";
		}
		else {
			sql = "SELECT count(*) FROM board WHERE " + items + " LIKE '%" + text + "%'";
		}
		
		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) { // 데이터가 없는 경우
				cnt = resultSet.getInt(1);
			}
		} catch (Exception ex) {
			System.out.println("getListCount() 에러 : " + ex);
		} finally {
			try {
				if(resultSet != null)
					resultSet.close();
				if(preparedStatement != null)
					preparedStatement.close();
				if(connection != null)
					connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		
		return cnt;
		
		
	} 
	
	
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		int start = (page - 1) * limit;
		String sql;
		if(items == null && text == null) {
			sql = "SELECT * FROM board ORDER BY num DESC";
		}
		else {
			sql = "SELECT * FROM board WHERE " + items + " LIKE '%" + text + "%' ORDER BY num DESC";
		}
		
		sql += " LIMIT " + start + ", " + limit;
		
		ArrayList<BoardDTO> list = new ArrayList<>();
		
		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				BoardDTO board = new BoardDTO();
				board.setNum(resultSet.getInt("num"));
				board.setMemberId(resultSet.getString("memberId"));
				board.setName(resultSet.getString("name"));
				board.setSubject(resultSet.getString("subject"));
				board.setContent(resultSet.getString("content"));
				board.setAddDate(resultSet.getString("addDate"));
				board.setHit(resultSet.getInt("hit"));
				board.setIp(resultSet.getString("ip"));
				list.add(board);
			}
			return list;
			
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			try {
				if(resultSet != null)
					resultSet.close();
				if(preparedStatement != null)
					preparedStatement.close();
				if(connection != null)
					connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		
		return null;
		
	}
	
	public void insertBoard(BoardDTO board) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = DBConnection.getConnection();

			String sql = "INSERT INTO board (memberId, name, subject, content, hit, ip, addDate) " +
					" VALUES (?, ?, ?, ?, ?, ?, now())";

			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, board.getMemberId());
			preparedStatement.setString(2, board.getName());
			preparedStatement.setString(3, board.getSubject());
			preparedStatement.setString(4, board.getContent());
			preparedStatement.setInt(5, board.getHit());
			preparedStatement.setString(6, board.getIp());
			preparedStatement.executeUpdate();
		}catch (Exception ex) {
			System.out.println("inertBoard() 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex);
			}
		}
	}

	private void updateHit(int num) { // 선택된 글의 조회수 증가
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = DBConnection.getConnection();

			String sql = "UPDATE board SET hit = hit + 1 WHERE num = ?"; // 누르면 해당 글번호(num)의 조회수(hit)을 1증가
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1,num);
			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateHit 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (connection != null)
					connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	public BoardDTO getBoardByNum(int num) {
		// 글 상세 페이지 불러오기
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		BoardDTO board = null;

		updateHit(num);
		String sql = "SELECT * FROM board WHERE num = ?";
		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, num);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				board = new BoardDTO();
				board.setNum(resultSet.getInt("num"));
				board.setMemberId(resultSet.getString("memberId"));
				board.setName(resultSet.getString("name"));
				board.setSubject(resultSet.getString("subject"));
				board.setContent(resultSet.getString("content"));
				board.setHit(resultSet.getInt("hit"));
				board.setIp(resultSet.getString("ip"));
			}
			return board;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (preparedStatement != null)
					preparedStatement.close();
				if (connection != null)
					connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return board;
	}

	public void updateBoard(BoardDTO board) { // 선택된 글의 내용 수정
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			String sql = "UPDATE board SET name=?, subject=?, content=? WHERE num=?";
			// 누르면 해당 글번호(num)의 상세내용을 가져와서 글수정폼에 출력

			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);

			preparedStatement.setString(1, board.getName());
			preparedStatement.setString(2, board.getSubject());
			preparedStatement.setString(3, board.getContent());
			preparedStatement.setInt(4, board.getNum());

			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateBoard 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (connection != null)
					connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	public void deleteBoard(int num) {
		// 선택된 글 삭제하기
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String sql = "DELETE FROM board WHERE num = ?";

		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, num);
			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (connection != null)
					connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

}
	
	
	



