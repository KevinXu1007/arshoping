package edu.tamuc.shop.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.tamuc.shop.model.Cart;
import edu.tamuc.shop.model.CartItem;
import edu.tamuc.shop.model.Product;
import edu.tamuc.shop.service.ProductService;

@Controller
public class CartController {
	@Resource
	private ProductService productService;
	
	@RequestMapping("/myCart")
	public String myCart() {
		return "cart";
	}
	
	@RequestMapping(value="/clearCart")
	public String clearCart(HttpSession session){
		Cart cart = (Cart) session.getAttribute("cart");
		cart.clearCart();
		return "cart";
	}
	
	@RequestMapping(value="/removeCart/{pid}")
	public String removeCart(@PathVariable("pid") Integer pid, HttpSession session){
		
		Cart cart = (Cart) session.getAttribute("cart");
		cart.removeCart(pid);
		return "cart";
	}
	
	@RequestMapping(value="/addCart")
	public String addCart(Integer pid, Integer count, HttpSession session){
		Product product = productService.findByPid(pid);
		CartItem cartItem = new CartItem();
		cartItem.setCount(count);
		cartItem.setProduct(product);
		Cart cart = (Cart) session.getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			session.setAttribute("cart", cart);
		}
		
		cart.addCart(cartItem);
		return "cart";
	}
	
}
