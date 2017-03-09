<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Shopping Cart</title>
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/cart.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="container header">
		<div class="span5">
			<div class="logo">
				<a href="http://localhost:8088/eshop/"> <img
					src="${pageContext.request.contextPath}/image/r___________renleipic_01/logo.jpg"
					alt="Online Shopping" />
				</a>
			</div>
		</div>
		<div class="span9">
			<div class="headerAd">
				
			</div>
		</div>
		<%@ include file="menu.jsp"%>
	</div>
	
	<div class="container cart">
		<c:if test="${fn:length(sessionScope.cart.cartItems)!=0}">
			<div class="span24">
				<table>
					<tbody>
						<tr>
							<th>image</th>
							<th>Product</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Subtotal</th>
							<th>Action</th>
						</tr>
						<c:forEach var="cartItem" items="${sessionScope.cart.cartItems}">
							<tr>
								<td width="60">
									<a href="${pageContext.request.contextPath }/findByPid/<c:out value="${cartItem.product.pid}"/>">
									<img
										src="${pageContext.request.contextPath}/<c:out value="${cartItem.product.image}"/>" />
									</a>
								</td>
								<td>
									<a target="_blank" href="${ pageContext.request.contextPath }/findByPid/<c:out value="${cartItem.product.pid}"/>">
									<c:out value="${cartItem.product.pname}" />
									</a>
								</td>
								<td>$<c:out value="${cartItem.product.shop_price}" />
								</td>
								<td class="quantity" width="60"><c:out value="${cartItem.count}" /></td>
								<td width="140"><span class="subtotal">$<c:out
											value="${cartItem.subtotal}" /></span></td>
								<td><a
									href="${ pageContext.request.contextPath }/removeCart/<c:out value="${cartItem.product.pid}"/>"
									class="delete">Remove</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<dl id="giftItems" class="hidden" style="display: none;">
				</dl>
				
				<div class="total">
					
					Total: <strong id="effectivePrice">$<c:out value="${sessionScope.cart.total}"/>
					</strong>
				</div>
				<div class="bottom">
					<a
						href="${ pageContext.request.contextPath }/clearCart"
						id="clear" class="clear">Clear Cart</a> <a
						href="${pageContext.request.contextPath}/saveOrder"
						id="submit" class="submit">Place the Order</a>
				</div>
		
			</div>
		</c:if>
		
		<c:if test="${fn:length(sessionScope.cart.cartItems) == 0}">
			<div class="span24">
				<div class="step step1">
					<center style="color: red">
						<span><h2>
						<a href="/">
						Nothing in the cart!
						</a>
						</h2></span>
					</center>
				</div>
			</div>
		</c:if>
	</div>
	
	<div class="container footer">
		
		<div class="span24">
			<div class="copyright">Copyright © 2016-2026 arshopping copyright</div>
		</div>
	</div>
</body>
</html>