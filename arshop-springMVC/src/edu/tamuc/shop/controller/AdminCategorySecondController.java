package edu.tamuc.shop.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import edu.tamuc.shop.model.Category;
import edu.tamuc.shop.model.CategorySecond;
import edu.tamuc.shop.service.AdminCategorySecondService;
import edu.tamuc.shop.service.AdminCategoryService;

@Controller
public class AdminCategorySecondController {
	
	@Resource
	private AdminCategorySecondService adminCategorySecondService;
	@Resource
	private AdminCategoryService adminCategoryService;
	
	@RequestMapping(value="/updateCategorySecond",method=RequestMethod.POST)
	public ModelAndView updateCategorySecond(@RequestParam("csid") Integer csid,@RequestParam("csname") String csname,
			@RequestParam("cid") Integer cid){
		Category category = adminCategoryService.findCategory(cid);
		CategorySecond categorySecond = adminCategorySecondService.findCategorySecond(csid);
		categorySecond.setCategory(category);
		categorySecond.setCsname(csname);
		adminCategorySecondService.updateCategorySecond(categorySecond);
		ModelAndView modelAndView = new ModelAndView("redirect:/listCategorySecond/1");
	    return modelAndView;
	}
	
	@RequestMapping(value="/gotoEditCategorySecond/{csid}")
	public String gotoEditCategorySecond(@PathVariable("csid") Integer csid,
			Map<String,Object> map){
		//System.out.println("===="+csid);
		CategorySecond categorySecond = adminCategorySecondService.findCategorySecond(csid);
		map.put("categorySecond", categorySecond);
		List<Category> categorys = adminCategoryService.findCategory();
		map.put("categorys", categorys);
		return "admin/categorysecond/edit";
	}
	
	@RequestMapping(value="/deleteCategorySecond/{csid}/{page}")
	public ModelAndView deleteCategorySecond(@PathVariable("csid") Integer csid,@PathVariable("page") Integer page){
		adminCategorySecondService.deleteCategorySecond(csid);
		ModelAndView modelAndView = new ModelAndView("redirect:/listCategorySecond/"+page);
		return modelAndView;
	}
	
	@RequestMapping(value="/addCategorySecond")
	public ModelAndView addCategorySecond(@RequestParam("csname") String csname,@RequestParam("cid") Integer cid){
		Category category = adminCategoryService.findCategory(cid);
	    CategorySecond categorySecond = new CategorySecond();
	    categorySecond.setCategory(category);
	    categorySecond.setCsname(csname);
	    adminCategorySecondService.addCategorySecond(categorySecond);
	    ModelAndView modelAndView = new ModelAndView("redirect:listCategorySecond/1");
		return modelAndView;
	}
	
	@RequestMapping(value="/gotoAddCategorySecond")
	public String gotoAddCategorySecond(Map<String,Object> map){
		List<Category> categorys = adminCategoryService.findCategory();
		map.put("categorys",categorys);
		return "admin/categorysecond/add";
	}
	
	@RequestMapping(value="/listCategorySecond/{page}")
	public String listCategorySecond(@PathVariable("page") Integer page,Map<String,Object> map){
		 List<CategorySecond> categorySeconds = adminCategorySecondService.listCategorySecond(page);
		 map.put("categorySeconds", categorySeconds);
		 map.put("page", page);
		 Integer count = adminCategorySecondService.countCategorySecond();
		 map.put("count", count);
		return "admin/categorysecond/list";
	}
	
	@RequestMapping(value="/listCatalog")
	@ResponseBody
	public Object listLatalog(){
		Map<String, Object> map=new HashMap<String, Object>();
		List<CategorySecond> categorys = adminCategorySecondService.listCategorySecond();
		List<CategorySecond> cJsons = new ArrayList<CategorySecond>();
		for(CategorySecond cs : categorys){
			CategorySecond cJson = new CategorySecond();
			cJson.setCsid(cs.getCsid());
			cJson.setCsname(cs.getCategory().getCname() + "->" + cs.getCsname());
			cJsons.add(cJson);
		}
		
		map.put("catalog", cJsons);
		return map;
	}
}
