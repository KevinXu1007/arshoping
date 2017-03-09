<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="span10 last">
	<div class="topNav clearfix">
		<ul>
			<c:if test="${sessionScope.user == null}">
				<li id="headerLogin" class="headerLogin" style="display: list-item;">
					<a
					href="${ pageContext.request.contextPath }/userLogin">Sign In</a>|
				</li>
				<li id="headerRegister" class="headerRegister"
					style="display: list-item;"><a
					href="${ pageContext.request.contextPath }/userRegister">Sign Up</a>|
				</li>
			</c:if>
			<c:if test="${sessionScope.user != null}">
				<li id="headerLogin" class="headerLogin" style="display: list-item;">
					<c:out value="${user.username }"/>
				</li>
				<li id="headerLogin" class="headerLogin" style="display: list-item;">
					<a
					href="${ pageContext.request.contextPath }/findOrderByUid/1">My Order</a>
					|
				</li>
				<li id="headerRegister" class="headerRegister"
					style="display: list-item;"><a
					href="${ pageContext.request.contextPath }/quit">Exit</a>|
				</li>
			</c:if>
			<li><a>About Us</a></li>
		</ul>
	</div>
	<div class="cart">
		<a href="${pageContext.request.contextPath}/myCart">Cart</a>
	</div>
	<div class="phone">
		tel: <strong>800-888-8888</strong>
	</div>
</div>
<div class="span24">
	<ul class="mainNav">
		<li><a href="${ pageContext.request.contextPath }/index">Home</a>|</li>
		<c:forEach items="${sessionScope.cList}" var="c">
		   <li><a
				href="${ pageContext.request.contextPath }/findByCid/<c:out value="${c.cid}"/>/1">
				<c:out value="${c.cname}"></c:out> 
			  </a>
		   </li>
		</c:forEach>
	</ul>
</div>