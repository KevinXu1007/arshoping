package edu.tamuc.shop.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.tamuc.shop.dao.CategoryDao;
import edu.tamuc.shop.model.Category;
import edu.tamuc.shop.service.AdminCategoryService;

@Transactional
@Service("adminCategoryService")
public class AdminCategoryServiceImpl implements AdminCategoryService{
	
	@Resource
	private CategoryDao categoryDao;
	
	public void addCategory(Category category) {
		categoryDao.save(category);
	}

	public void deleteCategory(Integer cid) {
		categoryDao.delete(cid);
	}
	
	public void updateCategory(Category category) {
		categoryDao.update(category);	
	}
	
	public Integer countCategory() {
		Integer count = categoryDao.countCategory(); 
		return  (count % 10 == 0 ? (count /10) : (count / 10 + 1));
	}

	public Category findCategory(Integer cid) {
		return categoryDao.findOne(cid);
	}

	public List<Category> findCategory() {
		return categoryDao.findAll();
	}

	public List<Category> listCategory(Integer page) {
		return categoryDao.findAll(page);
	}

}
