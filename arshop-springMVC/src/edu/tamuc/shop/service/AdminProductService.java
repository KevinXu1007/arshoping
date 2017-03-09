package edu.tamuc.shop.service;

import java.util.List;

import edu.tamuc.shop.model.Product;

public interface AdminProductService {
	
	public List<Product> listProduct(Integer page);
	
	public Integer countProduct();
	
	public void saveProduct(Product product);

	public Product findProduct(Integer pid);
	
	public void deleteProduct(Product product);
	
	public void updateProduct(Product product);
}
