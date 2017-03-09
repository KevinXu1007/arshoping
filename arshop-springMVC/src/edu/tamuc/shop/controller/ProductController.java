package edu.tamuc.shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.tamuc.shop.model.Product;
import edu.tamuc.shop.service.ProductService;

@Controller
public class ProductController {
	
	@Resource
	private ProductService productService;
	
	@RequestMapping(value="findByCsid/{csid}/{page}")
	public String findByCsid(@PathVariable("csid") Integer csid,@PathVariable("page") Integer page
			,Map<String,Object> map){
		Integer count = productService.CountPageProductFromCategorySecond(csid);
		if(page > count){
			page = 1;
		}
		List<Product> products = productService.findByCsid(csid, page);
		map.put("products", products);
		map.put("page", page);
		map.put("count",count);
		map.put("csid", csid);
		return "productList";
	}
	
	@RequestMapping(value="/findByCid/{cid}/{page}")
	public String findByCid(@PathVariable("cid") Integer cid,@PathVariable("page") Integer page
			,Map<String,Object> map){
		List<Product> products = productService.findByCid(cid, page);
		Integer count = productService.CountPageProductFromCategory(cid);
		if(page > count){
			page = 1;
		}
		map.put("products", products);
		map.put("page", page);
		map.put("count",count);
		map.put("cid", cid);
		return "productList";
	}
	
	@RequestMapping(value="findByPid/{pid}",method=RequestMethod.GET)
	public String findByPid(@PathVariable("pid") Integer pid,Map<String,Product> map){
		map.put("product", productService.findByPid(pid));
		return "product";
	}
	
	@RequestMapping(value="getProduct/{pid}",method=RequestMethod.GET)
	@ResponseBody
	public Object getProduct(@PathVariable("pid") Integer pid){
		Map<String, Object> map=new HashMap<String, Object>();
		Product product = productService.findByPid(pid);
		Product p = new Product();
		p.setPid(product.getPid());
		p.setImage(product.getImage());
		p.setMarket_price(product.getMarket_price());
		p.setShop_price(product.getShop_price());
		p.setPname(product.getPname());
		p.setPdesc(product.getPdesc());
		map.put("product", p);
		return map;
	}
	
	@RequestMapping(value="listProduct/{csid}/{page}")
	@ResponseBody
	public Object ListByCsid(@PathVariable("csid") Integer csid,@PathVariable("page") Integer page){
		Map<String, Object> map=new HashMap<String, Object>();
		Integer count = productService.CountPageProductFromCategorySecond(csid);
		if(page > count){
			page = 1;
		}
		List<Product> products = productService.findByCsid(csid, page);
		map.put("products", products);
		return map;
	}
}
