package ${packagePrefix}.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import ${packagePrefix}.common.util.DateUtil;

/**
 * #### auto generate code.
 *
 */
public class IntegerEntity implements Entity<Integer>, Serializable {

	private static final long serialVersionUID = ${serialId}L;

	private int id;
	//1 active 0 inactive.
	private int active = 1;
	
	private String remark;

	private int createBy;

	private Date createTime = new Date();

	private int updateBy;

	private Date updateTime = new Date();

	@Override
	public Integer getId() {
		return id;
	}
	
	public boolean isPersist() {
		return id > 0;
	}

	public int getCreateBy() {
		return createBy;
	}

	public void setCreateBy(int createBy) {
		this.createBy = createBy;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public void setCreateTimeStr(String createTimeStr) {
		this.createTime = DateUtil.string2DateTime(DateUtil.DEFAULT_DATE_FORMAT, createTimeStr);
	}

	public String getCreateTimeStr() {
		return DateUtil.formatDateTime(null, createTime);
	}

	public int getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(int updateBy) {
		this.updateBy = updateBy;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}
	
	public boolean isActiveEntity() {
		return active == 1;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public boolean isExpired(long mins) {
		return updateTime == null || new Date().getTime() - updateTime.getTime() > TimeUnit.MINUTES.toMillis(mins);
	}
	
	public String getLowName() {
		return getClass().getSimpleName().toLowerCase();
	}
	
	public List<Field> getFields() {
   		return new ArrayList<Field>();
    }

	@Override
	public String toString() {
		return "IntegerEntity [id=" + id + ", active=" + active + ", remark=" + remark + ", createBy=" + createBy
				+ ", createTime=" + createTime + ", updateBy=" + updateBy + ", updateTime=" + updateTime + "]";
	}
	
}
