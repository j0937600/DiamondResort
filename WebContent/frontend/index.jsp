<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>	
        <%@ include file="/frontend/files/commonCSS.file" %> <!-- 基本CSS檔案 -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/slick.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slick-theme.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slicknav.min.css" type="text/css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/front/index.css" type="text/css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/front/chatbox.css" type="text/css" />
<title>Diamond Resort</title>

</head>
<style>
	.nice-select.open .list {
	    transform: scale(1) translateY(-101%)
	}
	.nice-select .list {
		top:0;
		transform: translateY(-50%);
	}
</style>
<%@ include file="/frontend/files/loginCSS.file" %> <!-- 登入必要檔案 -->
<body <c:if test="${member != null }">onunload="disconnect();"</c:if> >
<%@ include file="/frontend/files/login.file" %>   <!-- 登入必要檔案 -->
<%@ include file="/frontend/files/loginbox.file" %>  <!-- 登入必要檔案 -->
<%@ include file="/frontend/files/header.file" %> <!-- 上方導覽 -->
<c:if test="${member != null}">
<!-- chatbox -->
<div id="chat-circle" class="btn btn-raised">
        <div id="chat-overlay"></div>
        <i class="fas fa-sms"></i>
</div>
<div class="chat-box">
    <div class="chat-box-header">
      <i class="far fa-gem" style="margin-right:5px"></i>Online Contact
      <span class="chat-box-toggle"><i class="fas fa-minus"></i></span>
    </div>
    <div class="chat-box-body">
      <div class="chat-box-overlay">   
      </div>
      <div class="chat-logs">
       
      </div><!--chat-log -->
    </div>
    <div class="chat-input">      
      <input type="text" id="chat-input" placeholder="Send a message..." onkeydown="if (event.keyCode == 13) sendMessage();"/>
      <button class="chat-submit" id="chat-submit"><i class="fas fa-paper-plane"></i></button>
    </div>
  </div>
<!-- chatbox -->
</c:if>
	<section class="hero-section">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="hero-text">
						<h1 style="font-size: 60px; text-shadow: 1px 1px black">
							<b style="color: rgb(255, 217, 0)">Deluxe</b>Relax
						</h1>
						<p>The best island resort in the world, with a full range of considerate services, and enjoy the emperor's treatment!</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<div class="homepage-video">
		<video width="condition" type="video/mp4" autoplay="autoplay"
			loop="loop" muted="muted">
			<source src="${pageContext.request.contextPath}/video/homepage.mp4"
				type="video/mp4" />
		</video>
	</div>
	<!-- Hero Section End -->
	<div class="booking">
		<form action="<%=request.getContextPath()%>/frontend/roomrsv/available.jsp" method="POST">
			<div class="booking-form">
				<div class="box">
					<div class="check-date">
						<input type="text" class="date-input" id="date-in" name="date-in"
							autocomplete="off" placeholder="Date" required/> <label for="date-in"><i
							class="icon_calendar"></i></label>
					</div>
				</div>
				<div class="box">
					<div class="select-option">
						<select id="stay" name="stay" required>
							<option disabled selected>Number of Nights</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="6">7</option>
						</select>
					</div>
				</div>
				<div class="box">
					<div class="select-option">
						<select id="guest" name="guest" required>
							<option value="" disabled selected>Number of Guests</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
						</select>
					</div>
				</div>
				<div class="check-vacant-button box">
					<button type="submit" id="check-room" class="vacant-check">SEARCH</button>
				</div>
			</div>
		</form>
	</div>
	<!-- About Us Section Begin -->
	<section class="news-section">
		<div class="container news-container">
			<div>
				<div>
					<div class="about-text">
						<div class="section-title">
							<span>New Information</span>
						</div>
						<p class="s-para">
							All merchandise are on sale!!
						</p>
						<a href="about-us.html" class="primary-btn about-btn"><i class="far fa-hand-point-right"></i>查看更多最新消息</a>
					</div>
				</div>
				<div>
					<div class="about-text">
						<div class="section-title">
							<span>Recommended by famous celebrities</span>
						</div>
						<div class="testimonial-slider">
							<div class="ts-item">
								<p>It was exactly as described, walking distance to the parks. Room was perfect, amazing view and very quiet. Staff was excitement and accommodating.</p>
								<div class="ti-author">
								<i class="fab fa-tripadvisor"></i>
									<div class="rating">
										<i class="icon_star"></i> <i class="icon_star"></i> <i
											class="icon_star"></i> <i class="icon_star"></i> <i
											class="icon_star-half_alt"></i>
									</div>
									<h5>- David</h5>
								</div>
							</div>
							<div class="ts-item">
								<p>Everything was pretty much great! Pool was fabulous! Staff was very helpful and friendly. Rooms were stocked and clean. Spacious. As promised a beautiful fireworks. Great view of the park from our room!</p>
								<div class="ti-author">
								<i class="fab fa-tripadvisor"></i>
									<div class="rating">
										<i class="icon_star"></i> <i class="icon_star"></i> <i
											class="icon_star"></i> <i class="icon_star"></i> <i
											class="icon_star-half_alt"></i>
									</div>
									<h5>- Eason Lai</h5>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<section class="hp-room-section">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<span>Stunning Sea View Suite</span>
						<h2>Fabulously Beautiful Sea View close to Rooms </h2>
					</div>
				</div>
			</div>
			<div class="hp-room-items">
				<div class="row">
					<div class="col-lg-3 col-md-6">
						<div class="hp-room-item set-bg"
							data-setbg="${pageContext.request.contextPath}/img/room/standard/standard.jpeg">
							<div class="hr-text">
								<h3>Standard</h3>
								<h2>
									USD$500<span>person/night</span>
								</h2>
								<table>
									<tbody>
										<tr>
											<td class="r-o">Space:</td>
											<td>500 square feet</td>
										</tr>
										<tr>
											<td class="r-o">Num:</td>
											<td>2~4 person</td>
										</tr>
										<tr>
											<td class="r-o">Two bed:</td>
											<td>150 * 200cm</td>
										</tr>
									</tbody>
								</table>
								<a href="<%=request.getContextPath()%>/frontend/rooms/rooms.jsp" class="primary-btn">More..</a>
							</div>
						</div>	
					</div>
					<div class="col-lg-3 col-md-6">
						<div class="hp-room-item set-bg"
							data-setbg="${pageContext.request.contextPath}/img/room/honeymoon/honeymoon1.jpeg">
							<div class="hr-text">
								<h3>Honey Moon</h3>
								<h2>
									USD$600<span>person/night</span>
								</h2>
								<table>
									<tbody>
										<tr>
											<td class="r-o">Space:</td>
											<td>550 square feet</td>
										</tr>
										<tr>
											<td class="r-o">Num:</td>
											<td>2 person</td>
										</tr>
										<tr>
											<td class="r-o">One bed:</td>
											<td>200 * 200cm</td>
										</tr>
									</tbody>
								</table>
								<a href="<%=request.getContextPath()%>/frontend/rooms/rooms.jsp" class="primary-btn">More..</a>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6">
						<div class="hp-room-item set-bg"
							data-setbg="${pageContext.request.contextPath}/img/room/deluxe/deluxe.jpeg">
							<div class="hr-text">
								<h3>Deluxe</h3>
								<h2>
									USD$750<span>person/night</span>
								</h2>
								<table>
									<tbody>
										<tr>
											<td class="r-o">Space:</td>
											<td>600 square feet</td>
										</tr>
										<tr>
											<td class="r-o">Num:</td>
											<td>2~6 person</td>
										</tr>
										<tr>
											<td class="r-o">Three beds:</td>
											<td>250 * 250cm</td>
										</tr>
									</tbody>
								</table>
								<a href="<%=request.getContextPath()%>/frontend/rooms/rooms.jsp" class="primary-btn">More..</a>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6">
						<div class="hp-room-item set-bg"
							data-setbg="${pageContext.request.contextPath}/img/room/poseidon/poseidon1.jpeg">
							<div class="hr-text">
								<h3>Poseidon</h3>
								<h2>
									USD$900<span>person/night</span>
								</h2>
								<table>
									<tbody>
										<tr>
											<td class="r-o">Space：</td>
											<td>900 square feet</td>
										</tr>
										<tr>
											<td class="r-o">Num:</td>
											<td>2~4 person</td>
										</tr>
										<tr>
											<td class="r-o">One bed</td>
											<td>250 * 300cm</td>
										</tr>
									</tbody>
								</table>
								<a href="<%=request.getContextPath()%>/frontend/rooms/rooms.jsp" class="primary-btn">More..</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<section class="services-section spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<span>Customer Exclusively</span>
						<h2>Enjoy the honorable service</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-12">
					<div class="service-item">
						<i class="flaticon-036-parking"></i>
						<h4>Air shuttle</h4>
						<p>The resort has an exclusive helicopter and special customs clearance, so you do not need to wait for a lengthy customs clearance service, directly from the airport to your reserved room.</p>
					</div>
				</div>
				<div class="col-lg-4 col-md-12">
					<div class="service-item">
						<i class="flaticon-044-clock-1"></i>
						<h4>24HR Room Service</h4>
						<p>There are professional service staff to serve you every minute, Thai MASSAGE, aroma essential oil SPA, let you completely relax.</p>
					</div>
				</div>
				<div class="col-lg-4 col-md-12">
					<div class="service-item">
						<i class="flaticon-012-cocktail"></i>
						<h4>Meal to Room</h4>
						<p>With a move of your finger, the meal will be at your door soon!</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Services Section End -->

	<!-- Footer Section Begin -->
	<footer class="footer-section">
		<div class="container">
			<div class="footer-text">
				<div class="row">
					<div class="col-lg-6 ft-info">
						<div class="ft-contact">
							<h6>Contact Us</h6>
							<ul>
								<li>(08) 0857 9487</li>
								<li>DiamondResort101@gmail.com</li>
								<li>Somewhere on the earth</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- Footer Section End -->

	<!-- Js Plugins -->
	<%@ include file="/frontend/files/commonJS.file" %> <!-- 基本JS檔案 -->
	<script src="${pageContext.request.contextPath}/js/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/front/index.js"></script>
	
	<script>
	<c:if test="${memVOber != null}">
		  var INDEX = 0; 
		  var memberImg = "<%=request.getContextPath()%>/MembersServlet?action=getMbPicForChat&mb_id=${member.mb_id}";
		  var empImg = "<%=request.getContextPath()%>/img/avatar/csAvatar.jpg";
		  $("#chat-submit").click(sendMessage);
		  
		  function sendMsg() {
		    var msg = $("#chat-input").val(); 
		    if(msg.trim() == ''){
		      return false;
		    }
		    generate_message(msg, 'member');
		  }
		  function generate_message(msg, type) {
		    INDEX++;
		    let img;
		    type === "member" ? img = memberImg : img = empImg
		    var str="";
		    str += "<div id='cm-msg-"+INDEX+"' class=\"chat-msg "+type+"\">";
		    str += "          <span class=\"msg-avatar\">";
		    str += "            <img src=\"" + img + "\">";
		    str += "          <\/span>";
		    str += "          <div class=\"cm-msg-text\">";
		    str += msg;
		    str += "          <\/div>";
		    str += "        <\/div>";
		    $(".chat-logs").append(str);
		    $("#cm-msg-"+INDEX).hide().fadeIn(300);
		    $("#chat-input").val(''); 
		    $(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight}, 1000);    
		  }  
		  
		  $("#chat-circle").click(function() {  
			if (webSocket == null){
				connect();
			}
		    $("#chat-circle").toggle(500);
		    $(".chat-box").toggle(500);	
		  })
		  
		  $(".chat-box-toggle").click(function() {
		    $("#chat-circle").toggle(500);
		    $(".chat-box").toggle(500);
		  })
		 //WebSocket
        var MyPoint = "/customerWS/${member.mb_id}";
		var host = window.location.host;
		var path = window.location.pathname;
		var webCtx = path.substring(0, path.indexOf('/', 1));
		var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
		var empID;
		var empName;
		var webSocket = null;
	
		function connect() {
			// create a websocket
			webSocket = new WebSocket(endPointURL);
	
			webSocket.onopen = function(event) {
				console.log("Connect Success!");
				document.getElementById('chat-input').disabled = false;
			}
	
			webSocket.onmessage = function(event) {
				var jsonObj = JSON.parse(event.data);
				if ("open" === jsonObj.type) {
					empID = jsonObj.empID;
					empImg = "<%=request.getContextPath()%>/emp/emp.do?action=getEmpPic&emp_id=" + empID;
					empName = jsonObj.empName;
					let msg = jsonObj.message;
					generate_message(msg, "emp")
				} else if ("history" === jsonObj.type) {
					let memberID;
					if (jsonObj.sender.indexOf("MEM") >= 0){
						memberID = jsonObj.sender;
					} else {
						memberID = jsonObj.receiver;
					}
					// 這行的jsonObj.message是從redis撈出與客戶的歷史訊息，再parse成JSON格式處理
					var messages = JSON.parse(jsonObj.message);
					for (var i = 0; i < messages.length; i++) {
						var historyData = JSON.parse(messages[i]);
						var msg = historyData.message;
						var time = historyData.time;
						// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
						let type = "";
						historyData.sender.indexOf("MEM") >= 0 ? type = 'member' : type = 'emp';
						generate_message(msg, type)
					}
				} else if ("chat" === jsonObj.type) {
					let msg = jsonObj.message;
					let type;
					jsonObj.sender.indexOf("MEM") >= 0 ? type = 'member' : type = 'emp';
					generate_message(msg, type)
				} else if ("empNotAvailable" === jsonObj.type){
					generate_message("Hi, can I help you?", "emp")
				}
			};
	
			webSocket.onclose = function(event) {
				console.log("Disconnected!");
			};
		}
		
		function sendMessage() {
			var inputMessage = document.getElementById("chat-input");
			var memberID = "${member.mb_id}";
			var memberName = "${member.mb_name}";
			var message = inputMessage.value.trim();
			let time = new Date();
			let timeStr = time.getFullYear() + "-" + (time.getMonth()+1).toString().padStart(2, "0") + "-" 
						+ time.getDate() + " " + time.getHours().toString().padStart(2, "0") + ":" + time.getMinutes().toString().padStart(2, "0");
			if (message === "") {
				inputMessage.focus();
				return;
			} else {
				var jsonObj = {
					"type" : "chat",
					"sender" : memberID + "-" + memberName,
					"receiver" : empID + "-" + empName,
					"message" : message,
					"time": timeStr,
				};
				webSocket.send(JSON.stringify(jsonObj));
				inputMessage.value = "";
				inputMessage.focus();
			}
		}
		
		function disconnect() {
			if (webSocket != null) webSocket.close();
		}
	</c:if>
	</script>
	
</body>
</html>
