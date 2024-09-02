<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.actorder.model.*"%>
<jsp:useBean id="actoderSvc" scope="page" class="com.actorder.model.ActOrderService"/>
<%	
	ActOrderService actorderSvc = new ActOrderService();
	List<ActOrderVO> actOrderList = (List<ActOrderVO>) request.getAttribute("actOrderList");
	if (actOrderList == null) {
		actOrderList = actorderSvc.getAll();
	}
	pageContext.setAttribute("actOrderList", actOrderList);
%>
<html>
<head>
</head>
<body>
	<div>
		<div>
			<label for="search">�渹�d��</label>
			<input type="text" id="search" style="text-transform:uppercase; margin-right:10px;">
			<label for="order_status">�q�檬�A</label>
			<select id="order_status" name="order_status">
				<option value="all">�����q��</option>
				<option value="0">�����b</option>
				<option value="1">�w���b</option>
				<option value="2">�w����</option>
			</select>
		</div>
		<table>
			<tr>
				<th>���ʭq��s��</th>
				<th>���ʽs��</th>
				<th>�q�нs��</th>
				<th>�q�檬�A</th>
				<th>�q����</th>
				<th>�ѥ[�H��</th>
				<th>�q����B</th>
				<th>�ק�</th>
			</tr>
			<c:if test="${actOrderList.size() == 0}">
				<tr>
					<td colspan="8">�d�L�q��</td>
				</tr>
			</c:if>
			<c:forEach var="actOrderVO" items="${actOrderList}">
					
					<tr>
						<td>${actOrderVO.actOdno}</td>
						<td>${actOrderVO.actNo}</td>
						<td>${actOrderVO.bkNo}</td>
						<td><c:choose>
								<c:when test="${actOrderVO.odStatus == 0}">�����b</c:when>
								<c:when test="${actOrderVO.odStatus == 1}">�w���b</c:when>
								<c:when test="${actOrderVO.odStatus == 2}">�w����</c:when>
							</c:choose></td>
						<td>${actOrderVO.odTime}</td>
						<td>${actOrderVO.ppl}</td>
						<td>${actOrderVO.totalPrice}</td>
						<td>
							<button type="submit" class="btn btn-outline-dark update" data-actodno="${actOrderVO.actOdno}">�ק�q��</button>
						</td>
					</tr>
			</c:forEach>	
			
		</table>
	</div>
	<div class="info-display" id="update-frame">
			<div class="close-icon">
				<i class="fas fa-times icon"></i>
			</div>
			<iframe src="" style="border: none; height: 100%; width: 100%;"></iframe>
	</div>
	<script>
	$(document).ready(function(){
		let display = $("#update-frame");
	    $(".update").click(function (e) {
	        e.preventDefault();
	        let actodno = $(this).attr("data-actodno");
	        let url = "<%=request.getContextPath()%>/ActOrderServlet?action=getOne_For_Update&actOdno=" + actodno;
			display.addClass("display-show");
			display.children("iframe").attr("src", url);
		});

		$(".icon").click(function() {
			$(this).parents(".display-show").removeClass("display-show");
		});
		
		$("#search").keyup(function(e){
			if (event.keyCode == 13) {
				let actodno = $(this).val();
				window.location.href = "<%=request.getContextPath()%>/ActOrderServlet?action=getOne_For_Display&actOdno=" + actodno;
				
			}
		})
		$("#order_status").change(function(){
			let status = $(this).val();
			window.location.href = "<%=request.getContextPath()%>/ActOrderServlet?action=getAllByOdStatus&odstatus=" + status;
		})
	})
	</script>
</body>
</html>