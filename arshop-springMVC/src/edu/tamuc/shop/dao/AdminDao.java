package edu.tamuc.shop.dao;

import edu.tamuc.shop.model.Admin;

public interface AdminDao extends BaseDao<Admin>{
	public Admin findByAdminnameAndPassword(String username,String password);
}
