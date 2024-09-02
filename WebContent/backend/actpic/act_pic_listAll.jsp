<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.actpic.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
	ActPicService actPicSvc = new ActPicService();
	List<ActPicVO> list = actPicSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>�Ҧ����ʷӤ���� - listAll_ActPIC.jsp</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/back/backend.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/back/backend-search.css" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/back/backend-select_page.css" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/back/backend-add.css" type="text/css" />

</head>
<body bgcolor='white'>

	<%-- ���~��C --%>
	 
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<div class="logo">
			<img src="<%=request.getContextPath()%>/img/logo.png" style="margin-left: 450px;">
		</div>
		<div class="form-title">
			<img src="<%=request.getContextPath()%>/img/loading.png">
			<h2 style="margin-left: 80px;">�����Ӥ�</h2>
		</div>
    <!-- Example single danger button -->


	<div class="table-content" id="content">
	      <nav class="navbar-top navbar-light">
			<form class="form-inline">
				<button class="btn btn-outline-danger" type="button" 
				onclick="location.href='<%=request.getContextPath()%>/backend/actorder/backend-order_select_page.jsp'">
				  �^�q��d��
				</button>
				<button class="btn btn-outline-danger" type="button" 
				onclick="location.href='<%=request.getContextPath()%>/backend/act/backend-act_select_page.jsp'">
				  �^���ʬd��
				</button>
				<button class="btn btn-outline-danger" type="button" 
				onclick="location.href='<%=request.getContextPath()%>/backend/actpic/backend-act_pic_add.jsp'">
				  �s�W�Ӥ�
				</button>
		    </form>
		   </nav>
		   
		<table class="table table-hover" id="table">
			<thead class="title">
				<tr class="table-primary">
					<th>���ʷӤ��s��</th>
					<th>���ʶ��ؽs��</th>
					<th>���ʷӤ�</th>
					<!--<th>�ק�</th>  -->
					<th>�R��</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="actPicVO" items="${list}">
					<tr>
						<td>${actPicVO.actPicNo}</td>
						<td>
						<c:choose>
							   <c:when test="${actPicVO.actEventNo == 10}">�F�y��</c:when>
							   <c:when test="${actPicVO.actEventNo == 20}">�g�b</c:when>
							   <c:when test="${actPicVO.actEventNo == 30}">�O�|</c:when>
							   <c:when test="${actPicVO.actEventNo == 40}">�Į�</c:when>
							   <c:when test="${actPicVO.actEventNo == 50}">�B��</c:when>
							   <c:when test="${actPicVO.actEventNo == 60}">���H</c:when>
							   <c:when test="${actPicVO.actEventNo == 70}">BBQ</c:when>
							   <c:when test="${actPicVO.actEventNo == 80}">�`��</c:when>
							   <c:when test="${actPicVO.actEventNo == 90}">���y</c:when>
						</c:choose>
						</td>
						<td>
						     <img src="<%=request.getContextPath()%>/ActPicReaderServlet?actPicNo=${actPicVO.actPicNo}&action=getOnePic">
						</td>

						<!-- <td>
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/actpic/ActPicServlet"
								style="margin-bottom: 0px;">
								<button type="submit" class="btn btn-outline-dark">�ק�</button>
								<input type="hidden"name="ActPicNo" value="${actPicVO.actPicNo}"> 
								<inputtype="hidden" name="action" value="getOne_For_Update">
							</FORM>
						</td> -->
						<td>
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/actpic/ActPicServlet"
								style="margin-bottom: 0px;">
								<input type="hidden"name="ActPicNo" value="${actPicVO.actPicNo}"> 
								<input type="hidden" name="action" value="delete">
								<button type="submit" class="btn btn-outline-dark">�R��</button>
							</FORM>
						</td>
					</tr>
				</c:forEach>
			
			</tbody>
		</table>
	</div>
</body>
    <script src="<%=request.getContextPath()%>/js/jquery-3.5.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
	<script src="<%=request.getContextPath()%>/js/index-back.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.bundle.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.bundle.min.js"></script>
</html>