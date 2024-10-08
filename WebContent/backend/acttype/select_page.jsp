<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>CEA101G1-ACT</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>活動種類</h3><h4>( ACT_TYPE )</h4></td></tr>
</table>

<p>This is the Home page for ACT_TYPE</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  
  <li><a href='<%=request.getContextPath()%>/backend/acttype/listAllAct.jsp?action=getAll'> List</a> all ActType    <h4>(getFromSession).</h4> <br><br><br></li>
  

   <jsp:useBean id="ActTypeSvc" scope="page" class="com.acttype.model.ActTypeService" />
   
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/acttype/ActTypeServlet" >
        <b>請輸入活動種類編號 (如0、1、2):</b>
        <input type="text" name="actTypeNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/acttype/ActTypeServlet" >
       <b>選擇活動種類編號:</b>
       <select size="1" name="actTypeNo">
         <c:forEach var="actTypeVO" items="${ActTypeSvc.all}" > 
          <option value="${actTypeVO.actTypeNo}">${actTypeVO.actTypeNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/acttype/ActTypeServlet" >
       <b>選擇種類名稱:</b>
       <select size="1" name="actTypeNo">
         <c:forEach var="actTypeVO" items="${ActTypeSvc.all}" > 
          <option value="${actTypeVO.actTypeNo}">${actTypeVO.actTypeName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>
<h3>活動種類管理</h3>

<ul>
  <li><a href='addAct.jsp'>Add</a> 新增活動種類.</li>
</ul>

<script>    
   function fun1(){
      with(document.form1){
         if (empno.value=="") 
             alert("請輸入活動種類編號!");
         else if (isNaN(empno.value)) 
             alert("編號格式不正確!");
         else
             submit();
      }
   }
</script>

</body>
</html>