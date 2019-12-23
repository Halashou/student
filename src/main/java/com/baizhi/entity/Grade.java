package com.baizhi.entity;
/**
 * t_grade表对应的模型
 * @author hp
 *
 */
public class Grade {
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	/**
	 * id,自增
	 */
	private int id;
	/**
	 * 年级
	 */
	private String grade;
	/**
	 * 专业
	 */
	private String major;
	/**
	 * 备注
	 */
	private String memo;
	@Override
	public String toString() {
		return "Grade [id=" + id + ", grade=" + grade + ", major=" + major
				+ ", memo=" + memo + "]";
	}
	
}
