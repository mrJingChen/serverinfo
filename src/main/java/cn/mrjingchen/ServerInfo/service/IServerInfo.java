package cn.mrjingchen.ServerInfo.service;

import java.util.List;
import cn.mrjingchen.ServerInfo.model.ServerInfo;

/**
 * <p>Description: </p>
 * @author charles·chen
 * @version v1.0
 */
public interface IServerInfo {
    
    /**
     * 列表查询
     * @version v1.0
     * @param pageNum 当前页
     * @param pageSize 每页条数
     * @return
     */
    List<ServerInfo> listSelect(Integer pageNum, Integer pageSize);
    
    /**
     * 列表关键字查询
     * @version v1.0
     * @param pageNum 当前页
     * @param pageSize 每页条数
     * @param keyword 任意关键字
     * @return
     */
    List<ServerInfo> listSelectKeyword(Integer pageNum, Integer pageSize, String keyword);
    
    /**
     * 添加服务
     * @version v1.0
     * @param serverInfo
     * @return
     */
    Integer addServerInfo(ServerInfo serverInfo);
    
    /**
     * 更新服务
     * @version v1.0
     * @param serverInfo
     * @return
     */
    Integer updateServerInfo(ServerInfo serverInfo);
}
