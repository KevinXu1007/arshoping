package edu.tamuc.shop.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.tamuc.shop.model.User;
import edu.tamuc.shop.service.UserService;

@Controller
public class UserController{

	@Resource
	private UserService userService;
	
	@ModelAttribute
	public User getUser(){
		return new User();
	}
	
	@RequestMapping("/quit")
	public String quit(HttpSession session,HttpServletRequest request){
		request.getSession().invalidate();
		return "redirect:index";
	}
	@RequestMapping(value="login")
	public String login(@ModelAttribute("user") User user, String checkcode,
			HttpSession session,Map<String,Object> map){
		String checkCode = (String) session.getAttribute("checkcode");
		if(! checkCode.equalsIgnoreCase(checkcode)){
			map.put("errorCheckCode", "errorCheckCode");
			return "login"; 
		}
		
		User isExistUser = userService.existUser(user.getUsername());
		if(isExistUser == null){
			map.put("notUser", "notUser");
			return "login";
		}
		
		User u = userService.existUser(user.getUsername());
		if(u.getState() == 0){
			map.put("notActive","notActive");
			return "login";
		}
		
		u = userService.findUserByUsernameAndPassword(user);
		if(u == null){
			map.put("notPassword", "notPassword");
			return "login";
		}
		session.setAttribute("user", u);
		return "redirect:index";
	}
	
	
	@RequestMapping(value="/userLogin")
	public String userLogin(){
		return "login";
	}
	
	@RequestMapping(value="/active/{code}")
	public String active(@PathVariable("code") String code,Map<String,Object> map){
		User user = userService.active(code);
		if(user == null){
			map.put("notUser", "notUser");
			return "msg";
		}
		user.setCode("");
		user.setState(1);
		userService.update(user);
		map.put("activeSuccess","activeSuccess");
		return "msg";
	}
	
	
	@RequestMapping(value = "register",method=RequestMethod.POST)
	public String register(@ModelAttribute @Valid User user,BindingResult result,HttpSession session,
			String checkcode,Map<String,Object> map) {
		
		if (result.hasErrors()){
            List<ObjectError> errorList = result.getAllErrors();
            for(ObjectError error : errorList){
                System.out.println(error.getDefaultMessage());
            }
            
            return "regist";
        }
		
		String checkCode = (String) session.getAttribute("checkcode");
		
		if(! checkCode.equalsIgnoreCase(checkcode)){
			map.put("errorCheckCode", "errorCheckCode");
			return "regist"; 
		}
		userService.register(user);
		return "msg";
	 }
	
	@RequestMapping(value="/checkUser/{userName}",method=RequestMethod.POST)
	@ResponseBody
	public String existUser(@PathVariable("userName") String userName, HttpServletResponse response) 
			throws IOException {
		System.out.println(userName);
		response.setContentType("text/html;charset=UTF-8");
		if (userService.existUser(userName) != null) {
			response.getWriter().println("1");
		} else {
			response.getWriter().println("0");
		}
		return null;
	}

	@RequestMapping("userRegister")
	public String register() {
		return "regist";
	}
	
}