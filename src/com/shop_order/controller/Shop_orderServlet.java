package com.shop_order.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.item.model.ItemService;
import com.item.model.ItemVO;
import com.members.model.MembersService;
import com.members.model.MembersVO;
import com.shop_order.model.Shop_orderService;
import com.shop_order.model.Shop_orderVO;
import com.shop_order_detail.model.Shop_order_detailVO;
import com.shoppingCart.model.CartService;

import mail.MailAuthenticate;
import mail.MailService;


public class Shop_orderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		JSONObject output = new JSONObject();

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("sp_odno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String sp_odno = null;
				try {
					sp_odno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("訂單編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				Shop_orderService shop_orderSvc = new Shop_orderService();
				Shop_orderVO shop_orderVO = shop_orderSvc.getOneShop_order(sp_odno);
				if (shop_orderVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("shop_orderVO", shop_orderVO); // 資料庫取出的empVO物件,存入req
				String url = "/backend/shop_order/listOneShop_order.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String sp_odno = new String(req.getParameter("sp_odno"));
				System.out.println(sp_odno);

				/*************************** 2.開始查詢資料 ****************************************/
				Shop_orderService shop_orderSvc = new Shop_orderService();
				Shop_orderVO shop_orderVO = shop_orderSvc.getOneShop_order(sp_odno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("shop_orderVO", shop_orderVO); // 資料庫取出的empVO物件,存入req
				String url = "/backend/shop_order/update_shop_order_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/listAllShop_order.jsp");
				failureView.forward(req, res);
			}
		}
		
		if(action.equals("cancelOrder")) {
			System.out.println("cancelOrder開始");
			String sp_odno = req.getParameter("sp_odno");
			String sp_status = "4";
			Shop_orderService shop_orderSvc = new Shop_orderService();
			Shop_orderVO shop_orderVO = shop_orderSvc.getOneShop_order(sp_odno);
			shop_orderVO.setSp_status(sp_status);
			
			shop_orderVO = shop_orderSvc.updateStatus(sp_status, sp_odno);
			
			try {
				output.put("status", "4");
			} catch (JSONException e) {
				e.printStackTrace();
			}
			req.setAttribute("shop_orderVO", shop_orderVO);
			
			res.setContentType("text/plain");
			PrintWriter out = res.getWriter();
			System.out.println(output);
			out.write(output.toString());
			out.flush();
			out.close();
		}
		
		if ("getSp_odnoByMb_id_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("mb_id");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String mb_id = null;
				try {
					mb_id = new String(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				Shop_orderService shop_orderSvc = new Shop_orderService();
				
				List<Shop_orderVO> list = shop_orderSvc.getSp_odnoByMb_id(mb_id);
				if (list == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("list", list); // 資料庫取出的empVO物件,存入req
				String url = "/backend/shop_order/listSp_odnoByMb_id.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/select_shop_order.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String sp_odno = req.getParameter("sp_odno").trim();
				
				String sp_status = null;
				try {
					sp_status = req.getParameter("sp_status").trim();
				} catch (NumberFormatException e) {
					sp_status = null;
					errorMsgs.add("請填商品狀態");
				}
				
				java.sql.Timestamp sp_dlvr = null;
				try {
					sp_dlvr = java.sql.Timestamp.valueOf(req.getParameter("sp_dlvr").trim());
				} catch(IllegalArgumentException e) {
				errorMsgs.add("請選擇出貨時間");	
				}
				
				Shop_orderVO shop_orderVO = new Shop_orderVO();
				shop_orderVO.setSp_odno(sp_odno);
				shop_orderVO.setSp_status(sp_status);
				shop_orderVO.setSp_dlvr(sp_dlvr);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("shop_orderVO", shop_orderVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/update_shop_order_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				Shop_orderService shop_orderSvc = new Shop_orderService();
				shop_orderVO = shop_orderSvc.updateShop_order(sp_status, sp_dlvr, sp_odno);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("shop_orderVO", shop_orderVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/backend/shop_order/listAllShop_order.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/update_shop_order_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String mb_id = req.getParameter("mb_id");
				if (mb_id == null || mb_id.trim().length() == 0) {
					errorMsgs.add("會員編號: 請勿空白");
				} 

				String sp_status = null;
				try {
					sp_status = req.getParameter("sp_status").trim();
				} catch (NumberFormatException e) {
					sp_status = null;
					errorMsgs.add("請輸入訂單狀態");
				}

				Double total_price = null;
				try {
					total_price = new Double(req.getParameter("total_price").trim());
				} catch (NumberFormatException e) {
					total_price = 1000.0;
					errorMsgs.add("請填訂單總價格");
				}

				String rm_no = req.getParameter("rm_no").trim();
				String rm_noReg = "^[(0-9)] {3,3}$";
				if(!rm_no.trim().matches(rm_noReg)) {
					errorMsgs.add("客房編號:請檢察是否正確");
				}
				
				Integer points_total = null;
				try {
					points_total = new Integer(req.getParameter("points_total").trim());
				} catch (NumberFormatException e) {
					points_total = 0;
					errorMsgs.add("積分請填數字");
				}
				
				Shop_orderVO shop_orderVO = new Shop_orderVO();
				shop_orderVO.setMb_id(mb_id);
				shop_orderVO.setSp_status(sp_status);
				shop_orderVO.setTotal_price(total_price);
				shop_orderVO.setPoints_total(points_total);
				shop_orderVO.setRm_no(rm_no);
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("shop_orderVO", shop_orderVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/addShop_order.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				Shop_orderService shop_orderSvc = new Shop_orderService();
				shop_orderVO = shop_orderSvc.addShop_order(mb_id, sp_status, total_price, points_total, rm_no);


				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/backend/shop_order/listAllShop_order.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/backend/shop_order/addShop_order.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insertWithOrder_details".equals(action)) {
			 List<String> errorMsgs = new LinkedList<String>();
			 req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				@SuppressWarnings("unchecked")
				List<ItemVO> buylist = (List<ItemVO>) session.getAttribute("buylist");
				System.out.println(buylist.size());
				
				String mb_id = req.getParameter("mb_id");
				Double total_price = new Double(req.getParameter("total_price"));
				Integer points_total = new Integer(req.getParameter("points_total"));
				MembersVO mem = new MembersVO();
				
				System.out.println("總金額" + total_price);
				System.out.println("總積分" + points_total);
								
				List<Shop_order_detailVO> list = new ArrayList<Shop_order_detailVO>(); // 準備置入訂單明細
				
				for (ItemVO order : buylist) {
					 Shop_order_detailVO order_detail = new Shop_order_detailVO();
					 String item_no = order.getItem_no();
					 Double od_pr = order.getItem_price();
					 Integer od_qty = order.getQuantity();
					 Integer od_points = order.getPoints();
					 
					 order_detail.setItem_no(item_no);
					 order_detail.setQty(od_qty);
					 order_detail.setItem_price((double)Math.round(od_pr*od_qty));
					 order_detail.setPoints((int)Math.round(od_points*od_qty));
					 list.add(order_detail);
					}
				
//				for(int i = 0; i < buylist.size(); i++) {
//					Shop_order_detailVO order_detail = new Shop_order_detailVO();   // 訂單明細
//					ItemVO order = buylist.get(i);
//					String item_no = order.getItem_no();
//					Double od_pr = order.getItem_price();
//					Integer od_qty = order.getQuantity();
//					Integer od_points = order.getPoints();
//					System.out.println("商品名稱=" + item_no + " ,金額=" + od_pr + " ,數量=" + od_qty + " ,積分=" + od_points);
//					order_detail.setItem_no(item_no);
//					order_detail.setQty(od_qty);
//					order_detail.setItem_price((double)Math.round(od_pr*od_qty));
//					order_detail.setPoints((int)Math.round(od_points*od_qty));
//					list.add(order_detail);
//				}
				
				Shop_orderVO shop_orderVO = new Shop_orderVO();
				shop_orderVO.setMb_id(mb_id);
				shop_orderVO.setTotal_price(total_price);
				shop_orderVO.setPoints_total(points_total);
//				shop_orderVO.setRm_no("");
				
				/***************************2.開始新增訂單***************************************/
				Shop_orderService shop_orderSvc = new Shop_orderService();
				shop_orderSvc.addShop_orderWithShop_order_detail(shop_orderVO, list);
				
				/**更改新增會員積分**/			
				MembersService membersSvc=new MembersService();
				Integer pointCos = new Integer(req.getParameter("pointCos"));
				System.out.println("pointCos= "+pointCos);
				MembersVO members = membersSvc.getOneByMbId(mb_id);				
				System.out.println("memPo= " + members.getMb_point());
				membersSvc.updateMemPoint(mb_id, points_total + members.getMb_point() - pointCos);
				
				/**寄訂單至會員e-mail**/	
				MembersService membersService = new MembersService();
				String mb_email = membersService.getOneByMbId(mb_id).getMb_email();
				MailService mail = new MailService();
				MailAuthenticate auth = new MailAuthenticate();
				String mailMsg = "你已下訂戴蒙商城商品，請點及下列連結查看詳細或修改。http://localhost:8081/CEA101G1/MembersServlet?action=verify&authcode="
						+ auth.insertCode(mb_id) + "&mb_id=" + mb_id;
				mail.sendMail(mb_email, "戴蒙商城訂單", mailMsg);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/								
				String url = "/frontend/members/memberHistory.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				CartService cartSVC = new CartService();
				buylist.stream().forEach(order -> {
					 String item_no = order.getItem_no();
					 Integer quantity = order.getQuantity();
					 cartSVC.deleteCart(mb_id, item_no, quantity);
					});
								
//				for(int i = 0; i < buylist.size(); i++) {
//					ItemVO order = buylist.get(i);
//					String item_no = order.getItem_no();
//					Integer quantity = order.getQuantity();
//					cartSVC.deleteCart(mb_id, item_no, quantity);
//				}
				
				session.removeAttribute("buylist");
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("增加訂單資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/frontend/shop/shopCheckOut.jsp");
				failureView.forward(req, res);
			}
		 }
	}

}
