<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Sign Up</title>
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/register.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<style>
.error{color:red}
</style>
<script>
	function checkForm() {
		var username = $("#username").val();
		if (username == null || username == '') {
			alert("Please input UserName");
			return false;
		}
		var password = $("#password").val();
		if (password == null || password == '') {
			alert("Please input password!");
			return false;
		}
		var repassword = $("#repassword").val();
		if (repassword != password) {
			alert("No match password!");
			return false;
		}

	}
	function checkUsername() {
		$.post(
			"checkUser/" + $("#username").val(),
			{},
			function(data) {
				if (data == 1) {
					document.getElementById("span1").innerHTML = "<font color='red'>The user exist!</font>";
					$("#username").val("");
					$("#username").focus();
					$(".submit").unbind("click",
							function(event){
						
					});
				} else {
					document.getElementById("span1").innerHTML = "<font color='green'>User name avaliable</font>";
				}
		});
	}
</script>
</head>
<body>
	<div class="container header">
		<div class="span5">
			<div class="logo">
				<a href="http://localhost:8080/mango/"> <img
					src="${pageContext.request.contextPath}/image/r___________renleipic_01/logo.jpg"
					/></a>
			</div>
		</div>
		<div class="span9">
			
		</div>
		<%@ include file="menu.jsp"%>
	</div>
	<div class="container register">
		<div class="span24">
			<div class="wrap">
				<div class="main clearfix">
					<div class="title">
						<strong>Sign Up</strong>USER REGISTER
					</div>
					<form:form commandName="user" 
						action="${ pageContext.request.contextPath }/register"
						method="post" modelAttribute="user"
						onsubmit="return checkForm();">
						<table>
							<tbody>
								<tr>
									<th><span class="requiredField">*</span>UserName:</th>
									<td><form:input path="username" id="username"
										class="text" maxlength="20" onblur="checkUsername()"/> <span
										id="span1" style="padding-left: 10px;"></span></td>
								</tr>
								<tr>
									<th><span class="requiredField">*</span>Password:</th>
									<td><form:password path="password" id="password" name="password"
										class="text" maxlength="20" /></td>
								</tr>
								<tr>
									<th><span class="requiredField">*</span>Confirm Password:</th>
									<td><input id="repassword" type="password"
										name="repassword" class="text" maxlength="20" /></td>
								</tr>
								<tr>
									<th><span class="requiredField">*</span>E-mail:</th>
									<td><form:input path="email" id="email"
										class="text" maxlength="20" />
									<form:errors path="email" cssClass="error"/>
										</td>
								</tr>
								<tr>
									<th>Full Name:</th>
									<td><form:input path="name" class="text"
										maxlength="200" /></td>
								</tr>
								<tr>
									<th>Telephone:</th>
									<td><form:input path="phone" class="text" /></td>
								</tr>
								<tr>
									<th>Address:</th>
									<td><form:input path="addr" class="text"
										maxlength="200" /></td>
								</tr>
								<tr>
									<th><span class="requiredField">*</span>Valid Code:</th>
									<td><span class="fieldSet"> <input type="text"
											id="checkcode" name="checkcode" class="text captcha"
											maxlength="4" /> <img id="checkImg" class="captchaImage"
											src="${pageContext.request.contextPath}/getCheckCodeImage"
											onclick="changeImg()" title="click to change" /></span>
											<c:if test="${errorCheckCode !=null}">
											   <font color="red">error code</font>
											</c:if>
									</td>
								</tr>
								<tr>
									<th>&nbsp;</th>
									<td><input type="submit" class="submit" value="Agree and Submit" /></td>
								</tr>
								<tr>
									<th>&nbsp;</th>
									<td>Agreement</td>
								</tr>
								<tr>
									<th>&nbsp;</th>
									<td>
										<div id="agreement" class="agreement" style="height: 200px;">
											Agreement
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="login">
							
							<dl>
								<dt>Registered Customer？</dt>
								<dd>
									 <a href="${pageContext.request.contextPath}/userLogin">Sign In</a>
								</dd>
							</dl>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<div class="container footer">
		
		<div class="span24">
			<div class="copyright">Copyright © 2016-2026 arshopping copyright</div>
		</div>
	</div>
	<div id="_my97DP"
		style="position: absolute; top: -1970px; left: -1970px;">
	</div>
	<script type="text/javascript">
		function changeImg() {
			var img1 = document.getElementById("checkImg");
			img1.src = "${pageContext.request.contextPath}/getCheckCodeImage"
					+ "?date=" + new Date();
		}
	</script>
</body>
</html>
