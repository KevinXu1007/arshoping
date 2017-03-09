package edu.tamuc.shop.service;

import java.util.List;

import edu.tamuc.shop.model.Product;

public interface ProductService {
	
	public List<Product> findByCsid(Integer csid, Integer page);

	public List<Product> findByCid(Integer cid,Integer page);
	
	public List<Product> findHot();
	
	public List<Product> findNew();

	public Product findByPid(Integer pid);
	
	public Integer CountPageProductFromCategory(Integer cid);

	public Integer CountPageProductFromCategorySecond(Integer csid);

}
