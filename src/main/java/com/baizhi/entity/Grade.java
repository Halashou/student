package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * t_grade表对应的模型
 * @author hp
 *
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Grade {
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
}
