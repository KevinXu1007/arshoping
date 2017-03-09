package edu.tamuc.shop.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import edu.tamuc.shop.model.Order;
import edu.tamuc.shop.model.OrderItem;
import edu.tamuc.shop.service.AdminOrderService;
import edu.tamuc.shop.service.AdminProductService;

@Controller
public class AdminOrderController {
	
	@Resource
	private AdminOrderService adminOrderService;
	
	@RequestMapping(value="/findOrderItem/{oid}")
	public String findOrderItem(@PathVariable("oid") Integer oid,Map<String,Object> map,
			HttpServletResponse response) throws IOException{
		List<OrderItem> orderItem = adminOrderService.listOrderItem(oid);
		map.put("orderItem",orderItem);
		return "/admin/order/orderItem";
	}
	
	@RequestMapping(value="/updateStateOrder/{oid}/{page}")
	public ModelAndView updateStateOrder(@PathVariable("oid") Integer oid,@PathVariable("page") Integer page){
		ModelAndView modelAndView = new ModelAndView("redirect:/listOrder/"+page);
		Order order = adminOrderService.findOrder(oid);
		order.setState(3);
		adminOrderService.saveOrUpdateOrder(order);
		return modelAndView;
	}
	
	@RequestMapping(value="/listOrder/{page}")
	public ModelAndView listOrder(@PathVariable("page") Integer page){
		ModelAndView modelAndView = new ModelAndView("admin/order/list");
		List<Order> orders = adminOrderService.listOrder(page, 5);
		modelAndView.addObject("orders", orders);
		modelAndView.addObject("page", page);
		Integer count = adminOrderService.countOrder();
		modelAndView.addObject("count", count);
		return modelAndView;
	}
	
	@RequestMapping(value="/deleteOrder/{oid}")
	public ModelAndView deleteProduct(@PathVariable("oid") Integer oid,HttpServletRequest request){
		
		Order order = adminOrderService.findOrder(oid);
		adminOrderService.deleteOrder(order);
		ModelAndView modelAndView = new ModelAndView("redirect:/listOrder/1");
		return modelAndView;
	}
}
