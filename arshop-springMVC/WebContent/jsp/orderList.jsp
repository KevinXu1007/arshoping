<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0043)http://localhost:8080/mango/cart/list.jhtml -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Order List</title>
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/cart.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/product.css"
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
			<div class="headerAd">
				
			</div>
		</div>
		<%@ include file="menu.jsp"%>
	</div>

	<div class="container cart">
		<div class="span24">
			<div>
				<ul>
					<li class="current"></li>
					<li><b>My Order</b></li>
				</ul>
			</div>
			<table>
				<tbody>
					<c:forEach var="order" items="${orders}">
						<tr>
							<th colspan="5">No.: <c:out value="${order.oid}" />&nbsp;&nbsp;&nbsp;&nbsp;
								Amount:<font color="red"><c:out value="${order.total }" /></font>
								&nbsp;&nbsp;&nbsp;&nbsp; 
								<c:if test="${order.state == 1}">
									<a
										href="${ pageContext.request.contextPath }/findByOid/<c:out value="${order.oid}" />">
										<font color="red">Check Out</font>
									</a>
								</c:if>
								<c:if test="${order.state == 2}">
									Shipping
								</c:if>
								<c:if test="${order.state == 3}">
									<a href="${ pageContext.request.contextPath }/updateState/<c:out value="${order.oid}" />">Delivery</a>
								</c:if>
								<c:if test="${order.state == 4}">
									Complete
								</c:if>
							</th>
						</tr>
						<tr>
							<th>Image</th>
							<th>Product</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Total</th>
						</tr>
						<c:forEach var="orderItem" items="${order.orderItems}">
							<tr>
								<td width="60"><a
									href="${ pageContext.request.contextPath }/findByPid/<c:out value="${orderItem.product.pid}"/>">
										<img
										src="${ pageContext.request.contextPath }/<c:out value="${orderItem.product.image}"/>" />
								</a></td>
								<td><c:out value="${ orderItem.product.pname}" /></td>
								<td><c:out value="${orderItem.product.shop_price}" /></td>
								<td class="quantity" width="60"><c:out
										value="${orderItem.count}" /></td>
								<td width="140"><span class="subtotal">$<c:out
											value="${orderItem.subtotal}" />
								</span></td>
							</tr>
						</c:forEach>
					</c:forEach>
					<tr>
						<th colspan="5">
							<div class="pagination">
								<span>Page:<c:out value="${page}" />/<c:out
										value="${count}" />
								</span>
								<span><a class="firstPage"
									href="${pageContext.request.contextPath}/findOrderByUid/1"></a></span>
								<c:if test="${page != 1}">
									<span><a class="previousPage"
										href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${page-1}"/>"></a></span>
								</c:if>
								<c:forEach var="i" begin="1" end="${count }">
									<span><c:if test="${i == page }">
											<span class="currentPage">${page }</span>
										</c:if> <c:if test="${i != page }">
											<a
												href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${i}"/>">
												<c:out value="${i}" />
											</a>
										</c:if>
									</span>
								</c:forEach>
								<c:if test="${page !=count }">
									<span><a class="nextPage"
										href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${page+1}"/>"></a></span>
								</c:if>
								<a class="lastPage"
									href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${count}"/>"></a>
							</div>
						</th>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="container footer">
		
		<div class="span24">
			<div class="copyright">Copyright © 2016-2026 arshopping copyright</div>
		</div>
	</div>
</body>
</html>