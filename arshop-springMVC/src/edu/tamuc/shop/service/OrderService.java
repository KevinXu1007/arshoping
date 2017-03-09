package edu.tamuc.shop.service;

import java.util.List;

import edu.tamuc.shop.model.Order;
import edu.tamuc.shop.model.OrderItem;

public interface OrderService {
	
	public void save(Order order) ;

	public List<Order> findByUid(Integer uid,Integer page);

	public Order findByOid(Integer oid) ;

	public void update(Order currOrder) ;

	public List<Order> findAll(Integer page) ;

	public List<OrderItem> findOrderItem(Integer oid) ;

	public Integer findCountByUid(Integer uid);
	
}
