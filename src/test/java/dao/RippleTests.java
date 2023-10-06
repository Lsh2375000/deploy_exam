package dao;

import com.example.mvc.model.RippleDAO;
import com.example.mvc.model.RippleDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.List;

@Log4j2
public class RippleTests {

    private RippleDAO dao;

    @BeforeEach
    public void ready() {
        dao = RippleDAO.getInstance();
    }

    @Test
    public void testSelectRipples() throws SQLException, ClassNotFoundException {
        List<RippleDTO> rippleDTOList = dao.selectRipples(101); // ripple 테이블에 존재하는 boardNum
        log.info(rippleDTOList);

        // 테이블에서 들고 와야 될 개수를 확인 후에 결과값이 맞는지 확인하는 방법.
        Assertions.assertEquals(2,rippleDTOList.size());
    }

}
