package edu.tamuc.shop.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.tamuc.shop.service.CategoryService;
import edu.tamuc.shop.service.ProductService;

@Controller
public class IndexController {
	@Resource
	private CategoryService categoryService;
	
	@Resource
	private ProductService productService;
	
	@RequestMapping(value="/index")
	public String showIndex(Map<String,Object> map,HttpSession session){		
		session.setAttribute("cList", categoryService.getCategory());		
		map.put("nList", productService.findNew());		
		map.put("hList", productService.findHot());		
		return "index"; 
	}
}
