package edu.tamuc.shop.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.tamuc.shop.dao.AdminDao;
import edu.tamuc.shop.dao.UserDao;
import edu.tamuc.shop.model.Admin;
import edu.tamuc.shop.model.User;
import edu.tamuc.shop.service.AdminService;

@Transactional
@Service("adminService")
public class AdminServiceImpl implements AdminService{

	@Resource
	private AdminDao adminDao;
	@Resource
	private UserDao userDao;

	public void updateUser(User user){
		userDao.update(user);
	}

	public Admin checkUser(Admin adminUser) {
		return adminDao.findByAdminnameAndPassword(
				adminUser.getUsername(), adminUser.getPassword());
	}

	public void deleteUser(Integer uid) {
		userDao.delete(uid);
	}

	public List<User> findUser(Integer page){
		return userDao.findAll(page);
	}

	public Integer countUser() {
		Integer count = userDao.countUser();
		return (count % 20 == 0 ? (count / 20) : (count / 20 + 1));
	}

	public User findUserByUid(Integer uid) {
		return userDao.findOne(uid);
	}
}
