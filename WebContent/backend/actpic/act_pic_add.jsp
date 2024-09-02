<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.actpic.model.*"%>

<%
    ActPicVO actPicVO = (ActPicVO) request.getAttribute("actPicVO"); 
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�s�W���ʷӤ� - addAct.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/back/backend.css" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/back/backend-addpic.css">


</head>
<body bgcolor='white'>



<%-- ���~��C --%>


<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/actpic/ActPicServlet" name="form1" enctype="multipart/form-data">
<div id="form">
            <li>
                <label for="inputEmail4" class="alert alert-primary" role="alert">���ʷӤ��s��: (Pic_No):</label>
                <input type="text" class="form-control" id="input-Act-no" placeholder="Pic_No"
                name="ActPicNo" size="45" value="<%= (actPicVO==null)? "" : actPicVO.getActPicNo()%>" />
            </li>
            <li>
                <label for="inputPassword4" class="alert alert-danger">���ʶ��ؽs��: (ACT_Event_No):</label>
                <input type="text" class="form-control" id="input-Act-Event-No" placeholder="ACT_Event_No"
                name="ActEventNo" size="45" value="<%= (actPicVO==null)? "" :actPicVO.getActEventNo()%>" /> 
            </li>
        </div>
        <div class="Pic_area">
              <li class="pic">
                <p class="alert alert-primary">���ʷӤ�:(Pic_Load):</p>
                 <img  id="show"  src="#">
                </li>
                 <input  onchange="showImg(this)"  type="file" class="form-control" 
                 aria-label="Amount (to the nearest dollar)" name="ActPic" size="45"
                 value="<%= (actPicVO==null)? "" :actPicVO.getActPic()%>" >
               
             
        </div>
        <div class="btn_area" style="margin:60px auto; margin-left:500px;">
                  <input type="hidden" name="action" value="insert">
                  <button type="submit" class="btn btn-primary">�s�W</button>
                  <button type="reset" class="btn btn-primary">���]</button>
                  <button type="button" class="btn btn-outline-danger" 
                  onclick="location.href='<%=request.getContextPath()%>/backend/actorder/backend-order_select_page.jsp?action=getAll'">
                                                �^����</button>
                  <button type="button" class="btn btn-outline-danger" 
                  onclick="location.href='<%=request.getContextPath()%>/backend/actpic/backend-act_pic_listAll.jsp?action=getAll'">
                                                �����Ӥ�</button>
         </div>
 </div>
        
</FORM>
   
	<script>
	function showImg(thisimg) {
		var file = thisimg.files[0];
		if(window.FileReader) {
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
	 <script src="<%=request.getContextPath()%>/js/jquery-3.5.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.bundle.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.bundle.min.js"></script>
	
     </body>
</html>