package edu.tamuc.shop.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.tamuc.shop.dao.CategoryDao;
import edu.tamuc.shop.model.Category;
import edu.tamuc.shop.service.CategoryService;

@Transactional
@Service("categoryService")
public class CategoryServiceImpl implements CategoryService{
	
	@Resource
	private CategoryDao categoryDao;
	
	public List<Category> getCategory() {
		return categoryDao.findAll();
	}

}
