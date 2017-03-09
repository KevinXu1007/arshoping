<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0043)http://localhost:8080/mango/cart/list.jhtml -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Order</title>
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/cart.css"
	rel="stylesheet" type="text/css" />

</head>
<body>

	<div class="container header">
		<div class="span5">
			<div class="logo">
				<a href="/"> <img
					src="${pageContext.request.contextPath}/image/r___________renleipic_01/logo.jpg"
					/>
				</a>
			</div>
		</div>
		<div class="span9">
			
		</div>
		<%@ include file="menu.jsp"%>
	</div>
	<div class="container cart">
		<div class="span24">
			<div class="step step1">
				<ul>
					<li class="current"></li>
					<li>Order information</li>
				</ul>
			</div>
			<table>
				<tbody>
					<tr>
						<th colspan="5">No.:<c:out value="${order.oid}" />&nbsp;&nbsp;&nbsp;&nbsp;
						</th>
					</tr>
					<tr>
						<th>Image</th>
						<th>Product</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Subtotal</th>
					</tr>
					<c:forEach var="orderItem" items="${order.orderItems}">
						<tr>
							<td width="60"><img
								src="${ pageContext.request.contextPath }/<c:out value="${ orderItem.product.image}"/>" />
							</td>
							<td><c:out value="${orderItem.product.pname}" /></td>
							<td><c:out value="${orderItem.product.shop_price}" /></td>
							<td class="quantity" width="60">
							<c:out value="${orderItem.count}" /></td>
							<td width="140"><span class="subtotal">￥
							<c:out	value="${orderItem.subtotal}" /></span></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<dl id="giftItems" class="hidden" style="display: none;">
			</dl>
			<div class="total">
				<em id="promotion"></em> Total: <strong id="effectivePrice">$<c:out
						value="${order.total}" />
				</strong>
			</div>
			<form id="orderForm"
				action="${ pageContext.request.contextPath }/payOrder"
				method="post">
				<input type="hidden" name="oid"
					value="<c:out value="${order.oid}"/>" />
				<div class="span24">
					<p>
						Address: <input name="addr" type="text"
							value="<c:out value="${sessionScope.user.addr}"/>"
							style="width: 350px" /> <br /> Contact&nbsp;&nbsp;&nbsp;: <input
							name="name" type="text"
							value="<c:out value="${sessionScope.user.username}"/>"
							style="width: 150px" /> <br /> Telephone: <input name="phone"
							type="text" value="<c:out value="${sessionScope.user.phone}"/>"
							style="width: 150px" />

					</p>
					<hr />
					<p>
						Payment：<br /> <input type="text" name="payment"
							/>
					</p>
					<hr />
					<p style="text-align: right">
						<a
							href="javascript:document.getElementById('orderForm').submit();">
							<img
							src="${pageContext.request.contextPath}/images/finalbutton.gif"
							width="204" height="51" border="0" />
						</a>
					</p>
				</div>
			</form>
		</div>

	</div>
	<div class="container footer">
		
		<div class="span24">
			<div class="copyright">Copyright © 2016-2026 arshopping copyright</div>
		</div>
	</div>
</body>
</html>