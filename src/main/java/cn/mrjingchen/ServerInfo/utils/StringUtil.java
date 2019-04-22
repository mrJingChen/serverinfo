package cn.mrjingchen.ServerInfo.utils;

import java.util.regex.Pattern;

/**
 * <p>Description: 字符串工具类</p>
 * @author charles·chen
 * @version v1.0
 */
public class StringUtil {
    
    /**
     * 判断字符串是否为整数
     * @version v1.0
     * @param str
     * @return
     */
    public static boolean isInteger(String str) {
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
        return pattern.matcher(str).matches();
    }
    
}
