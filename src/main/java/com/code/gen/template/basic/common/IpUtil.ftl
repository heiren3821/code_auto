package ${packagePrefix}.common.util;

import java.net.InterfaceAddress;
import java.net.NetworkInterface;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class IpUtil {
	
	private static Logger logger = LoggerFactory.getLogger(IpUtil.class);

	/**
	 * 获得客户端Ip.
	 *
	 * @param request
	 * @return
	 */
	public static String getClientIp(final HttpServletRequest request) {
		try {
			//alway use x real ip agent. others useless.
			String ip = request.getHeader("X-Real-IP");
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			} 
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("x-forwarded-for");
			} 
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
			} 
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
			} 
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
			// 多级反向代理
			if (null != ip && !"".equals(ip.trim())) {
				StringTokenizer st = new StringTokenizer(ip, ",");
				String ipTmp = "";
				if (st.countTokens() > 1) {
					while (st.hasMoreTokens()) {
						ipTmp = st.nextToken();
						if (ipTmp != null && ipTmp.length() != 0 && !"unknown".equalsIgnoreCase(ipTmp)) {
							ip = ipTmp;
							break;
						}
					}
				}
			}
			return ip;
		} catch (Exception e) {
			return "";
		}
	}

	public static boolean checkIpRangeContainIp(String ipRange,String srcIp){
		boolean pass = false;
		try{
			String[] ips = ipRange.split("-");
			String[] ip1 = ips[0].split("\\.");
			String[] ip2 = ips[1].split("\\.");
			String[] ip  = srcIp.split("\\.");
			//ip段的前3位都相同
			if (ip1[0].equals(ip2[0])
					&& ip1[1].equals(ip2[1])
					&& ip1[2].equals(ip2[2]) ){
				//比较源ip和ip段中的任意一个ip的前三位是否相同
				if (ip1[0].equals(ip[0])
						&& ip1[1].equals(ip[1])
						&& ip1[2].equals(ip[2]) ){
					//前3位相同后，比较最后一位
					if (Integer.valueOf(ip1[3]).intValue() < Integer.valueOf(ip2[3]).intValue()){
						if (Integer.valueOf(ip[3]).intValue() >=  Integer.valueOf(ip1[3]).intValue()
								&& Integer.valueOf(ip[3]).intValue() <=  Integer.valueOf(ip2[3]).intValue()){
							return true;
						}else{
							return false;
						}
					}else{
						return false;
					}


				}else{
					return false;
				}

			}

		}catch(Exception e){
			e.printStackTrace();
		}
		return pass;
	}

	public static String getServerIp(final HttpServletRequest request){
		return request.getLocalAddr();
	}

	public static List<String> getLocalIps() {
		List<String> ips = new ArrayList<String>();
		try {
			Enumeration<NetworkInterface> e = NetworkInterface.getNetworkInterfaces();
			while (e.hasMoreElements()) {
				List<InterfaceAddress> interfaceAddresss = e.nextElement().getInterfaceAddresses();
				for(InterfaceAddress address :interfaceAddresss) {
					ips.add(address.getAddress().getHostAddress());
				}
			}
		} catch (Exception e) {
			logger.error("get ips error.", e);
		}
		return ips;
	}
	
	
	public static void main(String[] args) {
		System.out.println(getLocalIps());
	}
}
