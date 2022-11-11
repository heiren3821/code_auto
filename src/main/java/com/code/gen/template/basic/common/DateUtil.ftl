package ${packagePrefix}.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.commons.lang3.StringUtils;

public class DateUtil {
	public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	public static final String YYYYMMDD = "yyyyMMdd";
	public static final String YYYY_MM_DD = "yyyy-MM-dd";
	public static final String YYYYMMDDHH = "yyyyMMddHH";
	public static final String YYYYMMDDHHMM = "yyyyMMddHHmm";
	public static final String YYYYMMDDHHMMSS = "yyyyMMddHHmmss";
	public static final String YYYY_MM_DDTHH_MM_SS = "yyyy-MM-dd'T'HH:mm:ss";
	public static final String HHMMSS = "HH:mm:ss";
	public static final String HHMM = "HH:mm";
	public static final String YYYYMMDDHHMMSSSSS = "yyyyMMddHHmmssSSS";

	/**
	 * @return the formatted date-time string
	 * @see java.text.SimpleDateFormat
	 */
	public static String formatDateTime(String pattern) {
		if (pattern == null) {
			pattern = DEFAULT_DATE_FORMAT;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		String now = sdf.format(new java.util.Date());
		return now;
	}
	
	public static String formatDateTimeHourAdd(String pattern,int hour_add) {
		if (pattern == null) {
			pattern = DEFAULT_DATE_FORMAT;
		}
		Calendar c = Calendar.getInstance();
		c.add(Calendar.HOUR_OF_DAY, hour_add);
		return formatDateTime(pattern, c.getTime());
	}
	
	public static String formatHhMm(Date date) {
		return formatDateTime(HHMM, date);
	}

	/**
	 * @return the formatted date-time string
	 * @see java.text.SimpleDateFormat
	 */
	public static String formatDateTime(String pattern, java.util.Date date) {
		String strDate = null;
		String strFormat = pattern;
		if (pattern == null || pattern.trim().length() < 1) {
			strFormat = DEFAULT_DATE_FORMAT;
		}
		if (date == null)
			return "";
		SimpleDateFormat dateFormat = new SimpleDateFormat(strFormat);
		strDate = dateFormat.format(date);
		return strDate;
	}

	/**
	 * @param locale
	 *            - the locale whose date format symbols should be used
	 * @return the formatted date-time string
	 * @see java.text.SimpleDateFormat
	 */
	public static String formatDateTime(String pattern, java.util.Date date, Locale locale) {
		String strDate = null;
		String strFormat = pattern;
		SimpleDateFormat dateFormat = null;

		if (date == null)
			return "";

		dateFormat = new SimpleDateFormat(strFormat, locale);
		strDate = dateFormat.format(date);

		return strDate;
	}

	public static final Date string2DateTime(String yyyyMMddhhmmss) {
		Date dt;
		SimpleDateFormat sdfDateTime = getFormat("yyyyMMddHHmmss");
		try {
			dt = sdfDateTime.parse(yyyyMMddhhmmss);
		} catch (ParseException e) {
			throw new RuntimeException("Parse String to Date Error!", e);
		}
		return dt;
	}

	public static final Date string2DateTime(String formatStr, String dateStr) {
		if(StringUtils.isBlank(dateStr) || StringUtils.isBlank(formatStr)){
			return null;
		}
		try {
			SimpleDateFormat sdfDateTime = getFormat(formatStr);
			return sdfDateTime.parse(dateStr);
		} catch (ParseException e) {
			return null;
		}
	}

	private static final SimpleDateFormat getFormat(String format) {
		SimpleDateFormat f = new SimpleDateFormat(format);
		return f;
	}

	/**
	 * 计算时间差
	 * 
	 * @param date
	 * @param diff
	 * @param field
	 *            Calendar
	 * @param pattern
	 * @return
	 */
	public static final String getTimeDiff(Date date, int diff, int field, String pattern) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(field, diff);
		return formatDateTime(pattern, calendar.getTime());
	}

	/**
	 * 
	 * 获得今天的结束时刻时刻为23:59:59
	 * 
	 * @param date
	 * @return
	 */
	public static Date getTheTodayEndDate(Date date) {
		if (date == null){
			return null;
		}
		Calendar c1 = Calendar.getInstance();
		c1.setTime(date);
		c1.set(Calendar.HOUR_OF_DAY, 23);
		c1.set(Calendar.MINUTE, 59);
		c1.set(Calendar.SECOND, 59);
		return c1.getTime();
	}
	
	public static Date getYesterday() {
		return DateUtils.addDays(DateUtils.truncate(new Date(), Calendar.DATE), -1);
	}

	/**
	 * 
	 * 获得今天的结束时刻时刻为00:00:00
	 * 
	 * @author liufosheng
	 * @param date
	 * @return
	 */
	public static Date getTheTodayStartDate(Date date) {
		if (date == null){
			return null;
		}
		Calendar c1 = Calendar.getInstance();
		c1.setTime(date);
		c1.set(Calendar.HOUR_OF_DAY, 0);
		c1.set(Calendar.MINUTE, 0);
		c1.set(Calendar.SECOND, 0);
		return c1.getTime();
	}
	
	/**get sec to Tomorrow.
	 * @return
	 */
	public static long getSecsTillTomorrow() {
		Date current = new Date();
		Date tomorrow = DateUtils.truncate(DateUtils.addDays(current, 1), Calendar.DATE);
		return (tomorrow.getTime() - current.getTime()) / 1000;
	}
	
	/**get sec to Tomorrow.
	 * @return
	 */
	public static long getSecsTillNextHour() {
		Date current = new Date();
		Date next = DateUtils.truncate(DateUtils.addHours(current, 1), Calendar.HOUR);
		return (next.getTime() - current.getTime()) / 1000;
	}
	
	/**
	 * 计算2个时间之间的天数
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static int daysBetween(Date startDate,Date endDate){
		if(startDate == null || endDate == null){
			return 0;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(startDate);
		long start = c.getTimeInMillis();
		
		c.setTime(endDate);
		long end = c.getTimeInMillis();
		
		long days = (end - start)/(1000 * 3600 * 24);
		return ((Long)days).intValue();
	}
	
	public static Date converSqlStr(String sqlStr) {
		String temp = sqlStr;
		// "yyyy-MM-dd"
		if (StringUtils.length(sqlStr) == 10) {
			temp = sqlStr + " 00:00:00";
			// "yyyy-MM-dd HH"
		} else if (StringUtils.length(sqlStr) == 13) {
			temp = sqlStr + ":00:00";
			// "yyyy-MM-dd HH:mm"
		} else if (StringUtils.length(sqlStr) == 16) {
			temp = sqlStr + ":00";
		}
		return string2DateTime(DEFAULT_DATE_FORMAT, temp);
	}
	
    /**
     * 秒数转时间 eg：01:23:30
     * @param time
     * @return
     */
    public static String secToTime(int time) {  
        String timeStr = null;  
        int hour = 0;  
        int minute = 0;  
        int second = 0;  
        if (time <= 0)  
            return "00:00";  
        else {  
            minute = time / 60;  
            if (minute < 60) {  
                second = time % 60;  
                timeStr = unitFormat(minute) + ":" + unitFormat(second);  
            } else {  
                hour = minute / 60;  
                if (hour > 99)  
                    return "99:59:59";  
                minute = minute % 60;  
                second = time - hour * 3600 - minute * 60;  
                timeStr = unitFormat(hour) + ":" + unitFormat(minute) + ":" + unitFormat(second);  
            }  
        }  
        return timeStr;  
    }  
    
    /**时间format 00:00:00 转sec.
     * @param time
     * @return
     */
	public static int timeToSec(String time) {
		String[] tims = StringUtils.split(time, ":");
		int sec = 0;
		if (tims == null || tims.length != 3) {
			return sec;
		}
		return NumberUtils.toInt(tims[0]) * 3600 + NumberUtils.toInt(tims[1]) * 60 + NumberUtils.toInt(tims[2]);
	}
  
    private static String unitFormat(int i) {  
        String retStr = null;  
        if (i >= 0 && i < 10)  
            retStr = "0" + Integer.toString(i);  
        else  
            retStr = "" + i;  
        return retStr;  
    }  
	
	public static void main(String[] args) {
		String duration = secToTime(05);
		System.out.println(duration);
		System.out.println(timeToSec("00:01:16"));
		System.out.println(getSecsTillTomorrow());
	}
	

}
