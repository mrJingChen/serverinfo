package cn.mrjingchen.ServerInfo.exception;

import javax.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.mrjingchen.ServerInfo.vo.Result;
import lombok.extern.slf4j.Slf4j;

/**
 * <p>Description: 全局异常</p>
 * @author charles·chen
 * @version v2.0
 */
@Slf4j
@ControllerAdvice
public class GlobalExceptionHandle {
    
    @ResponseBody
    @ExceptionHandler
    public Object handleException(Exception ex, HttpServletResponse reponse){
         log.error("---->Global Exception: "+ex.getMessage(), ex);
         return new Result<>(500, "服务器异常了", ex.toString());
    }
    
}
