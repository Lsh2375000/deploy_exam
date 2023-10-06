package com.example.mvc.controller;

import com.example.mvc.model.RippleDTO;
import com.example.mvc.service.RippleService;
import lombok.extern.log4j.Log4j2;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@Log4j2
@WebServlet("/ripple/*")
public class RippleController extends HttpServlet {
    RippleService rippleService = RippleService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String RequestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String command = RequestURI.substring(contextPath.length());

        log.info("command : " + command);
        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("utf-8");
    switch (command) {
        case "/ripple/add":
            try {
                JSONObject jsonObject = new JSONObject(); // json 정보를 담기 위해 객체 생성
                // 성공, 실패의 결과를 json에 저장
                if (rippleService.addRipple(req)) {
                    jsonObject.put("result", "true");
                } else {
                    jsonObject.put("result", "false");
                }
                resp.getWriter().println(jsonObject.toJSONString());
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            break;
        case "/ripple/get":
            try {
                List<RippleDTO> rippleDTOS = rippleService.getRipples(req);
                // collection List를 json으로 변환.
                JSONArray jsonArray = new JSONArray(); // 목록을 저장해야 되서 JSONArray 사용.
                for (RippleDTO rippleDTO : rippleDTOS) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("rippleId", rippleDTO.getRippleId());
                    jsonObject.put("name", rippleDTO.getName());
                    jsonObject.put("content", rippleDTO.getContent());
                    jsonObject.put("insertDate", rippleDTO.getInsertDate());
                    jsonObject.put("ip", rippleDTO.getIp());
                    jsonObject.put("isLogin", rippleDTO.isLogin());
                    jsonArray.add(jsonObject);
                }
                resp.getWriter().print(jsonArray.toJSONString());
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            break;
        case "/ripple/remove":
            try {
                JSONObject jsonObject = new JSONObject();
                if (rippleService.removeRipple(req)) {
                    jsonObject.put("result", "true");
                } else {
                    jsonObject.put("result", "false");
                }
                resp.getWriter().println(jsonObject.toJSONString());
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            break;
    }

    }


}
