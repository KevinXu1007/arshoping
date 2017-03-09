package edu.tamuc.shop.service;

import java.util.List;

import edu.tamuc.shop.model.Admin;
import edu.tamuc.shop.model.User;

public interface AdminService {
	
	public void updateUser(User user);
	
	public Admin checkUser(Admin admin);
	
	public void deleteUser(Integer uid) ;

	public List<User> findUser(Integer page);

	public Integer countUser() ;

	public User findUserByUid(Integer uid);
}
