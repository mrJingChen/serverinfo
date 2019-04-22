package cn.mrjingchen.ServerInfo.vo;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * <p>Description: </p>
 * @author charles·chen
 * @version v2.0
 */
@Data
@JsonAutoDetect(getterVisibility = JsonAutoDetect.Visibility.NONE)
public class ServerInfoVo {
    
    /**
     * 服务信息主键
     */
    @JsonProperty("id")
    private Integer siId;
    
    /**
     * 服务端口
     */
    @JsonProperty("port")
    private Integer siPort;
    
    /**
     * 服务名称
     */
    @JsonProperty("name")
    private String siName;
    
    /**
     * 服务作用
     */
    @JsonProperty("purpose")
    private String siPurpose;
    
    /**
     * 核心配置
     */
    @JsonProperty("conf")
    private String siConf;
    
    /**
     * 维护者
     */
    @JsonProperty("author")
    private String siAuthor;
    
    /**
     * 当前状态
     */
    @JsonProperty("status")
    private String siStatus;
    
    /**
     * 创建时间
     */
    @JsonProperty("createTime")
    private String siCreateTime;
    
    /**
     * 更新时间
     */
    @JsonProperty("updateTime")
    private String siUpdateTime;
    
}
