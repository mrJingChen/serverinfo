package cn.mrjingchen.ServerInfo.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.github.pagehelper.PageHelper;
import cn.mrjingchen.ServerInfo.mapper.ServerInfoMapper;
import cn.mrjingchen.ServerInfo.model.ServerInfo;
import cn.mrjingchen.ServerInfo.service.IServerInfo;

@Service
public class ServerInfoImpl implements IServerInfo {
    
    @Autowired
    private ServerInfoMapper serverInfoMapper;
    
    @Override
    public List<ServerInfo> listSelect(Integer pageNum, Integer pageSize) {
        /** 分页 */
        PageHelper.startPage(pageNum, pageSize);
        return serverInfoMapper.listSelect();
    }

    @Override
    public List<ServerInfo> listSelectKeyword(Integer pageNum, Integer pageSize, String keyword) {
        PageHelper.startPage(pageNum, pageSize);
        return serverInfoMapper.listSelectKeyword(keyword);
    }

    @Override
    public Integer addServerInfo(ServerInfo serverInfo) {
        return serverInfoMapper.addServerInfo(serverInfo);
    }

    @Override
    public Integer updateServerInfo(ServerInfo serverInfo) {
        return serverInfoMapper.updateServerInfo(serverInfo);
    }


}
