<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table width="100%">
	<c:forEach items="${orderItem}" var="i">
		<tr>
			<td><img width="40" height="45"
				src="${ pageContext.request.contextPath }/<c:out value="${ i.product.image}"/>"></td>
			<td><c:out value="${i.product.pname}" /></td>
			<td><c:out value="${i.count}" /></td>
			<td><c:out value="${i.subtotal}" /></td>
		</tr>
	</c:forEach>
</table>