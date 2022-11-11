package ${packagePrefix}.common.util;

import java.text.NumberFormat;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;




public class StringUtil {
	private static final char[] bcdLookup = { '0', '1', '2', '3', '4', '5',
			'6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

	public static boolean isNull(Object object) {
		if (object instanceof String) {
			return StringUtil.isEmpty(object.toString());
		}
		return object == null;
	}

	/**
	 * Checks if string is null or empty.
	 *
	 * @param value
	 *            The string to be checked
	 * @return True if string is null or empty, otherwise false.
	 */
	public static boolean isEmpty(final String value) {
		return value == null || value.trim().length() == 0;
//				|| "null".endsWith(value);
	}


	/**
	 * Converts <code>null</code> to empty string, otherwise returns it
	 * directly.
	 *
	 * @param string
	 * @return empty string if passed in string is null, or original string
	 *         without any change
	 */
	public static String null2String(Object obj) {
		return obj == null ? "" : obj.toString();
	}

	public static String null2String(String str) {
		return str == null ? "" : str;
	}

	/**
	 * Converts string from GB2312 encoding ISO8859-1 (Latin-1) encoding.
	 *
	 * @param gbString
	 *            The string of GB1212 encoding
	 * @return New string of ISO8859-1 encoding
	 */
	public static String iso2Gb(String gbString) {
		if (gbString == null)
			return null;
		String outString = "";
		try {
			byte[] temp = null;
			temp = gbString.getBytes("ISO8859-1");
			outString = new String(temp, "GB2312");
		} catch (java.io.UnsupportedEncodingException e) {
			// ignore it as no way to convert between these two encodings

		}
		return outString;
	}

	/**
	 * Converts string from ISO8859-1 encoding to UTF-8 encoding.
	 *
	 * @param isoString
	 *            String of ISO8859-1 encoding
	 * @return New converted string of UTF-8 encoding
	 */
	public static String iso2Utf(String isoString) {
		if (isoString == null)
			return null;
		String outString = "";
		try {
			byte[] temp = null;
			temp = isoString.getBytes("ISO8859-1");
			outString = new String(temp, "UTF-8");
		} catch (java.io.UnsupportedEncodingException e) {

		}
		return outString;
	}

	/**
	 * Converts string from platform default encoding to GB2312.
	 *
	 * @param inString
	 *            String in platform default encoding
	 * @return New string in GB2312 encoding
	 */
	public static String str2Gb(String inString) {
		if (inString == null)
			return null;
		String outString = "";
		try {
			byte[] temp = null;
			temp = inString.getBytes();
			outString = new String(temp, "GB2312");
		} catch (java.io.UnsupportedEncodingException e) {

		}
		return outString;
	}

	/**
	 * Insert "0" in front of <em>dealCode</em> if its length is less than 3.
	 *
	 * @param dealCode
	 *            The dealCode to be filled with "0" at the beginning
	 * @return New string with "0" filled
	 */
	public static String fillZero(String dealCode) {
		String zero = "";
		if (dealCode.length() < 3) {
			for (int i = 0; i < (3 - dealCode.length()); i++) {
				zero += "0";
			}
		}
		return (zero + dealCode);
	}

	public static String fillZero(String value, int len) {
		if (StringUtil.isNull(value) || len <= 0) {
			throw new IllegalArgumentException("参数不正确");
		}
		String zero = "";
		int paramLen = value.trim().length();
		if (paramLen < len) {
			for (int i = 0; i < len - paramLen; i++) {
				zero += "0";
			}
		}
		return (zero + value);
	}

	public static String convertAmount(String amount) {
		String str = String.valueOf(Double.parseDouble(amount));
		int pos = str.indexOf(".");
		int len = str.length();
		if (len - pos < 3) {
			return str.substring(0, pos + 2) + "0";
		} else {
			return str.substring(0, pos + 3);
		}
	}

	

	/**
	 * 数字转换为大写字母
	 *
	 * @param money
	 *            format example: 100.00
	 * @return
	 */
	public static String[] numToWords(String money) {
		int j = money.length();
		String[] str = new String[j];
		for (int i = 0; i < j; i++) {
			switch (money.charAt(i)) {
			case '0':
				str[i] = "零";
				continue;
			case '1':
				str[i] = "壹";
				continue;
			case '2':
				str[i] = "贰";
				continue;
			case '3':
				str[i] = "叁";
				continue;
			case '4':
				str[i] = "肆";
				continue;
			case '5':
				str[i] = "伍";
				continue;
			case '6':
				str[i] = "陆";
				continue;
			case '7':
				str[i] = "柒";
				continue;
			case '8':
				str[i] = "捌";
				continue;
			case '9':
				str[i] = "玖";
				continue;
			case '.':
				str[i] = "点";
				continue;
			}
		}
		return str;
	}


	/**
	 * 货币格式化
	 *
	 * @param currency
	 * @return
	 */
	public static String formatCurrecy(String currency) {
		if ((null == currency) || "".equals(currency)
				|| "null".equals(currency)) {
			return "";
		}

		NumberFormat usFormat = NumberFormat.getCurrencyInstance(Locale.CHINA);

		try {
			return usFormat.format(Double.parseDouble(currency));
		} catch (Exception e) {
			return "";
		}
	}

	public static String formatCurrecy(String currency, String currencyCode) {
		try {
			if ((null == currency) || "".equals(currency)
					|| "null".equals(currency)) {
				return "";
			}

			if (currencyCode.equalsIgnoreCase("1")) {
				NumberFormat usFormat = NumberFormat
						.getCurrencyInstance(Locale.CHINA);
				return usFormat.format(Double.parseDouble(currency));
			} else {
				return currency + "点";
			}
		} catch (Exception e) {
			return "";
		}
	}


	/**
	 * Transform the specified byte into a Hex String form.
	 */
	public static final String bytesToHexStr(byte[] bcd) {
		StringBuffer s = new StringBuffer(bcd.length * 2);

		for (int i = 0; i < bcd.length; i++) {
			s.append(bcdLookup[(bcd[i] >>> 4) & 0x0f]);
			s.append(bcdLookup[bcd[i] & 0x0f]);
		}

		return s.toString();
	}

	/**
	 * Transform the specified Hex String into a byte array.
	 */
	public static final byte[] hexStrToBytes(String s) {
		byte[] bytes;

		bytes = new byte[s.length() / 2];

		for (int i = 0; i < bytes.length; i++) {
			bytes[i] = (byte) Integer.parseInt(s.substring(2 * i, (2 * i) + 2),
					16);
		}

		return bytes;
	}


    /**
     * @param   b       source byte array
     * @param   offset  starting offset
     * @param   len     number of bytes in destination (processes len*2)
     * @return  byte[len]
     */
    public static byte[] hex2byte (byte[] b, int offset, int len) {
        byte[] d = new byte[len];
        for (int i=0; i<len*2; i++) {
            int shift = i%2 == 1 ? 0 : 4;
            d[i>>1] |= Character.digit((char) b[offset+i], 16) << shift;
        }
        return d;
    }
    /**
     * @param s source string (with Hex representation)
     * @return byte array
     */
    public static byte[] hex2byte (String s) {
        return hex2byte (s.getBytes(), 0, s.length() >> 1);
    }

    /**
     *
     * @param str  要截取字符串的参
     * @param tocount 截取字节长度的字节数
     * @param more    字符串补上的字符串
     * @return 返回截后的字符串
     */
    public static String subString(String s, int limit){
    	if(StringUtils.isEmpty(s)){
			return null;
		}else{
			if(s.length() > limit){
				return s.substring(0, limit);
			}else{
				return s;
			}
		}
    }

	/**
	 * String转换成UTF-8编码字符数组
	 *
	 * @param str
	 * @return byte[]
	 */
	public static byte[] getUtf8Bytes(String str) {
		try {
			return str.getBytes("UTF-8");
		} catch (Exception uee) {
			return str.getBytes();
		}
	}

	/**
	 * UTF-8格式字符数组转换成String
	 *
	 * @param utf8
	 * @return String
	 */
	public static String getStringFromUtf8(byte[] utf8) {
		try {
			return new String(utf8, "UTF-8");
		} catch (Exception uee) {
			return new String(utf8);
		}
	}
	
	public static boolean strEquals(String str1,String str2){
		 if (str1 == null) {
            return str2 == null;
        }

        return str1.equals(str2);
	}

	public static String removeEmojiStr(String input) {
		if (StringUtils.isBlank(input)) {
			return input;
		}
		Pattern unicodeOutliers = Pattern.compile("[\ud83c\udc00-\ud83c\udfff]|[\ud83d\udc00-\ud83d\udfff]|[\u2600-\u27ff]",
				Pattern.UNICODE_CASE | Pattern.CANON_EQ | Pattern.CASE_INSENSITIVE);
		return unicodeOutliers.matcher(input).replaceAll(" ");
	}
	
	private static boolean isChinese(char c) {
		Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
		if (ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS
				|| ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS
				|| ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A
				|| ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_B
				|| ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
				|| ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS
				|| ub == Character.UnicodeBlock.GENERAL_PUNCTUATION) {
			return true;
		}
		return false;
	}
 
	// 完整的判断中文汉字和符号
	public static boolean isChinese(String strName) {
		char[] ch = strName.toCharArray();
		for (int i = 0; i < ch.length; i++) {
			char c = ch[i];
			if (isChinese(c)) {
				return true;
			}
		}
		return false;
	}
	
	public static String template(String template, Map<String, String> params) {
		String temp = template;
		for (Map.Entry<String, String> entry : params.entrySet()) {
			temp = StringUtils.replace(temp, "{" + entry.getKey() + "}", entry.getValue());
		}
		return temp;
	}
	
	public static boolean contain(String value, String sub) {
		return StringUtils.contains("," + value + ",", "," + StringUtils.trim(sub) + ",");
	}	
		public static String base64Encode(String value) {
		return Base64.encodeBase64String(value.getBytes());
	}

	public static String base64Decode(String value) {
		return new String(Base64.decodeBase64(value));
	}
	
	/**
     * MD5 十六进制
     */
    public static String getMD5Hex(String input) {
    	return DigestUtils.md5Hex(input);
	}

    public static String getMD5Hex(String ...inputs) {
    	StringBuilder sb = new StringBuilder();
    	for(String temp:inputs) {
    		sb.append(temp);
    	}
    	return getMD5Hex(sb.toString());
    }
    
	public static String valueOf(Object value) {
		return value == null ? "" : value.toString();
	}
}
