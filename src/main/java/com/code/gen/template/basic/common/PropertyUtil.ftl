package ${packagePrefix}.common.util;

import java.util.Properties;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;

/**
 * 从配置文件获取系统参数
 *
 */
public final class PropertyUtil {
	
	private static Properties o2oProperties = new Properties();

	public final static String getStringProp(String key) {
		return o2oProperties.getProperty(key);
	}

	/**
	 * 获取属性的值，如果不存在，则返回默认的值。
	 *
	 * @param key
	 * @param defaultVal
	 * @return
	 */
	public final static String getStringProp(String key, String defaultVal) {
		String strPro = getStringProp(key);
		return StringUtils.isBlank(strPro) ? defaultVal : strPro;
	}

	public final static int getIntProp(String key) {
		String val = getStringProp(key);
		return NumberUtils.toInt(val);
	}

	/**
	 * 获取整型属性的值，如果属性不存在或者类型错误，则返回默认值。
	 *
	 * @param key
	 * @param defaultVal
	 * @return
	 */
	public final static int getIntProp(String key, int defaultVal) {
		String strInt = getStringProp(key);
		return StringUtils.isBlank(strInt) ? defaultVal : NumberUtils.toInt(strInt);
	}

	public final static long getLongProp(String key) {
		String val = getStringProp(key);
		return NumberUtils.toLong(val);
	}

	public final static boolean getBooleanProp(String key) {
		String val = getStringProp(key);
		return Boolean.valueOf(val);
	}

	public final static boolean getBooleanProp(String key, boolean defaultVal) {
		String val = getStringProp(key);
		return StringUtils.isBlank(val) ? defaultVal : Boolean.valueOf(val);
	}

	/**
	 * 获取Long类型属性的值，如果属性不存在或者类型错误，则返回默认值。
	 *
	 * @param key
	 * @param defaultVal
	 * @return
	 */
	public final static long getLongProp(String key, long defaultVal) {
		String strLong = getStringProp(key);
		return StringUtils.isBlank(strLong) ? defaultVal : NumberUtils.toInt(strLong);
	}

	public static void copyProperties(Properties props){
		Set<Object> keySet = props.keySet();
		for(Object key : keySet){
			o2oProperties.setProperty(key.toString(),props.getProperty(key.toString()));
		}
	}


}
