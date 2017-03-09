package edu.tamuc.shop.dao;

import java.util.List;

import edu.tamuc.shop.model.Category;

public interface CategoryDao extends BaseDao<Category>{
	
	public Integer countCategory();
	
	public List<Category> findAll(Integer page);
	
	public List<Category> findAll();
	
	public Category findOne(Integer cid);
}
