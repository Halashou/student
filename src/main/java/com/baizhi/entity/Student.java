package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 学生表
 * @author hp
 *
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@Accessors(chain = true)
public class Student {
	/**
	 * 学号
	 */
	private String sid;
	private String studentname;
	private String gender;
	/**
	 * 籍贯
	 */
	private String region;
	/**
	 * 班级
	 */
	private int cid;
	/**
	 * 年级
	 */
	private int gid;
	/**
	 * 民族
	 */
	private String nationality;
	/**
	 * 政治面貌
	 */
	private String politics;
	/**
	 * 宿舍号
	 */
	private String dorm;
	/**
	 * 银行卡号
	 */
	private String bank;
	/**
	 * 身份证号
	 */
	private String id;
	private String tel;
	private String email;
	private String qq;
	private String wechat;
	private String weibo;
	private String mother;
	private String mothertel;
	private String father;
	private String fathertel;
	/**
	 * 户口
	 */
	private String residence;
	/**
	 * 现居地
	 */
	private String home;
	private String photo;
	private String password;
	/**
	 * 状态
	 */
	private String status;
	/**
	 * 备注
	 */
	private String memo;
	/**
	 * 辅导员
	 */
	private String tid;
}
