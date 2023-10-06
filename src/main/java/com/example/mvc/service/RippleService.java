package com.example.mvc.service;

import com.example.mvc.model.RippleDAO;
import com.example.mvc.model.RippleDTO;
import lombok.extern.log4j.Log4j2;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

@Log4j2
public class RippleService {
    private static RippleService instance;

    private RippleService() {

    }

    public static RippleService getInstance() {
        if (instance == null) {
            instance = new RippleService();
        }
        return instance;
    }

    public boolean addRipple(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        log.info("addRipple() ...");
        RippleDAO rippleDAO = RippleDAO.getInstance();

        RippleDTO rippleDTO = RippleDTO.builder()
                .boardNum(Integer.valueOf(request.getParameter("num")))
                .memberId((String) request.getSession().getAttribute("sessionMemberId"))
                .name(request.getParameter("name"))
                .content(request.getParameter("content"))
                .ip(request.getRemoteAddr())
                .build();
        return rippleDAO.insertRipple(rippleDTO);
    }

    public List<RippleDTO> getRipples(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        log.info("getRipples() ...");

        RippleDAO rippleDAO = RippleDAO.getInstance();
        int num = Integer.parseInt(request.getParameter("num"));
        List<RippleDTO> rippleDTOS = rippleDAO.selectRipples(num);

        // 댓글 중 로그인한 사용자가 작성한 댓글이면 isLogin 값을 true로 변경
        for (RippleDTO rippleDTO : rippleDTOS) {
            log.info(rippleDTO.getMemberId());
            log.info(request.getSession().getAttribute("sessionMemberId"));
                // 댓글 작성자와 로그인한 사용자가 같은 경우.
            if (rippleDTO.getMemberId().equals(request.getSession().getAttribute("sessionMemberId"))) {
                rippleDTO.setLogin(true);
            }
        }
        return rippleDTOS;
    }


    public boolean removeRipple(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        log.info("removeRipple()...");


        RippleDAO rippleDAO = RippleDAO.getInstance();
        int rippleId = Integer.parseInt(request.getParameter("rippleId"));
        return rippleDAO.deleteRipple(rippleId);
    }
}
