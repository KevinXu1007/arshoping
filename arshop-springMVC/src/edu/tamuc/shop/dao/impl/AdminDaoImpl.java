package edu.tamuc.shop.dao.impl;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import edu.tamuc.shop.dao.AdminDao;
import edu.tamuc.shop.model.Admin;

@Repository("adminDao")
@SuppressWarnings("all")
public class AdminDaoImpl extends BaseDaoImpl<Admin> implements AdminDao{

	public Admin findByAdminnameAndPassword(String username, String password) {
		String hql = "from Admin a where a.username = ? and a.password = ?";
		Query query = this.getCurrentSession().createQuery(hql);
		query.setParameter(0, username);
		query.setParameter(1, password);
		return (Admin)query.uniqueResult(); 
	}

}
