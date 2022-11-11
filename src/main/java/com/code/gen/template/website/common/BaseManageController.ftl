package ${packagePrefix}.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import ${packagePrefix}.model.Entity;
import ${packagePrefix}.model.Field;
import ${packagePrefix}.model.Pagination;
import ${packagePrefix}.service.CacheService;

/**
 * auto generate code.
 * @author James.chen 
 *
 */
public abstract class BaseManageController<PK extends Number,E extends Entity<PK>> extends BaseController {
	
	protected abstract CacheService<PK, E> getService();
	
	protected abstract String validate(E e);
	
	protected String getFolder() {
		return "common/";
	}
	
	protected Map<String, Object> getQueryParams() {
		return new HashMap<String, Object>();
	}
	
	protected void setModelInfo(Model model, HttpServletRequest request) {
	}
	
	protected void setExtraInfo(E e) {
	}
	
	protected Map<String, Object> addQueryInfo(HttpServletRequest request) {
		return new HashMap<String, Object>();
	}
	
	@RequestMapping("list.do")
	public String list(Model model, HttpServletRequest request) {
		try {
			Pagination<E> pagination = new Pagination<E>();
			pagination.setPageNo(NumberUtils.toInt(request.getParameter("pageNo")));
			pagination.setPageSize(NumberUtils.toInt(request.getParameter("pageSize")));
			for (Map.Entry<String, Object> entry : addQueryInfo(request).entrySet()) {
				pagination.addParam(entry.getKey(), entry.getValue());
			}
			model.addAttribute("pageNo", pagination.getPageNo());
			model.addAttribute("pageSize", pagination.getPageSize());
			pagination = getService().getPagination(pagination);
			model.addAttribute("emptyEntry",getService().getEntityObject());
			model.addAttribute("pagination", pagination);
			setModelInfo(model,request);
		} catch (Exception e) {
			logger.error("app list error", e);
		}
		return getFolder() + "list";
	}
	
	@RequestMapping("{configId}/load.do")
	public String load(@PathVariable("configId") PK id, Model model, HttpServletRequest request) {
		model.addAttribute("entry", getService().getById(id));
		setModelInfo(model,request);
		return getFolder() + "load";
	}
	
	@RequestMapping("{configId}/{action}.do")
	@ResponseBody
	public JSONObject change(@PathVariable("configId") PK id, @PathVariable("action") String action, Model model) {
		E entry = getService().getById(id);
		entry.setActive("active".equals(action) ? 1 : 0);
		getService().saveOrUpdate(entry);
		return result("0", "success");
	}
	
	@RequestMapping("save.do")
	@ResponseBody
	public JSONObject save(E entry) {
		String result = validate(entry);
		if (StringUtils.isNotBlank(result)) {
			return result("1", result);
		}
		setExtraInfo(entry);
		getService().saveOrUpdate(entry);
		return result("0", "success");
	}
	
	protected String validate(List<Field> fields) {
		for (Field temp : fields) {
			String result = temp.validate();
			if (StringUtils.isNotBlank(result)) {
				return result;
			}
		}
		return "";
	}
}
