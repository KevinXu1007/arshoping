package edu.tamuc.shop.service;

import java.util.List;

import edu.tamuc.shop.model.CategorySecond;

public interface AdminCategorySecondService {
	
	public List<CategorySecond> listCategorySecond(Integer page);

	public Integer countCategorySecond();
	
	public void addCategorySecond(CategorySecond categorySecond); 

	public void deleteCategorySecond(Integer csid); 

	public CategorySecond findCategorySecond(Integer csid); 

	public void updateCategorySecond(CategorySecond categorySecond);
	
	public List<CategorySecond> listCategorySecond();
}
