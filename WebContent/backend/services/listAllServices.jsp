<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.services.model.*"%>

<%
ServicesService servicesSvc = new ServicesService();
List<ServicesVO> list = servicesSvc.getAll();
pageContext.setAttribute("list", list);
%>

<jsp:useBean id="serviceTypeSvc" scope="page"
	class="com.service_type.model.ServiceTypeService" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='${pageContext.request.contextPath}/css/datatables.min.css'
	rel='stylesheet' />
<style>
.msg {
	font-size: 30px;
	color: red;
}

.table-serv {
	text-align: center;
}
</style>
<title>服務管理</title>
</head>
<body>
	<div class="msg">
		<%
			String msg = (String) request.getAttribute("msg");
		if (msg != null) {
		%>
		<%=msg%>
		<%}%>
	</div>
	<table id="myTable" class="table-serv">
		<thead>
			<tr>
				<th>服務編號</th>
				<th>服務名稱</th>
				<th>服務類型</th>
				<th>上架狀態</th>
				<th>服務價格</th>
				<th>服務時長</th>
				<th>服務人員人數</th>
				<th>服務圖片</th>
				<th>修改</th>
				<th>刪除</th>
			</tr>
		</thead>
		<tbody>

			<%-- <%@ include file="/backend/files/page1.file"%> --%>
			<c:forEach var="servicesVO" items="${list}">
				<%-- begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>" --%>
				<tr>
					<td>${servicesVO.serv_no}</td>
					<td>${servicesVO.serv_name}</td>
					<td>
						${serviceTypeSvc.getOneServiceType(servicesVO.serv_type_no).serv_type_name}</td>
					<td>${servicesVO.serv_status == 1 ? "已上架" : "未上架"}</td>
					<td>${servicesVO.serv_price}</td>
					<td>${servicesVO.serv_dura}</td>
					<td>${servicesVO.serv_ppl}</td>
					<td><img
						src="<%=request.getContextPath()%>/ServicesServlet?servno=${servicesVO.serv_no}&action=getOneServicesPic"
						alt="" class="img-thumbnail" width="150px"></td>

					<td>
						<FORM METHOD="post"
							ACTION="${pageContext.request.contextPath}/ServicesServlet"
							style="margin-bottom: 0px;">
							<input type="submit" class="btn btn-primary" value="修改">
							<input type="hidden" name="serv_no" value="${servicesVO.serv_no}">
							<input type="hidden" name="action" value="getOne_For_Update">
						</FORM>
					</td>
					<td>
						<FORM METHOD="post"
							ACTION="${pageContext.request.contextPath}/ServicesServlet"
							style="margin-bottom: 0px;">
							<input type="submit" class="btn btn-danger" value="刪除"> <input
								type="hidden" name="serv_no" value="${servicesVO.serv_no}">
							<input type="hidden" name="action" value="delete">
						</FORM>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%-- <%@ include file="/backend/files/page2.file"%> --%>
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
	<script src='${pageContext.request.contextPath}/js/datatables.min.js'></script>
	<script>
		$(document).ready(function() {
			$('#myTable').DataTable();
		});
	</script>


</body>
</html>