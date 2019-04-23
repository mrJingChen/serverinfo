package cn.mrjingchen.ServerInfo.vo;

import lombok.Data;

/**
 * <p>Description: </p>
 * @author charles·chen
 * @version v1.0
 */
@Data
public class Result<T> {

    /** 响应码 */
    private Integer code;

    /** 响应信息 */
    private String message;

    /** 响应数据 */
    private T data;

    public Result(Integer code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public Result() {
    }
    
}
