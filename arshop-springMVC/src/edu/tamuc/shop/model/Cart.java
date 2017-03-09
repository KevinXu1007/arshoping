package edu.tamuc.shop.model;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
	
	private Map<Integer, CartItem> map = new LinkedHashMap<Integer, CartItem>();
	
	public Collection<CartItem> getCartItems(){
		return map.values();
	}

	private double total;
	
	public double getTotal() {
		return total;
	}
	
	public void addCart(CartItem cartItem) {
		
		Integer pid = cartItem.getProduct().getPid();
		
		if(map.containsKey(pid)){			
			CartItem _carCartItem = map.get(pid);
			_carCartItem.setCount(_carCartItem.getCount()+cartItem.getCount());
		}else {
			map.put(pid, cartItem);
		}
		total += cartItem.getSubtotal();
	}
	
	public void removeCart(Integer pid) {
		CartItem cartItem = map.remove(pid);
		total -= cartItem.getSubtotal();
	}
	
	public void clearCart() {
		map.clear();
		total = 0;
	}
}
