package com.code.gen.process;

import com.code.gen.process.configuration.Config;

public class MainProcessor {

	public static void main(String[] args) {
		Config.setDefFileName("BeanInfo.txt");
		ProjectProcessor.handle();
	}
}
