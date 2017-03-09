package edu.tamuc.shop.dao;

import java.util.List;

import edu.tamuc.shop.model.Order;
import edu.tamuc.shop.model.OrderItem;


public interface OrderDao extends BaseDao<Order>{
	

	public int findCountByUid(Integer uid);

	public List<Order> findPageByUid(Integer uid, int begin, int limit);

	public Order findByOid(Integer oid);

	public int findCount();

	public List<Order> findByPage(int begin, int limit);
	
	public List<OrderItem> findOrderItem(Integer oid);
}
