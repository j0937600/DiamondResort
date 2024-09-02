<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.acttype.model.*"%>

<%
     ActTypeVO actTypeVO = (ActTypeVO) request.getAttribute("actTypeVO"); 
    //ActTypeServlet.java(Concroller), 存入req的ActTYpeVO物件 (包括幫忙取出的ActTYpeVO物件, 也包括輸入資料錯誤時的empActTYpeVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>活動種類修改 - update_act_type_input.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>活動種類修改 - update_act_type_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/acttype/select_page.jsp"><img src="img/logo.png" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/acttype/ActTypeServlet" name="form1">
<table>
	
	<tr>
		<td>選擇種類名稱:</td>
		<td><input type="TEXT" name="ActTypeName" size="45"	placeholder="請輸入新活動種類名稱"
		value="<%=actTypeVO.getActTypeName()%>" /></td>
	</tr>
	<tr>
		<td>新增種類編號:<font color=red><b>*</b></font></td>
		<td><input type="TEXT" name="ActTypeNo" size="45"	placeholder="請輸入新活動種類編號"
		value="<%=actTypeVO.getActTypeNo()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="empno" value="<%=actTypeVO.getActTypeNo()%>">
<input type="submit" value="送出修改"></FORM>
</body>
</html>