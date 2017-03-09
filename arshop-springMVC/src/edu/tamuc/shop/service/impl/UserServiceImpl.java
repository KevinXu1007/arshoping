package edu.tamuc.shop.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.tamuc.shop.dao.UserDao;
import edu.tamuc.shop.model.User;
import edu.tamuc.shop.service.UserService;


@Transactional
@Service("userService")
public class UserServiceImpl implements UserService{
	
	@Resource
	private UserDao userDao;
	
	public User active(String code) {
		return userDao.findByCode(code);
	}
	
	public User findUserByUsernameAndPassword(User user) {
		return userDao.findByUsernameAndPassword(user.getUsername(), user.getPassword());
	}
	
	public User existUser(String userName) {
		return userDao.findByUsername(userName);
	}

	public void register(User user) {
		user.setState(1);
		userDao.save(user);
	}

	public void update(User user) {
		userDao.update(user);
		
	}
	
}
