package com.baizhi.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.sql.DataSource;

import com.alibaba.druid.pool.DruidDataSourceFactory;


public class DbUtil {
	private static DataSource ds;
	static{
	    // 2 加载配置文件   获得连接池
	    Properties p = new Properties();
	    try {
	        p.load(DbUtil.class.getClassLoader().getResourceAsStream("db.properties"));
	        ds = DruidDataSourceFactory.createDataSource(p);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	// 3 获得链接
	public static Connection getConnection() throws SQLException {
	    return ds.getConnection();
	}
	// 4 释放资源
	public static void close(Statement stat,Connection conn){
	    if(stat!=null){
	        try {
	            stat.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    if(conn!=null){
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	public static void close(ResultSet rs,Statement stat,Connection conn){
	    if(rs!=null){
	        try {
	            rs.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    if(stat!=null){
	        try {
	            stat.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    if(conn!=null){
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	// 5 获得连接池
	public static DataSource getDataSource(){
	    return ds;
	}
	
	public static void main(String[] args) {
		String sql="insert into t_grade(grade,major,memo) values ('2017','se','memo')";
		Statement s;
		try {
			s = DbUtil.getConnection().createStatement();
			s.executeUpdate(sql);
			s.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
}

