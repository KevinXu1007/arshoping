package edu.tamuc.shop.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.tamuc.shop.model.Admin;
import edu.tamuc.shop.model.User;
import edu.tamuc.shop.service.AdminService;

@Controller
public class AdminController {

	@Resource
	private AdminService adminService;

	@ModelAttribute(value="user")
	public void getUser(@RequestParam(value="uid",required=false) Integer uid,Map<String,Object> map){
		 if(uid != null){
			 User user = adminService.findUserByUid(uid);
			 map.put("user", user);
		 }
	}
	@RequestMapping(value="/updateUser")
	public ModelAndView updateUser(@ModelAttribute("user") User user){
		adminService.updateUser(user);
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/listUser/1");
		return model;
	}
	@RequestMapping(value="/editUser/{uid}")
	public String editUser(@PathVariable("uid") Integer uid,@ModelAttribute("user") User user,Map<String,Object> map){
		user = adminService.findUserByUid(uid);
		map.put("user", user);
		return "admin/user/edit";
	}
	
	@RequestMapping(value="/deleteUser/{uid}/{page}")
	public ModelAndView deleteUser(@PathVariable("uid") Integer uid,@PathVariable("page") Integer page){
		adminService.deleteUser(uid);
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/listUser/"+page);
		return model;
	}

	@RequestMapping(value="/listUser/{page}")
	public String listUser(@PathVariable("page") Integer page,Map <String,Object> map) {

        List<User> users= adminService.findUser(page);
        Integer count = adminService.countUser();
        map.put("count", count);
        map.put("page", page);
        map.put("users",users);
		return "admin/user/list";
	}

	@RequestMapping(value = "/adminLogin", method = RequestMethod.POST)
	public String adminLogin(Admin admin,
			HttpSession session) {
		Admin checkUser = adminService.checkUser(admin);
		if (null == checkUser) {
			return "admin/index";
		} else {
			session.setAttribute("admin", admin);
		}
		return "admin/home";
	}

	@RequestMapping(value = "/adminIndex")
	public String adminIndex() {
		return "admin/index";
	}

	@RequestMapping("/adminTop")
	public String adminTop() {
		return "admin/top";
	}

	@RequestMapping("/adminLeft")
	public String adminLeft() {
		return "admin/left";
	}

	@RequestMapping("/adminWelcome")
	public String adminWelcome() {
		return "admin/welcome";
	}

	@RequestMapping("/adminBottom")
	public String adminButtom() {
		return "admin/bottom";
	}
}
