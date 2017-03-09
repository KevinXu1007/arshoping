package edu.tamuc.shop.service;

import java.util.List;

import edu.tamuc.shop.model.Category;

public interface AdminCategoryService {
	
	public List<Category> listCategory(Integer page);
	
	public Integer countCategory();
	
	public void addCategory(Category category);
	
	public void deleteCategory(Integer cid);

	public Category findCategory(Integer cid);

	public void updateCategory(Category category);

	public List<Category> findCategory();
}
