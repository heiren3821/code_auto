package ${packagePrefix}.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ${packagePrefix}.common.Constants;

/**     
 * ##auto generate
 * james.chen     
 */  
public class Pagination<E> {

	private int pageNo = 1;
	
	private int pageSize = 10;
	//showNum
	private int showNum = 5;
	
	private int count;
	
	private List<E> items = new ArrayList<E>();
	
	private Map<String,Object> params = new HashMap<String,Object>();

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo <= 0 ? 1 : pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}
	
	public int getOffSet() {
		return (pageNo - 1) * pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = (pageSize <= 0 || pageSize > 500) ? 10 : pageSize;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	public int getMaxSize() {
		return count / pageSize + (count % pageSize > 0 ? 1 : 0);
	}

	public List<E> getItems() {
		return items;
	}

	public void setItems(List<E> items) {
		this.items = items;
	}
	
	public boolean isShowPrevious() {
		return getStart() > 1;
	}

	public boolean isShowNext() {
		return getMaxSize() > getEnd();
	}
	
	public int getPrevious() {
		return getStart() - 1;
	}
	
	public int getStart() {
		int start = (pageNo <= showNum / 2) ? 1 : (pageNo - showNum / 2);
		int max = getMaxSize();
		return (max - pageNo < showNum / 2) && (max - showNum + 1 > 0) ? (max - showNum + 1) : start;
	}
	
	public int getEnd() {
		return getStart() + getActualShowNum() - 1;
	}

	public int getNext() {
		return getEnd() + 1;
	}
	
	public int getActualShowNum() {
		int start = getStart();
		int max = getMaxSize();
		if (max == 0) {
			return 0;
		}
		return (max - start >= showNum) ? showNum : (max - start + 1);
	}

	public List<Integer> getPages() {
		List<Integer> pages = new ArrayList<Integer>();
		int actualShowNum = getActualShowNum();
		if (actualShowNum == 1) {
			return pages;
		}
		int start = getStart();
		for (int i = 0; i < actualShowNum; i++) {
			pages.add(start + i);
		}
		return pages;
	}
	

	public int getShowNum() {
		return showNum;
	}

	public void setShowNum(int showNum) {
		this.showNum = showNum;
	}

	public Map<String, Object> getParams() {
		addParam(Constants.FIRSTRESULT, getOffSet());
		addParam(Constants.MAXRESULT, pageSize);
		return params;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}
	
	public void addParam(String key,Object value) {
		params.put(key, value);
	}

	@Override
	public String toString() {
		return "Pagination [pageNo=" + pageNo + ", pageSize=" + pageSize + ", count=" + count + ", items=" + items
				+ ", toString()=" + super.toString() + "]";
	}
}
