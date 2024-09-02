<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.act.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
	ActService actSvc = new ActService();
    List<ActVO> list = actSvc.getAll();
    pageContext.setAttribute("list", list);
%>



<html>
<head>
<title>�Ҧ����ʸ�� - listAllAct.jsp</title>
</head>
<body>
	<div>
		<div class="showmsg">
			<h3 class="msg">
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">�Эץ��H�U���~:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
			</h3>
			<p class="roomtotal">
				��e�����`��<b><%=list.size()%></b>
			</p>
		</div>
		<div>
			<table>
				<tr>
					<th>���ʽs��</th>
					<th>�������O</th>
					<th>���ʦW��</th>
					<th>���ʪ��A</th>
					<th>���ʶ}�l�ɶ�</th>
					<th>���ʻ���</th>
					<th>�קﬡ��</th>
				</tr>
				<jsp:useBean id="eventSvc" scope="request"
					class="com.actevent.model.ActEventService" />
				<c:forEach var="actVO" items="${list}">
					<tr>
						<td>${actVO.actNo}</td>
						<td>${eventSvc.getOneActEvent(actVO.actEventNo).actEventName}</td>
						<td>${actVO.actName}</td>
						<td><c:choose>
								<c:when test="${actVO.actStatus == 0}">���}�l</c:when>
								<c:when test="${actVO.actStatus == 1}">�i�椤</c:when>
							</c:choose></td>
						<td>${actVO.actTime}</td>
						<td>${actVO.actPrice}</td>
						<td>
							<button class="update btn btn-primary"
								data-actno="${actVO.actNo}">�ק�</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="info-display" id="update-frame">
			<div class="close-icon">
				<i class="fas fa-times icon"></i>
			</div>
			<iframe id="myIframe" src="" style="border: none;"></iframe>
		</div>
	</div>
	<script>
	$(document).ready(function(){
		let display = $("#update-frame");
	    $(".update").click(function (e) {
	        e.preventDefault();
	        let actno = $(this).attr("data-actno");
	        let url = "<%=request.getContextPath()%>/ActServlet?action=getOne_For_Update&actNo=" + actno;
			display.addClass("display-show");
			display.children("iframe").attr("src", url);
		});

			$(".icon").click(function() {
				$(this).parents(".display-show").removeClass("display-show");
			});
			 let iframe = document.getElementById("myIframe");
			 iframe.onload = function(){
			        iframe.style.height = iframe.contentWindow.document.body.scrollHeight + 'px';
			        iframe.style.width = iframe.contentWindow.document.body.scrollWidth + 'px';
			    }
	})
	
	</script>
</body>
</html>