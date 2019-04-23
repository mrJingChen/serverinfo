package cn.mrjingchen.ServerInfo.model;

import lombok.Data;

/**
 * <p>Description: </p>
 * @author charles·chen
 * @version v1.0
 */
@Data
public class ServerInfo {
    
    /**
     * 服务信息主键
     */
    private Integer siId;
    
    /**
     * 服务端口
     */
    private Integer siPort;
    
    /**
     * 服务名称
     */
    private String siName;
    
    /**
     * 服务作用
     */
    private String siPurpose;
    
    /**
     * 核心配置
     */
    private String siConf;
    
    /**
     * 维护者
     */
    private String siAuthor;
    
    /**
     * 当前状态
     */
    private String siStatus;
    
    /**
     * 创建时间
     */
    private String siCreateTime;
    
    /**
     * 更新时间
     */
    private String siUpdateTime;
    
}
