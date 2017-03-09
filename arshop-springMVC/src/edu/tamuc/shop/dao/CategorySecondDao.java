package edu.tamuc.shop.dao;

import java.util.List;

import edu.tamuc.shop.model.CategorySecond;

public interface CategorySecondDao extends BaseDao<CategorySecond>{
	
	//��ѯ����������ܵĸ���
	public Integer countCategorySecond();
	//��ҳ���������û�
	public List<CategorySecond> findAll(Integer page);
	
	public List<CategorySecond> findAll();
	
	public CategorySecond findOne(Integer cid);
	
}
