<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.act.model.*"%>

<%
	ActVO actVO = (ActVO) request.getAttribute("actVO");
%>
<html>
<head>
<meta charset="UTF-8" />
<title>�s�W���ʭq�� - addAct.jsp</title>
</head>
<style>
	#show {
	max-width: 100%;
	}
	#pic-area {
		width:400px;
		margin: 0 auto;
	}
</style>
<body>
	<div>
		<div class="showmsg">
			<h3 class="msg">
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">�Эץ��H�U���~:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}
						</c:forEach>
					</ul>
				</c:if>
			</h3>
		</div>
		<FORM METHOD="post" id="act-form" enctype="multipart/form-data">
			<div id="form" class="insert">
				<label for="actEventNo" class="">��������</label>
				<select name="actEventNo" id="actEventNo">
					<c:forEach var="event" items="${eventSvc.all}">
					<option value="${event.actEventNo}">${event.actEventName}</option>
					</c:forEach>
				</select>
				<label>���ʦW��(ACT_Name):</label> 
				<input type="text" name="actName" placeholder="�п�J���ʦW��"/>
				<label>���ʪ��A:(ACT_Status):</label> 
				<select name="actStatus">
					<option value="0">�w����</option>
					<option value="1">�i�椤</option>
					<option value="2">�w����</option>
				</select>
				<label>���ʮɬq: (ACT_Time):</label> 
				<input type="text" id="actTime" name="actTime" size="45"/>
				<label class=" " role="">���ʻ���:</label>
					<input type="text"
					name="actPrice" size="45" placeholder="�ж�J�Ʀr" />
				<label>���ʷӤ�:(Pic_Load):</label>
					<input onchange="showImg(this)" type="file" class="form-control" name="ActPic">
					<div id="pic-area">
						<img id="show">
					</div>
				<label class=" " role="">���ʱԭz:</label>
					<textarea name="actInfo" placeholder="���ʤ��e�ԭz"></textarea>
			</div>
			<div class="message">
				<input type="hidden" name="action" value="insert">
				<button type="submit" class="btn btn-primary">�s�W</button>
				<button type="reset" class="btn btn-primary">���]</button>
			</div>
		</FORM>
	</div>
	<script>
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
	                                    location.reload();
	                                }, 1400);
	                            } else {
	                                Swal.fire({
	                                    position: "top-end",
	                                    icon: "error",
	                                    title:"�o�Ϳ��~",
	                                    text: xhr.responseText,
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
				format: "H:i",
				step: 60,
			});
		}) 
	</script>
</body>
</html>