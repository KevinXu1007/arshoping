package edu.tamuc.shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import edu.tamuc.shop.model.Category;
import edu.tamuc.shop.service.AdminCategoryService;

@Controller
public class AdminCategoryController {
	
	@Resource
	private AdminCategoryService adminCategoryService;
	
	@ModelAttribute("category")
	public void getCategory(@RequestParam(value="cid",required=false)Integer cid, Map<String,Object> map) {
		if(cid != null){
			Category category = adminCategoryService.findCategory(cid);
			map.put("category", category);
		}
	}
	
	@RequestMapping(value="/updateCategory")
	public ModelAndView updateCategory(@ModelAttribute("category") Category category){
		adminCategoryService.updateCategory(category);
		ModelAndView modelAndView = new ModelAndView("redirect:/listCategory/1");
		return modelAndView;
	}
	
	@RequestMapping(value="/gotoEditCategory/{cid}")
	public String gotoEditCategory(@PathVariable("cid") Integer cid,Map<String,Object> map){
		Category category  = adminCategoryService.findCategory(cid);
		map.put("category",category);
		return "admin/category/edit";
	}
	
	@RequestMapping(value="/deleteCategory/{cid}/{page}")
	public ModelAndView deleteCategory(@PathVariable("cid") Integer cid,@PathVariable("page") Integer page){
		adminCategoryService.deleteCategory(cid);
		ModelAndView modelAndView = new ModelAndView("redirect:/listCategory/" + page);
		return modelAndView;
	}
	
	
	@RequestMapping(value="/addCategory")
	public ModelAndView addCategory(@RequestParam(value="cname",required=true) String cname){
		
		Category category = new Category();
		category.setCname(cname);
		adminCategoryService.addCategory(category);
		ModelAndView modelAndView = new ModelAndView("redirect:listCategory/1");
		return modelAndView;
	}
	
	@RequestMapping(value="/gotoAddCategory")
	public String gotoAddCategory(){
		return "admin/category/add";
	}
	
	@RequestMapping(value="/listCategory/{page}")
	public String listCategory(@PathVariable("page") Integer page,Map<String,Object> map){
		List<Category> categorys = adminCategoryService.listCategory(page);
		map.put("categorys", categorys);
		map.put("page", page);
		Integer count = adminCategoryService.countCategory();
		map.put("count", count);
		return "admin/category/list";
	}
	
}
