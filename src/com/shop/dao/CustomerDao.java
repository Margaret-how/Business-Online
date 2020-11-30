package com.shop.dao;

import java.util.ArrayList;

import com.shop.domain.Customer;
import com.shop.utils.DBUtil;

public class CustomerDao extends DBUtil {
	/**
	 * 插入一个customer对象
	 * 
	 * @param cust
	 * @return
	 */
	public boolean insert(Customer c) {
		String sql = "insert into customer(username,password,email,tel) values(?,?,?,?)";
		Object[] params = { c.getUsername(),c.getPassword(),c.getEmail(),c.getTel()};
		try {
			int n = this.doUpdate(sql, params);
			if (n > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.close();
		}

		return false;
	}

	
	/**
	 * 按照name和password查找用户
	 * 
	 * @param name 用户名
	 * @param password 密码
	 * @return 找到用户就返回这个用户，找不到返回null
	 */
	public Customer find(String name, String password) {
		String sql = "select * from customer where username =?";
		String[] params = { name };
		try {
			this.rs = this.doQuery(sql, params);

			if (rs.next()) {
				String pwd = rs.getString(3);// 获取数据库中的password
				if (pwd.equals(password)) {
					Customer c = new Customer();
					c.setId(rs.getInt(1));
					c.setUsername(rs.getString(2));
					c.setPassword(rs.getString(3));
					c.setEmail(rs.getString(4));
					c.setTel(rs.getString(5));
	
					return c;
				}
			} else {
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
		return null;
	}

	/**
	 * 查找所有用户
	 * 
	 * @return
	 */
	public ArrayList<Customer> findAll() {
		String sql = "select * from customer ";
		ArrayList<Customer> list = new ArrayList<Customer>();
		String[] params = null;
		try {
			this.rs = this.doQuery(sql, params);
			while (rs.next()) {
				Customer c = new Customer();
				c.setId(rs.getInt(1));
				c.setUsername(rs.getString(2));
				c.setPassword(rs.getString(3));
				c.setEmail(rs.getString(4));
				c.setTel(rs.getString(5));
		
				list.add(c);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.close();
		}
		return null;
	}

	public static void main(String[] args) {
	}

}
