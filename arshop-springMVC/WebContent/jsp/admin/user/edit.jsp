<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="${pageContext.request.contextPath}/css/Style1.css"
	type="text/css" rel="stylesheet">
</HEAD>

<body>
	<form:form id="userAction_save_do" name="Form1"
		action="${pageContext.request.contextPath}/updateUser" method="post"
		modelAttribute="user">
		<table cellSpacing="1" cellPadding="5" width="100%" align="center"
			bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
			<tr>
				<td class="ta_01" align="center" bgColor="#afd1f3" colSpan="4"
					height="26"><strong><STRONG>Edit Customer</STRONG> </strong></td>
			</tr>
			<form:hidden path="state"/>
			<form:hidden path="uid"/>
			<form:hidden path="code"/>
			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					User Name：</td>
				<td class="ta_01" bgColor="#ffffff"><form:input type="text"
						path="username" id="userAction_save_do_logonName" cssClass="bg" /></td>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					Password：</td>
				<td class="ta_01" bgColor="#ffffff"><form:input type="password"
						path="password" id="userAction_save_do_logonName" cssClass="bg" /></td>
			</tr>
			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					Full Name：</td>
				<td class="ta_01" bgColor="#ffffff"><form:input type="text"
						path="name" id="userAction_save_do_logonName" cssClass="bg" /></td>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					Email：</td>
				<td class="ta_01" bgColor="#ffffff"><form:input type="text"
						path="email" id="userAction_save_do_logonName" cssClass="bg" /></td>
			</tr>
			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					Telephone：</td>
				<td class="ta_01" bgColor="#ffffff"><form:input type="text"
						path="phone" id="userAction_save_do_logonName" cssClass="bg" /></td>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					Address：</td>
				<td class="ta_01" bgColor="#ffffff"><form:input type="text"
						path="addr" id="userAction_save_do_logonName" cssClass="bg" /></td>
			</tr>

			<tr>
				<td class="ta_01" style="WIDTH: 100%" align="center"
					bgColor="#f5fafe" colSpan="4">
					<INPUT type="submit" id="userAction_save_do_submit" value="submit"
						></INPUT> <FONT face="TimesRoman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
					<INPUT type="reset" value="reset"></INPUT>
					<FONT face="TimesRoman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> <INPUT
					 type="button" onclick="history.go(-1)" value="return" />
					<span id="Label1"></span>
				</td>
			</tr>
		</table>
	</form:form>
</body>
</HTML>