<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.actorder.model.*"%>
<%
	ActOrderVO actOrderVO = (ActOrderVO) request.getAttribute("actOrderVO");
%>
<html>
<head>
<%@ include file="/backend/files/backend_header.file"%>
<!-- �[�J�� css -->
<title>�ק�q�� - addAct.jsp</title>
</head>
<body>
	<FORM METHOD="post" class="update-form" id="actorder-form" enctype="multipart/form-data">
	

		<label>���ʭq��s��: (ACT_ODNo): <%=actOrderVO.getActOdno()%></label> <label>���ʽs��
			(ACT_No): <%=actOrderVO.getActNo()%></label> <label>�q�нs��: (BK_NO): <%=actOrderVO.getBkNo()%></label>
		<label for="order_status">�q�檬�A</label> <select id="order_status"
			name="order_status" required>
			<option value="0"
				<c:if test="<%=actOrderVO.getOdStatus().equals(\"0\")%>">selected</c:if>>�����b</option>
			<option value="1"
				<c:if test="<%=actOrderVO.getOdStatus().equals(\"1\")%>">selected</c:if>>�w���b</option>
			<option value="2"
				<c:if test="<%=actOrderVO.getOdStatus().equals(\"2\")%>">selected</c:if>>�w����</option>
		</select> <label>�ѥ[�H��:</label> <input type="number" name="ppl" 
			 value="<%=actOrderVO.getPpl()%>" /> <input
			type="hidden" name="action" value="update"> <input
			type="hidden" name="actNo" value="<%=actOrderVO.getActNo()%>">
		<input type="hidden" name="actOdno"
			value="<%=actOrderVO.getActOdno()%>">
		<button type="submit" class="btn btn-outline-danger" style="margin-top:10px;">�e�X�ק�</button>
	</FORM>
	<!-- �������e���� -->

	<%@ include file="/backend/files/backend_footer.file"%>
	<!-- �[�J�� js -->
	<script>
 let formElem = document.querySelector("#actorder-form");
 formElem.addEventListener("submit", (e) => {
     e.preventDefault();
     let data = new FormData(formElem);
     let xhr = new XMLHttpRequest();
     xhr.open("post", "${pageContext.request.contextPath}/ActOrderServlet");
     xhr.onload = function () {
         if (xhr.readyState === xhr.DONE) {
             if (xhr.status === 200) {
                 if (xhr.responseText === "success") {
                     Swal.fire({
                         position: "top-end",
                         icon: "success",
                         title: xhr.responseText,
                         showConfirmButton: false,
                         timer: 1500,
                     });
                     setTimeout(function () {
                         window.parent.location.reload();
                     }, 1400);
                 } else  {
                     Swal.fire({
                         position: "top-end",
                         icon: "error",
                         title:"����",
                         showConfirmButton: false,
                         timer: 1500,
                     });
                 }
             }
         }
     };
     xhr.send(data);
 });
 </script>
</body>
</html>