package cn.mrjingchen.ServerInfo.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageSerializable;
import cn.mrjingchen.ServerInfo.model.ServerInfo;
import cn.mrjingchen.ServerInfo.service.impl.ServerInfoImpl;
import cn.mrjingchen.ServerInfo.utils.StringUtil;
import cn.mrjingchen.ServerInfo.vo.Result;
import cn.mrjingchen.ServerInfo.vo.ServerInfoVo;
import lombok.extern.slf4j.Slf4j;

/**
 * <p>Description: </p>
 * @author charles·chen
 * @version v2.0
 */
@Slf4j
@Controller
@RequestMapping
@CrossOrigin(allowCredentials = "true", maxAge = 3600)
public class PortsController {
    
    @Autowired
    private ServerInfoImpl serverInfoImpl;
    
    /**
     * 默认首页
     * @version v1.0
     * @param request
     * @param map
     * @return
     */
    @GetMapping
    public String index(HttpServletRequest request, Map<String, Object> map) {
        map.put("url", request.getRequestURL());
        log.info("---->index url:{}", map.get("url"));
        return "index";
    }
    
    @GetMapping("demo")
    public String demo() {
        return "demo";
    }
    
    /**
     * 1、默认加载查询列表（分页）
     * {@link http://127.0.0.1:8081/ports?pageNum=1&pageSize=5 }
     * @version v1.0
     * @param pageNum
     * @param pageSize
     * @return
     */
    @ResponseBody
    @GetMapping("serverInfo")
    public Result<PageSerializable<ServerInfoVo>> select(String pageNum, String pageSize) {
        pageSize = (null == pageSize || "".equals(pageSize.trim())) ? "10" : pageSize;
        log.info("---->serverInfo pageNum:{}, pageSize:{}", pageNum, pageSize);
        if(!StringUtil.isInteger(pageNum) || !StringUtil.isInteger(pageSize)){
            return new Result<>(400, "参数pageNum或pageSize非数值类型", null);
        }
        List<ServerInfo> listServerInfo = serverInfoImpl.listSelect(Integer.parseInt(pageNum), Integer.parseInt(pageSize));
        /** 初始化Page列表，带total的视图对象 */
        Page<ServerInfoVo> plotInfoVoList = new Page<ServerInfoVo>();
        if (listServerInfo instanceof Page) {
            plotInfoVoList.setTotal(((Page<ServerInfo>) listServerInfo).getTotal());
        }
        listServerInfo.stream().forEach( serverInfo -> {
            ServerInfoVo serverInfoVo = new ServerInfoVo();
            BeanUtils.copyProperties(serverInfo, serverInfoVo);
            plotInfoVoList.add(serverInfoVo);
            serverInfoVo = null;
        });
        /** 视图对象简化封装 */
        PageSerializable<ServerInfoVo> serverInfoVo = new PageSerializable<ServerInfoVo>(plotInfoVoList);
        return new Result<>(200, "成功", serverInfoVo);
    }
    
    /**
     * 2、关键词模糊查询列表（分页）
     * {@link http://127.0.0.1:8081/ports/keyword }
     * @version v2.0
     * @param pageNum
     * @param pageSize
     * @return
     */
    @ResponseBody
    @GetMapping("serverInfo/keyword")
    public Result<PageSerializable<ServerInfoVo>> search(String pageNum, String pageSize, @RequestParam("keyword") String keyword) {
        pageSize = (null == pageSize || "".equals(pageSize.trim())) ? "10" : pageSize;
        log.info("---->ports/keyword pageNum:{}, pageSize:{}, keyword:{}", pageNum, pageSize, keyword);
        if(!StringUtil.isInteger(pageNum) || !StringUtil.isInteger(pageSize)){
            return new Result<>(400, "参数pageNum或pageSize非数值类型", null);
        }
        List<ServerInfo> listServerInfo = null;
        if(null == keyword || "".equals(keyword.trim())){
            listServerInfo = serverInfoImpl.listSelect(Integer.parseInt(pageNum), Integer.parseInt(pageSize));
        }else {
            listServerInfo = serverInfoImpl.listSelectKeyword(Integer.parseInt(pageNum), Integer.parseInt(pageSize), keyword);
        }
        /** 初始化Page列表，带total的视图对象 */
        Page<ServerInfoVo> plotInfoVoList = new Page<ServerInfoVo>();
        if (listServerInfo instanceof Page) {
            plotInfoVoList.setTotal(((Page<ServerInfo>) listServerInfo).getTotal());
        }
        listServerInfo.stream().forEach( serverInfo -> {
            ServerInfoVo serverInfoVo = new ServerInfoVo();
            BeanUtils.copyProperties(serverInfo, serverInfoVo);
            plotInfoVoList.add(serverInfoVo);
            serverInfoVo = null;
        });
        /** 视图对象简化封装 */
        PageSerializable<ServerInfoVo> serverInfoVo = new PageSerializable<ServerInfoVo>(plotInfoVoList);
        return new Result<>(200, "成功", serverInfoVo);
    }
    
    /**
     * 添加和修改服务
     * @version v2.0
     * @param serverInfoVo
     * @return
     */
    @ResponseBody
    @PostMapping("serverInfo/edit")
    public Result<Integer> editServerInfo(@RequestBody ServerInfoVo serverInfoVo) {
        log.info("---->serverInfo/add-addServerInfo:{}", serverInfoVo);
        if(null == serverInfoVo || null == serverInfoVo.getSiPort() || 
                null == serverInfoVo.getSiName() || "".equals(serverInfoVo.getSiName().trim())){
            return new Result<>(400, "请求参数缺失, port和name不能为空", 0);
        }
        ServerInfo serverInfo = new ServerInfo();
        BeanUtils.copyProperties(serverInfoVo, serverInfo);
        Integer result = null;
        if(null != serverInfo.getSiId()){
            result = serverInfoImpl.updateServerInfo(serverInfo);
        }else {
            result = serverInfoImpl.addServerInfo(serverInfo);
        }
        if(null == result){
            return new Result<>(500, "数据保存0条", 0);
        }
        return new Result<>(200, "serverInfo/add-addServerInfo-成功", 1);
    }
    
} 
