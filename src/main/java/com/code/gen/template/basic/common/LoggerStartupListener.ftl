package ${packagePrefix}.common;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.lang3.StringUtils;
import org.w3c.dom.Document;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.spi.LoggerContextListener;
import ch.qos.logback.core.Context;
import ch.qos.logback.core.spi.ContextAwareBase;
import ch.qos.logback.core.spi.LifeCycle;

/**
 * ####auto generate.
 *
 */
public class LoggerStartupListener extends ContextAwareBase implements LoggerContextListener,LifeCycle {

	private boolean started;
	
	public LoggerStartupListener() {
	}
	
	@Override
	public boolean isResetResistant() {
		return false;
	}
	
	private void setLoggerPath() {
		if(this.started) {
			return;
		}
		this.started = true;
		Context context = getContext();
		context.putProperty("TOMCAT_PORT", getLoggerPortPath());
	}
	
	private String getLoggerPortPath() {
		String result = "18080";
		File serverXml = new File(System.getProperty("catalina.home") + "/conf/server.xml");
		try {
			DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
			domFactory.setNamespaceAware(true);
			DocumentBuilder builder = domFactory.newDocumentBuilder();
			Document doc = builder.parse(serverXml);
			XPathFactory factory = XPathFactory.newInstance();
			XPath xpath = factory.newXPath();
			XPathExpression expr = xpath
					.compile("/Server/Service[@name='Catalina']/Connector[count(@scheme)=0]/@port[1]");
			result = (String) expr.evaluate(doc, XPathConstants.STRING);
		} catch (Exception e) {
			result = "18080";
		}
		return StringUtils.isBlank(result) ? "18080" : result;
	}

	@Override
	public void onStart(LoggerContext context) {
		setLoggerPath();
	}

	@Override
	public void onReset(LoggerContext context) {
		setLoggerPath();		
	}

	@Override
	public void onStop(LoggerContext context) {
		setLoggerPath();		
	}

	@Override
	public void onLevelChange(Logger logger, Level level) {
		setLoggerPath();
	}

	@Override
	public void start() {
		setLoggerPath();		
	}

	@Override
	public void stop() {
		setLoggerPath();
	}

	@Override
	public boolean isStarted() {
		return this.started;
	}
}
