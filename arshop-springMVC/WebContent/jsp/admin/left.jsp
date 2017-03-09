<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Menu</title>
<link href="${pageContext.request.contextPath}/css/left.css"
	rel="stylesheet" type="text/css" />
<link rel="StyleSheet"
	href="${pageContext.request.contextPath}/css/dtree.css" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/dtree.js"></script>
</head>
<body>
	<table width="100" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="12"></td>
		</tr>
	</table>
	<table width="100%" border="0">
		<tr>
			<td>
				<div class="dtree">
					<a href="javascript: d.openAll();">Unfold</a> | <a
						href="javascript: d.closeAll();">Fold</a>
					<script type="text/javascript">
						d = new dTree('d');
						d.add('01', -1, 'Menu tree');
						d.add('0101', '01', 'Customers', '', '', 'mainFrame');
						d
								.add(
										'010101',
										'0101',
										'customer',
										'listUser/1',
										'', 'mainFrame');
						d.add('0102', '01', 'Catelog', '', '', 'mainFrame');
						d
								.add(
										'010201',
										'0102',
										'Catelog',
										'${pageContext.request.contextPath}/listCategory/1',
										'', 'mainFrame');
						d.add('0103', '01', 'Second Catelog');
						d
								.add(
										'010301',
										'0103',
										'Second Catelog',
										'${pageContext.request.contextPath}/listCategorySecond/1',
										'', 'mainFrame');
						d.add('0104', '01', 'Product');
						d
								.add(
										'010401',
										'0104',
										'Product',
										'${pageContext.request.contextPath}/listProduct/1',
										'', 'mainFrame');
						d.add('0105', '01', 'Orders');
						d
								.add(
										'010501',
										'0105',
										'Orders',
										'${pageContext.request.contextPath}/listOrder/1',
										'', 'mainFrame');
						document.write(d);
					</script>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>
