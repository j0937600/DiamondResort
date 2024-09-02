<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.act.model.*"%>

<%
	ActVO actVO = (ActVO) request.getAttribute("actVO");
//ActServlet.java(Concroller), �s�Jreq��ActVO���� (�]�A�������X��ActVO����, �]�]�A��J��ƿ��~�ɪ�ActVO����)
%>

<html>
<head>
<%@ include file="/backend/files/backend_header.file"%>
<!-- �[�J�� css -->
<title>�קﬡ�� - addAct.jsp</title>
</head>
<style>
	#show {
	max-width: 100%;
	}
	#pic-area {
		width:400px;
		margin: 0 auto;
	}
	.message {
		text-align: center;
	}
	#form {
		height:500px;
		width:600px;
	}
</style>
<body>
	<jsp:useBean id="eventSvc" scope="page" class="com.actevent.model.ActEventService" />
	<FORM METHOD="post" id="act-form" enctype="multipart/form-data">
		<div id="form" class="update-form">
			<label>���ʶ��ؽs��:(ACT_Event_No):</label>
			<select name="actEventNo" id="actEventNo">
					<c:forEach var="event" items="${eventSvc.all}">
					<option value="${event.actEventNo}">${event.actEventName}</option>
					</c:forEach>
				</select>
			<label>���ʦW��: (ACT_Name):</label> 
				<input type="text" name="actName" size="45" placeholder="�п�J���ʦW��" value="<%=(actVO == null) ? "" : actVO.getActName()%>" /> 
				<label>���ʪ��A: (ACT_Status):</label> 
				<select name="actStatus">
					<option value="0"  <c:if test="${actVO.actStatus == '0' }">selected</c:if> >�w����</option>
					<option value="1"  <c:if test="${actVO.actStatus == '1' }">selected</c:if>>�i�椤</option>
					<option value="2"  <c:if test="${actVO.actStatus == '2' }">selected</c:if>>�w����</option>
				</select>
				<label>���ʮɬq: (ACT_Time):</label> 
				<input type="text" class="form-control" id="actTime" name="actTime" size="45" value="<%=actVO.getActTime()%>" />
				<label>���ʻ���:</label> 
				<input type="number"name="actPrice" size="45" placeholder="�ж�J�Ʀr"
				value="<%=(actVO == null) ? "" : actVO.getActPrice()%>" /> <label
				class=" ">���ʷӤ�:(Pic_Load):</label>
			<div id="pic-area">
				<img id="show" src="<%=request.getContextPath()%>/ActServlet?action=get_actpic&actno=<%=actVO.getActNo()%>">
			</div>
			<input onchange="showImg(this)" type="file" name="actPic"> 
			<label>���ʱԭz:</label> 
			<textarea name="actInfo" placeholder="���ʤ��e" > <%=actVO.getActInfo()%></textarea>
			<input type="hidden" name="action" value="update"> 
			<input type="hidden" name="actNo" value="<%=actVO.getActNo()%>">
			<button type="submit" class="btn btn-primary">�e�X�ק�</button>
		</div>
	</FORM>
	<!-- �������e���� -->
	<%@ include file="/backend/files/backend_footer.file"%>
	<!-- �[�J�� js -->
	<script>
		$( document ).ready(function(){
			
			let formElem = document.querySelector("#act-form");
            formElem.addEventListener("submit", (e) => {
                e.preventDefault();
               
                let data = new FormData(formElem);
                let xhr = new XMLHttpRequest();
                xhr.open("post", "${pageContext.request.contextPath}/ActServlet");
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
                            } else if (xhr.responseText === "�s������") {
                                Swal.fire({
                                    position: "top-end",
                                    icon: "error",
                                    title: xhr.responseText,
                                    showConfirmButton: false,
                                    timer: 1500,
                                });
                            }
                        }
                    }
                };
                xhr.send(data);
            });
			
			
		$("#actTime").datetimepicker({
			datepicker:false,
			format: "h:i",
			step: 60,
		});
	}) 
	function showImg(thisimg) {
				var file = thisimg.files[0];
				if (window.FileReader) {
					var fr = new FileReader();
	
					var showimg = document.getElementById('show');
					fr.onloadend = function(e) {
						showimg.src = e.target.result;
					};
					fr.readAsDataURL(file);
					showimg.style.display = 'block';
				}
			}
	</script>
</body>
</html>