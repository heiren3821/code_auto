package ${packagePrefix}.common.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpHost;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;

/**
 * HTTP Client 请求工具
 * @author jiangchunhong
 *
 */
public class HttpClientUtil {

	private static final Logger log = LoggerFactory.getLogger(HttpClientUtil.class);
    private static String HOST = PropertyUtil.getStringProp("sso.http.proxy.host");
    private static int PORT = PropertyUtil.getIntProp("sso.http.proxy.port");
	
	//设置连接超时时间 milliseconds
	public static final int CONNECTION_TIMEOUT = 3 * 1000;
	// 设置等待数据超时时间3秒钟
	private static final int SO_TIMEOUT = 3 * 1000;
	
	/**
	 * http get
	 * @param url
	 * @param paramMap
	 * @param charset
	 * @return
	 */
	public static String sendGet(String url,Map<String,String> paramMap,String charset){
		return get(url,paramMap,charset,null);
	}
	
	public static String getAutoProxy(String url) {
		if (StringUtils.isBlank(HOST)) {
			return sendGet(url, null, "UTF-8");
		} else {
			return sendPorxyGet(url, null, "UTF-8", HOST, PORT);
		}
	}
	
	/**
	 * http get 代理模式
	 * @param url
	 * @param paramMap
	 * @param charset
	 * @param proxyHost
	 * @param proxyPort
	 * @return
	 */
	public static String sendPorxyGet(String url,Map<String,String> paramMap,String charset,String proxyHost,int proxyPort){
		HttpHost proxy = new HttpHost(proxyHost,proxyPort);
		return get(url, paramMap, charset, proxy);
	}
	
	private static String get(String url,Map<String,String> paramMap,String charset,HttpHost proxy){
		CloseableHttpClient httpClient = null;
		CloseableHttpResponse response = null;
		try{
			RequestConfig config = getConfig(proxy);
			httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
			
			if(paramMap != null && !paramMap.isEmpty()){
				List<NameValuePair> nvp = new ArrayList<>();
				for(Map.Entry<String, String> entry : paramMap.entrySet()){
					nvp.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
				}
				String param = URLEncodedUtils.format(nvp, charset);
				url = url.contains("?") ? url + "&" + param : url + "?" + param;
			}
			
			HttpGet httpGet = new HttpGet(url);
			if(log.isDebugEnabled()){
				log.debug("url={}",url);
			}
			response = httpClient.execute(httpGet);
			int status = response.getStatusLine().getStatusCode();
			if(HttpStatus.SC_OK == status){
				return EntityUtils.toString(response.getEntity(),charset);
			}else{
				log.error("http client get method error ,return code = {},url = {}", status,url);
			}
		}catch(Exception e){
			log.error("http client get method error!url = {}",url,e);
		}finally{
			HttpClientUtils.closeQuietly(response);
			HttpClientUtils.closeQuietly(httpClient);
		}
		return null;
	}
	
	public static String postJSONProxy(String url, Map<String, String> paramMap) {
		CloseableHttpClient httpClient = null;
		CloseableHttpResponse response = null;
		try {
			HttpHost proxy = StringUtils.isNotBlank(HOST) ? new HttpHost(HOST, PORT) : null;
			RequestConfig config = getConfig(proxy);
			httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
			HttpPost httpPost = new HttpPost(url);
			if (paramMap != null && !paramMap.isEmpty()) {
				httpPost.setEntity(new StringEntity(JSONObject.toJSONString(paramMap), ContentType.APPLICATION_JSON));
			}
			response = httpClient.execute(httpPost);
			int status = response.getStatusLine().getStatusCode();
			if (HttpStatus.SC_OK == status) {
				return EntityUtils.toString(response.getEntity(), "UTF-8");
			} else {
				log.error("http client post method error ,return code = {},url = {}", status, url);
			}
		} catch (Exception e) {
			log.error("http client post method error!url = {}", url, e);
		} finally {
			HttpClientUtils.closeQuietly(response);
			HttpClientUtils.closeQuietly(httpClient);
		}
		return "";
	}
	
	/**
	 * http post
	 * @param url
	 * @param paramMap
	 * @param charset
	 * @return
	 */
	public static String sendPost(String url,Map<String,String> paramMap,String charset){
		return post(url, paramMap, charset, null);
	}
	
	/**
	 * http post 代理模式
	 * @param url
	 * @param paramMap
	 * @param charset
	 * @param proxyHost
	 * @param proxyPort
	 * @return
	 */
	public static String sendProxyPost(String url,Map<String,String> paramMap,String charset,String proxyHost,int proxyPort){
		HttpHost proxy = new HttpHost(proxyHost, proxyPort);
		return post(url,paramMap,charset,proxy);
	}
	
	private static String post(String url,Map<String,String> paramMap,String charset,HttpHost proxy){
		CloseableHttpClient httpClient = null;
		CloseableHttpResponse response = null;
		try{
			RequestConfig config = getConfig(proxy);
			httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
			HttpPost httpPost = new HttpPost(url);
			
			if(paramMap != null && !paramMap.isEmpty()){
				List<NameValuePair> nvp = new ArrayList<>();
				for(Map.Entry<String, String> entry : paramMap.entrySet()){
					nvp.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
				}
				httpPost.setEntity(new UrlEncodedFormEntity(nvp,charset));
			}
			
			response = httpClient.execute(httpPost);
			int status = response.getStatusLine().getStatusCode();
			if(HttpStatus.SC_OK == status){
				return EntityUtils.toString(response.getEntity(),charset);
			}else{
				log.error("http client post method error ,return code = {},url = {}", status,url);
			}
		}catch(Exception e){
			log.error("http client post method error!url = {}",url,e);
		}finally{
			HttpClientUtils.closeQuietly(response);
			HttpClientUtils.closeQuietly(httpClient);
		}
		return null;
	}
	
	private static RequestConfig getConfig(HttpHost httpProxy){
		RequestConfig.Builder build = RequestConfig.custom();
		build.setConnectTimeout(CONNECTION_TIMEOUT);
		build.setSocketTimeout(SO_TIMEOUT);
		if(httpProxy != null){
			build.setProxy(httpProxy);
		}
		return build.build();
	}

}
