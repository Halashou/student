package com.baizhi.entity;
/**
 * 
 * @author llq
 * 分页Bean
 */
public class Page {
	private int start;//起始记录
	private int currentPage;//当前页码
	private int pageSize;//每页最大记录个数
	public Page(int currentPage,int pageSize){
		this.start = (currentPage-1)*pageSize;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
}
