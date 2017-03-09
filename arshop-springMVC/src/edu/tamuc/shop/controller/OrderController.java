package edu.tamuc.shop.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import edu.tamuc.shop.model.Cart;
import edu.tamuc.shop.model.CartItem;
import edu.tamuc.shop.model.Order;
import edu.tamuc.shop.model.OrderItem;
import edu.tamuc.shop.model.User;
import edu.tamuc.shop.service.OrderService;
import edu.tamuc.shop.utils.PaymentUtil;

@Controller
public class OrderController {
	
	@Resource
	private OrderService orderService;
	
	@RequestMapping(value="findByOid/{oid}")
	public String findByOid(@PathVariable("oid") Integer oid,
			Map<String,Object> map){
		Order order = orderService.findByOid(oid);
		map.put("order",order);
		return "order";
	} 
	
	@RequestMapping(value="findOrderByUid/{page}")
	public String findOrderByUid(HttpSession session,Map<String,Object> map
			,@PathVariable("page") Integer page){
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("notLogin", "notLogin");
			return "msg";
		}
		
		Integer count = orderService.findCountByUid(user.getUid());
		if(page > count){
			page = 1;
		}
		
		List<Order> orders = orderService.findByUid(user.getUid(), page);
		map.put("orders", orders);
		map.put("page", page);
		map.put("count",count);
		return "orderList";
	}
	
	
	@RequestMapping(value="saveOrder")
	public String saveOrder(HttpSession session,Map<String,Object> map){
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("notLogin","noLogin");
			return "msg";
		}
		Cart cart = (Cart) session .getAttribute("cart");
		if(cart == null){
			return "redirect:myCart";
		}
		Order order = new Order();
		order.setTotal(cart.getTotal());
		// 1:no payment. 2.no shipping  3.shipping£¬no confirm 4.complete
		order.setState(1);
		order.setOrdertime(new Date());
		order.setUser(user);
		Set<OrderItem> sets = new HashSet<OrderItem>();
		for (CartItem cartItem : cart.getCartItems()) {
			OrderItem orderItem = new OrderItem();			
			orderItem.setCount(cartItem.getCount());
			orderItem.setSubtotal(cartItem.getSubtotal());
			orderItem.setProduct(cartItem.getProduct());
			orderItem.setOrder(order);
			sets.add(orderItem);
		}
		order.setOrderItems(sets);
		orderService.save(order);
		cart.clearCart();
		map.put("order",order);
		return "order";
	}
	
	
	@RequestMapping(value="/payOrder")
	public ModelAndView payOrder(Integer oid, String addr,String name, String phone,
			String pd_FrpId,HttpServletResponse response){
		Order order = orderService.findByOid(oid);
		order.setAddr(addr);
		order.setName(name);
		order.setPhone(phone);
		order.setState(2);
		orderService.update(order);
		
		ModelAndView modelAndView = new ModelAndView("redirect:/findOrderByUid/1");

		return modelAndView;
	}

	
	@RequestMapping(value="/callBack")
	public String callBack(Integer r6_Order,Integer r3_Amt,Map<String,Object> map){
		Order currOrder = orderService.findByOid(r6_Order);
		currOrder.setState(2);
		orderService.save(currOrder);
		map.put("success", "successfully, order No.: "+r6_Order +" amount: "+r3_Amt);
		return "msg";
	}
	
	@RequestMapping(value="updateState/{oid}")
	public ModelAndView updateState(@PathVariable("oid") Integer oid){
		System.out.println(oid);
		Order order = orderService.findByOid(oid);
		order.setState(4);
		orderService.update(order);
		ModelAndView model = new ModelAndView("redirect:/findOrderByUid/1");
		return model;
	}
}
