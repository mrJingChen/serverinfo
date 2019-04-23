package cn.mrjingchen.ServerInfo.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import cn.mrjingchen.ServerInfo.model.ServerInfo;

/**
 * <p>Description: </p>
 * @author charles·chen
 * @version v1.0
 */
@Mapper
public interface ServerInfoMapper {
    
    /**
     * 列表查询
     * @version v1.0
     * @return
     */
    List<ServerInfo> listSelect();
    
    /**
     * 列表关键字查询
     * @version v1.0
     * @param keyword 任意关键字
     * @return
     */
    List<ServerInfo> listSelectKeyword(@Param("keyword") String keyword);
    
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
