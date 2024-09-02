<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.bookingorder.model.*"%>
<%@ page import="com.rooms.model.*"%>
<%@ page import="com.members.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.stream.Collectors" %>
<%
BookingOrderService bkodSvc = new BookingOrderService();
LocalDate today = LocalDate.now();
List<BookingOrderVO> checkIns = bkodSvc.getAllBeforeToday(today);
List<BookingOrderVO> checkOuts = bkodSvc.getAllByDateOut(today).stream().filter(e -> e.getBk_status().equals("2")).collect(Collectors.toList()); //取得當天尚未CheckOut的訂單
List<BookingOrderVO> checkeds = bkodSvc.getAllByBkStatus(BKSTATUS.CHECKED);
pageContext.setAttribute("checkIns", checkIns);
pageContext.setAttribute("checkOuts", checkOuts);
pageContext.setAttribute("checkeds", checkeds);

%>
<jsp:useBean id="mbSvc" scope="page"
	class="com.members.model.MembersService" />
<jsp:useBean id="bkdetailSvc" scope="page"
	class="com.bookingdetail.model.BookingDetailService" />
<jsp:useBean id="rmtypeSvc" scope="page"
	class="com.roomtype.model.RoomTypeService" />
<jsp:useBean id="rmSvc" scope="page"
	class="com.rooms.model.RoomsService" />
<jsp:useBean id="pkupSvc" scope="page"
 	class="com.pickup.model.PickupService"/>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/img/loading.png" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/back/backend_sidebar.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/back/counterSystem.css">
<title>戴蒙酒店房務系統</title>
</head>
<body>
	<%@ include file="/backend/files/backend_sidebar.file"%>
	<div class="wrapper">
		<div class="header">
			<div>
				<h4><i class="far fa-clock"></i>現在時間</h4>
				<h3><%=LocalDate.now()%><span id="clock"></span></h3>
			</div>
			<div>
				<h4><i class="fas fa-sign-in-alt"></i>今日待入住訂單</h4>
				<h3 style="color:crimson">${checkIns.size()}</h3>
			</div>
			<div>
				<h4>今日待退房訂單<i class="fas fa-sign-out-alt"></i></h4>
				<h3 style="color:green">${checkOuts.size()}</h3>
			</div>
			<% 
				List<BookingOrderVO> list = bkodSvc.getAllByBkStatus(BKSTATUS.CHECKED);
				int totalGuest = 0;
				for (BookingOrderVO bkodvo: list){
					int i = bkdetailSvc.getAllByBkNo(bkodvo.getBk_no()).stream()
							.mapToInt(e -> e.getRm_guest())
							.sum();
					totalGuest += i;
				}
			%>
			<div>
				<h4><i class="fas fa-users"></i>當前度假村人數</h4>
				<h3 style="color:#f8dc81"><%=totalGuest%></h3>
			</div>
		</div>
		<div class="main">
			<div class="list">
				<table>
					<tr>
						<td colspan="7" class="list-title">今日待入住</td>
					</tr>
					<tr class="table-head">
						<th>訂單編號<input type=text id="search"></th>
						<th>入住會員</th>
						<th>預約入住日</th>
						<th>預計退房日</th>
						<th>接送狀況</th>
						<th>辦理入住</th>
					</tr>
					<c:if test="${checkIns.size()==0}">
						<tr>
							<td colspan="7" class="td-msg">今日無待入住客戶</td>
						</tr>
					</c:if>
					
					<c:forEach var="checkIn" items="${checkIns}">
						<tr class="list-data checkIn-list">
							<td><i class="fas fa-caret-right"></i><span>${checkIn.bk_no}</span></td>
							<td>
								<a class="booking-detail member"
								href="<%=request.getContextPath()%>/MembersServlet?mb_id=${checkIn.mb_id}&action=getone_bymbid&location=memberDetail.jsp">${checkIn.mb_id}</a><br>
								<i class="far fa-user member-icon"></i>${mbSvc.getOneByMbId(checkIn.mb_id).mb_name}
							</td>
							<td>${checkIn.dateIn}</td>
							<td>${checkIn.dateOut}</td>
							<td>
							<c:choose>
								<c:when test="${pkupSvc.getOneByBkNo(checkIn.bk_no) == null}">
									無預約
								</c:when>
								<c:when test="${pkupSvc.getOneByBkNo(checkIn.bk_no).pkup_status == 0}">
									未抵達
								</c:when>
								<c:otherwise>
									已抵達
								</c:otherwise>
							</c:choose>
							</td>
							<td><button class="check-in"  <c:if test="${checkIn.bk_status != 1}">disabled</c:if> >CHECK IN</button></td>
						</tr>
						<c:if test="${checkIn.bk_status == 1}">
						<tr>
							<td class="room-check-in" colspan="7">
							<% int i = 1; %>
							<c:forEach var="room" items="${bkdetailSvc.getAllByBkNo(checkIn.bk_no)}">
								<div class="room-info">
									<h4>房間 <%= i++ %><span class="rmtype" data-rmtype="${room.rm_type}">${rmtypeSvc.getOne(room.rm_type).type_name}</span><span>入住人數：${room.rm_guest} 人</span></h4>
								</div>
								<div class="checkin-option">
									<h4>選擇房號</h4>
									<c:forEach var="rm" items="${rmSvc.getAllByRmType(room.rm_type)}">
										<span class="all-rooms <c:if test='${rm.rm_status == 0}'>empty</c:if>">${rm.rm_no}</span>
									</c:forEach>
								</div>
							</c:forEach>
							<h5 class="price-to-pay">未結餘款：USD\$${checkIn.total_price * 0.7}-</h5>
							<button class="checkin-confirm" data-mbid="${checkIn.mb_id}" data-bkno="${checkIn.bk_no}">CONFIRM</button>
							</td>
						<tr>
						</c:if>
					</c:forEach>
					<tr>
						<td colspan="7"></td>
					</tr>
					<tr>
						<td colspan="7" class="list-title">今日待退房</td>
					</tr>
					<tr class="table-head">
						<th>訂單編號</th>
						<th>會員編號</th>
						<th>入住時間</th>
						<th>退房日期</th>
						<th>消費明細</th>
						<th>辦理退房</th>
					</tr>
					<c:if test="${checkOuts.size()==0}">
						<tr>
							<td colspan="7" class="td-msg">今日無待退房客戶</td>
						</tr>
					</c:if>
					<c:forEach var="checkOut" items="${checkOuts}">
						<tr class="list-data">
							<td><i class="fas fa-caret-right"></i>${checkOut.bk_no}</td>
							<td>
								<i class="far fa-user member-icon"></i>
								<a class="booking-detail member"
								href="<%=request.getContextPath()%>/MembersServlet?mb_id=${checkOut.mb_id}&action=getone_bymbid&location=memberDetail.jsp">${checkOut.mb_id}</a><br>
								${mbSvc.getOneByMbId(checkOut.mb_id).mb_name}
							</td>
							<fmt:parseDate pattern="yyyy-MM-dd'T'HH:mm" type="both" value="${checkOut.checkIn}" var="parsedDateTime"/> 
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${parsedDateTime}"/></td>
							<td>${checkOut.dateOut}</td>
							<td><button class="checkout-invoice" data-mbid="${checkOut.mb_id}" data-bkno="${checkOut.bk_no}">INVOICE</button></td>
							<td><button class="checkout-confirm" data-mbid="${checkOut.mb_id}" data-bkno="${checkOut.bk_no}">CHECK OUT</button></td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="7"></td>
					</tr>
					<tr>
						<td colspan="7" class="list-title">入住中清單</td>
					</tr>
					<tr class="table-head">
						<th>訂單編號</th>
						<th>會員編號</th>
						<th>入住時間</th>
						<th>退房日期</th>
						<th>入住房號</th>
						<th>提前退房</th>
					</tr>
					<c:if test="${checkeds.size()==0}">
						<tr>
							<td colspan="7" class="td-msg">無入住中房客</td>
						</tr>
					</c:if>
					<c:forEach var="checked" items="${checkeds}">
						<tr class="list-data">
							<td><i class="fas fa-caret-right"></i>${checked.bk_no}</td>
							<td>
								<a class="booking-detail member"
								href="<%=request.getContextPath()%>/MembersServlet?mb_id=${checked.mb_id}&action=getone_bymbid&location=memberDetail.jsp">${checked.mb_id}</a><br>
								<i class="far fa-user member-icon"></i>${mbSvc.getOneByMbId(checked.mb_id).mb_name}
							</td>
							<fmt:parseDate pattern="yyyy-MM-dd'T'HH:mm" type="both" value="${checked.checkIn}" var="parsedDateTime"/> 
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${parsedDateTime}"/></td>
							<td>${checked.dateOut}</td>
							<td>
								<c:forEach var="room" items="${rmSvc.getAllByBkNo(checked.bk_no)}">
									<span class="all-rooms">${room.rm_no}</span>
								</c:forEach>
							</td>
							<td>
								<button class="checkout-invoice" data-mbid="${checked.mb_id}" data-bkno="${checked.bk_no}">INVOICE</button>
								<button class="checkout-confirm" data-mbid="${checked.mb_id}" data-bkno="${checked.bk_no}">CHECK OUT</button>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="7"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="info-display" id="booking-detail-info">
		<div class="close-icon">
			<i class="fas fa-times icon"></i>
		</div>
		<iframe id="myIframe" style="width:100%;" src=""></iframe>
	</div>
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
	<%@ include file="/backend/files/backend_footer.file"%> <!-- 加入常用 js -->
	<script src="${pageContext.request.contextPath}/js/back/backend.js"></script>
	<script>
	$(window).on("load", function () {
	    $(".loader").delay(400).fadeOut();
	    $("#preloder").delay(600).fadeOut("slow");
	});

	$(document).ready(function () {
		//訂單搜尋
		let allTr = $("tr.checkIn-list");
		$("#search").keyup(function () {
		    let bkno = $("#search").val().toUpperCase();
		    for (let i = 1; i < allTr.length; i++) {
		        if (allTr.eq(i).children().eq(0).find("span").text().indexOf(bkno) < 0) {
		            allTr.eq(i).hide();
		        } else {
		            allTr.eq(i).show();
		        }
		    }
		});
		
		//小時鐘
		let clock = $("#clock");
    	clock.text(new Date().toLocaleTimeString());
    	setInterval(function(){
    		clock.text(new Date().toLocaleTimeString());
    	}, 1000)
		//iframe自動根據內容調節高度
    	let iframe = document.getElementById("myIframe");
	    iframe.onload = function(){
	        iframe.style.height = iframe.contentWindow.document.body.scrollHeight + 'px';
	    }
    	//顯示帳單
	    let bookingDetail = $("#booking-detail-info");
	    $(".booking-detail").click(function (e) {
	        e.preventDefault();
	        let src = $(this).attr("href");
	        bookingDetail.addClass("display-show");
	        bookingDetail.children("iframe").attr("src", src);
	    });
	    $(".icon").click(function () {
	        $(this).parents(".display-show").removeClass("display-show");
	    });
	    //check in 展開
	    $(".check-in").click(function () {
	        let rooms = $(this).closest("tr").next().find(".room-check-in");
	        if (!rooms.hasClass("show")) {
	            rooms.addClass("show");
	        } else {
	            rooms.removeClass("show");
	        }
	    });
	   
	    $(".empty").click(function () {
	        $(this).siblings(".empty").removeClass("selected");
	        $(this).addClass("selected");
	    });
	    
	    $(".checkout-invoice").click(function(){
	    	let bkno = $(this).attr("data-bkno");
	    	url = "<%=request.getContextPath()%>/receipt.jsp?bk_no=" + bkno;
	    	window.open(url, '_blank');
	    })
	  	//送出check in
	    $(".checkin-confirm").click(function () {
	        let selects = $(this).siblings(".checkin-option");
	        let mbid = $(this).attr("data-mbid");
	        let bkno = $(this).attr("data-bkno");
	        let roomArr = [];
	        for (let i = 0; i < selects.length; i++) {
	            let rm_no = selects.eq(i).children(".selected").text();
	            if (rm_no == ""){
	            	Swal.fire({
	                    position: "center",
	                    title: "房號未選取",
	                    icon: "error",
	                    text: "請選取房號",
	                });
	                return;
	            }
	            if (roomArr.indexOf(rm_no) < 0) {
	                roomArr.push(rm_no);
	            } else {
	                Swal.fire({
	                    position: "center",
	                    title: "房號重複",
	                    icon: "error",
	                    text: "請重新選擇房號",
	                });
	                return;
	            }
	        }
	        $.ajax({
	            //更新訂單狀態
	            url: "<%=request.getContextPath()%>/bookingServlet?action=checkin",
	            data: {
	                bk_no: bkno,
	                mb_id: mbid,
	            },
	            type: "POST",
	        });
	        for (i in roomArr) {
	            //將選好的房號放入房間
	            $.ajax({
	                url: "<%=request.getContextPath()%>/RoomsServlet?action=update_check_in",
	                data: {
	                    rm_no: roomArr[i],
	                    mb_id: mbid,
	                    bk_no: bkno,
	                },
	                type: "POST",
	                success: function (msg) {
	                    if (msg == "success") {
	                        Swal.fire({
	                            position: "center",
	                            title: "辦理入住成功",
	                            icon: "success",
	                            showConfirmButton: false,
	                        });
	                        setTimeout(function () {
	                            window.location.reload();
	                        }, 1000);
	                    } else {
	                        Swal.fire({
	                            position: "center",
	                            title: "系統爆炸了",
	                            icon: "error",
	                        });
	                    }
	                },
	            });
	        }
	    });
	   	//送出退房確認
	    $(".checkout-confirm").click(function () {
	        let mbid = $(this).attr("data-mbid");
	        let bkno = $(this).attr("data-bkno");
	        $.ajax({
	            //更新訂單狀態
	            url: "<%=request.getContextPath()%>/bookingServlet?action=checkout",
	            data: {
	                bk_no: bkno,
	            },
	            type: "POST",
	        });
	        $.ajax({
	            //將房號資訊清空
	            url: "<%=request.getContextPath()%>/RoomsServlet?action=update_check_out",
	            data: {
	                mb_id: mbid,
	                bk_no: bkno,
	            },
	            type: "POST",
	            success: function (msg) {
	                if (msg == "success") {
	                    Swal.fire({
	                        position: "center",
	                        title: "退房完成",
	                        icon: "success",
	                        showConfirmButton: false,
	                    });
	                    setTimeout(function () {
	                        window.location.reload();
	                    }, 1000);
	                } else {
	                    Swal.fire({
	                        position: "center",
	                        title: "系統爆炸了",
	                        icon: "error",
	                    });
	                }
	            },
	        });
	    });
	});

	</script>
</body>
</html>
