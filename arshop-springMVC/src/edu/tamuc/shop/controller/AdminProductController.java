package edu.tamuc.shop.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import edu.tamuc.shop.model.CategorySecond;
import edu.tamuc.shop.model.Product;
import edu.tamuc.shop.service.AdminCategorySecondService;
import edu.tamuc.shop.service.AdminProductService;

@Controller
public class AdminProductController {
	
	@Resource
	private AdminProductService adminProductService;
	@Resource
	private AdminCategorySecondService adminCategorySecondService;
	
	@RequestMapping(value="/updateProduct")
	public ModelAndView updateProduct(@ModelAttribute("product") Product product
			,@RequestParam("upload")  CommonsMultipartFile upload,HttpServletRequest request,Integer csid){
		ServletContext servletContext = request.getSession().getServletContext();
		
		Product oldProduct = adminProductService.findProduct(product.getPid());
		
		int begin = oldProduct.getImage().lastIndexOf("/");
		String filename = oldProduct.getImage().substring(begin+1,oldProduct.getImage().length());
		System.out.println(filename);
		
		String uploadFilename = upload.getOriginalFilename();
		
		if(filename != uploadFilename && !"".equals(uploadFilename)){
			String path = servletContext.getRealPath("/image/product");
			try {
				FileUtils.writeByteArrayToFile(new File(path,uploadFilename), upload.getBytes());
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			product.setImage("image/product/"+uploadFilename);
			product.setPdate(new Date());
			path = request.getSession().getServletContext().getRealPath("/"+oldProduct.getImage());
			File file = new File(path);
			file.delete();
		}else{
			product.setPdate(new Date());
		}
		if(csid != null){
			CategorySecond categorySecond = adminCategorySecondService.findCategorySecond(csid);
			product.setCategorySecond(categorySecond);
		}
		adminProductService.updateProduct(product);
		ModelAndView modelAndView = new ModelAndView("redirect:/listProduct/1");
		return modelAndView;
	}
	

	@RequestMapping(value="/editProduct/{pid}")
	public ModelAndView editProduct(@PathVariable("pid") Integer pid){
			ModelAndView modelAndView = new ModelAndView("admin/product/edit");
			List<CategorySecond> categorySeconds = adminCategorySecondService.listCategorySecond();
			modelAndView.addObject("categorySeconds", categorySeconds);
			Product product = adminProductService.findProduct(pid);
			modelAndView.addObject("product", product);
			return modelAndView;	
	}
	

	@RequestMapping(value="/deleteProduct/{pid}")
	public ModelAndView deleteProduct(@PathVariable("pid") Integer pid,HttpServletRequest request){
		Product product = adminProductService.findProduct(pid);
		
		String path = request.getSession().getServletContext().getRealPath("/" + product.getImage());
		File file = new File(path);
		file.delete();
		adminProductService.deleteProduct(product);
		ModelAndView modelAndView = new ModelAndView("redirect:/listProduct/1");
		return modelAndView;
	}
	
	
	@RequestMapping(value="/addProduct",method=RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product,
			@RequestParam("upload")  CommonsMultipartFile upload,HttpServletRequest request, Integer csid){	

		ServletContext servletContext = request.getSession().getServletContext();
		String path = servletContext.getRealPath("/image/product");
		String filename = upload.getOriginalFilename();
		try {
			FileUtils.writeByteArrayToFile(new File(path,filename), upload.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		product.setImage("image/product/"+filename);
		
		product.setPdate(new Date());
		
		CategorySecond categorySecond = adminCategorySecondService.findCategorySecond(csid);
		product.setCategorySecond(categorySecond);
		
		adminProductService.saveProduct(product);
		ModelAndView modelAndView = new ModelAndView("redirect:/listProduct/1");
		return modelAndView;
	}
	
	
	@RequestMapping(value="/gotoAddProduct")
	public ModelAndView gotoAddProduct(){
		ModelAndView modelAndView = new ModelAndView("admin/product/add");
		
		List<CategorySecond> categorySeconds = adminCategorySecondService.listCategorySecond();
		modelAndView.addObject("categorySeconds", categorySeconds);
		return modelAndView;
	}
	
	@RequestMapping(value="/listProduct/{page}")
	public String listProduct(@PathVariable("page") Integer page,Map<String,Object> map){		
		List<Product> products = adminProductService.listProduct(page);
		
		Integer count = adminProductService.countProduct();
		map.put("products",products);
		map.put("page", page);
		map.put("count", count);
		return "admin/product/list";
	}
}
