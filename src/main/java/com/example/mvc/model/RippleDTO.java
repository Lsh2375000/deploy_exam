package com.example.mvc.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RippleDTO {
    private Integer rippleId;
    private Integer boardNum;
    private String memberId;
    private String name;
    private String content;
    private String insertDate;
    private String ip;
    private boolean isLogin;
}
