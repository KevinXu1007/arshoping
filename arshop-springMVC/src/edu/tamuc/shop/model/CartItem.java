package edu.tamuc.shop.model;

public class CartItem {
	
	private Product product; 
	private int count;       
	@SuppressWarnings("unused")
	private double subtotal; 
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getSubtotal(){
		if(product.getShop_price()!=null){
			return count*product.getShop_price();
		}
		return 0;
	}
}
