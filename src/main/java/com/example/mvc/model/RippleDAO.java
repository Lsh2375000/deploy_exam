package com.example.mvc.model;

import com.example.mvc.database.DBConnection;
import lombok.Cleanup;
import lombok.extern.log4j.Log4j2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Log4j2
public class RippleDAO {
    private static RippleDAO instance;

    private RippleDAO() {

    }

    public static RippleDAO getInstance() {
        if (instance == null) {
            instance = new RippleDAO();
        }
        return instance;
    }

    public boolean insertRipple(RippleDTO rippleDTO) throws SQLException, ClassNotFoundException {
        log.info("insertRipple() ...");

        String sql = "INSERT INTO ripple VALUES (null, ?, ?, ?, ?, now(), ?)";
        @Cleanup Connection connection = DBConnection.getConnection();
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, rippleDTO.getBoardNum());
        preparedStatement.setString(2, rippleDTO.getMemberId());
        preparedStatement.setString(3, rippleDTO.getName());
        preparedStatement.setString(4, rippleDTO.getContent());
        preparedStatement.setString(5, rippleDTO.getIp());
        return preparedStatement.executeUpdate() == 1;
    }


    public List<RippleDTO> selectRipples(int boardNum) throws SQLException, ClassNotFoundException {
        log.info("selectRipple()...");

        List<RippleDTO> rippleDTOS = new ArrayList<>();
        String sql = "SELECT * FROM `ripple` WHERE `boardNum` = ?";

        @Cleanup Connection connection = DBConnection.getConnection();
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, boardNum);
        @Cleanup ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            RippleDTO rippleDTO = RippleDTO.builder()
                    .rippleId(resultSet.getInt("rippleId"))
                    .memberId(resultSet.getString("memberId"))
                    .name(resultSet.getString("name"))
                    .content(resultSet.getString("content"))
                    .insertDate(resultSet.getString("insertDate"))
                    .ip(resultSet.getString("ip")).build();
            rippleDTOS.add(rippleDTO);
        }
        return rippleDTOS;
    }

    public boolean deleteRipple(int rippleId) throws SQLException, ClassNotFoundException {
        log.info("deleteRipple()...");
        String sql = "DELETE FROM `ripple` WHERE `rippleId` = ?";

        @Cleanup Connection connection = DBConnection.getConnection();
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, rippleId);

        return preparedStatement.executeUpdate() == 1;
    }

}
