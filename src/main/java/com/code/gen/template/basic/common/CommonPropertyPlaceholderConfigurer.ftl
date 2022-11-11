package ${packagePrefix}.common.config;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.util.DefaultPropertiesPersister;
import org.springframework.util.PropertiesPersister;

import ${packagePrefix}.common.util.PropertyUtil;

public class CommonPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
	private static final Logger logger = LoggerFactory.getLogger(CommonPropertyPlaceholderConfigurer.class);

	private Resource[] locations;

	private boolean ignoreResourceNotFound = false;

	private String fileEncoding = "UTF-8";

	private PropertiesPersister propertiesPersister = new DefaultPropertiesPersister();
	
	private String filePath[];
	

	public void setLocation(Resource location) {
		this.locations = new Resource[] { location };
	}
	
	public void setFileEncoding(String fileEncoding) {
		this.fileEncoding = fileEncoding;
	}

	public void setLocations(Resource... locations) {
		this.locations = locations;
	}

	public void setFilePath(String... filePath) {
		this.filePath = filePath;
	}

	public void loadProperties(Properties props) throws IOException {

		Resource[] srcRes;
		if(filePath != null){
			srcRes = new Resource[filePath.length];
			for(int i = 0 ;i < filePath.length; i ++){
				srcRes[i] = new FileSystemResource(filePath[i]);
			}
		}else{
			srcRes = new Resource[]{};
		}

		if (this.locations != null) {

			Resource[] appRess = Arrays.copyOf(srcRes, this.locations.length + 1);

			System.arraycopy(this.locations, 0, appRess, 1, this.locations.length);
			this.locations = appRess;
		} else {
			this.locations = srcRes;
		}

		for (Resource location : this.locations) {
			if (logger.isInfoEnabled()) {
				logger.info("Loading properties file from " + location);
			}
			InputStream is = null;
			try {
				is = location.getInputStream();

				String filename = null;
				try {
					filename = location.getFilename();
				} catch (IllegalStateException ex) {
					// resource is not file-based. See SPR-7552.
				}

				if (filename != null && filename.endsWith(".xml")) {
					this.propertiesPersister.loadFromXml(props, is);
				} else {
					if (this.fileEncoding != null) {
						this.propertiesPersister.load(props, new InputStreamReader(is, this.fileEncoding));
					} else {
						this.propertiesPersister.load(props, is);
					}
				}
			} catch (IOException ex) {
				if (this.ignoreResourceNotFound) {
					logger.error("Could not load properties from " + location + ": " + ex.getMessage());
				} else {
					throw ex;
				}
			} finally {
				if (is != null) {
					is.close();
				}
			}
		}
		//把属性值设置到自定义的系统属性值中
		PropertyUtil.copyProperties(props);

	}

}
