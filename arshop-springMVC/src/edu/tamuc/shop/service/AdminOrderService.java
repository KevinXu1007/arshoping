package edu.tamuc.shop.service;

import java.util.List;

import edu.tamuc.shop.model.Order;
import edu.tamuc.shop.model.OrderItem;

public interface AdminOrderService {
	
	public Order findOrder(Integer oid);
	
	public void saveOrUpdateOrder(Order order);
	
	public void deleteOrder(Order order);
	
	public List<Order> listOrder(Integer page,Integer rows);
	
	public Integer countOrder();
	
	public List<OrderItem> listOrderItem(Integer oid);
	
}
