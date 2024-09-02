package com.shoppingCart.controller;

import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import org.json.JSONObject;

import com.shoppingCart.model.CartService;
import com.item.model.*;
import com.members.model.MembersVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 500 * 1024 * 1024, maxRequestSize = 500 * 5 * 1024
		* 1024)
public class ShoppingCartRedisServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		CartService cartSVC = new CartService();
		ItemService itemSVC = new ItemService();
		JSONObject output = new JSONObject();	
		HttpSession session = req.getSession();
		String action = req.getParameter("action");
		MembersVO member = (MembersVO) session.getAttribute("member");
		String mb_id = null;
		String sessionID = null;
		if(member!=null) {	
		mb_id = member.getMb_id();
		System.out.println("會員編號"+mb_id);
		}else {
		sessionID = (String) session.getAttribute("sessionID");		
		System.out.println("sessionID = "+sessionID);
		}
		if (!action.equals("CHECKOUT")) {

			// 針對非會員
			if (mb_id == null) {
				List<ItemVO> buylist = (List<ItemVO>) cartSVC.getAllItem_noBysessionID(sessionID);
				// 刪除購物車中被選的商品
				if (action.equals("deleteSelected") && req.getParameterValues("checkact") != null) {

					System.out.println("deleteSelected開始");

					String[] delArray = req.getParameterValues("checkact");
					String[] item_noArray = req.getParameterValues("item_no");
					String[] quantityArray = req.getParameterValues("quantity");
			

					for (int i = 0; i < delArray.length; i++) {

						int d = Integer.parseInt(delArray[i]);
						String item_no = item_noArray[d];
						int quantity = Integer.parseInt(quantityArray[d]);
						cartSVC.deleteCartCo(sessionID, item_no, quantity);

					}
				}
				// 刪除單個商品
				else if (action.equals("DELETE")) {
					System.out.println("非會員delete");
					String del = req.getParameter("del");
					int d = Integer.parseInt(del);
					String item_no = req.getParameter("item_no");
					Integer quantity = new Integer(req.getParameter("quantity"));
					cartSVC.deleteCartCo(sessionID, item_no, quantity);
					req.setAttribute("buylist", (List<ItemVO>) cartSVC.getAllItem_noBysessionID(sessionID));
					String url = "/frontend/shop/shopCartRedis.jsp";
					RequestDispatcher rd = req.getRequestDispatcher(url);
					rd.forward(req, res);
					return;
				}

				// 新增商品至購物車中
				else if (action.equals("ADD")) {
					System.out.println("非會員ADD");
					ItemVO aitem = getItemVO(req);
					// 取得後來新增的商品
					if (buylist == null) {
						System.out.println("新增購物車");
						String item_no = aitem.getItem_no();
						Integer quantity = new Integer(aitem.getQuantity());
						cartSVC.insertCartCo(sessionID, item_no, quantity);

					} else {

						if (buylist.contains(aitem)) {
							System.out.println("增加數量");
							String item_no = aitem.getItem_no();
							Integer quantity = new Integer(aitem.getQuantity());
							cartSVC.updateCartCo(sessionID, item_no, quantity);

						} else {
							System.out.println("新增商品");
							String item_no = aitem.getItem_no();
							Integer quantity = new Integer(aitem.getQuantity());
							cartSVC.insertCartCo(sessionID, item_no, quantity);
						}
					}
				}

				req.setAttribute("buylist", (List<ItemVO>) cartSVC.getAllItem_noBysessionID(sessionID));
//				String url = "/frontend/shop/shopItemDetail.jsp";
//				RequestDispatcher rd = req.getRequestDispatcher(url);
//				rd.forward(req, res);
				
							
				// 會員
			} else {

				List<ItemVO> RedisBuylist = (List<ItemVO>) cartSVC.getAllItem_noByMb_id(mb_id);
				// 刪除購物車中被選的商品
				if (action.equals("deleteSelected") && req.getParameterValues("checkact") != null) {

					System.out.println("deleteSelected開始");

					String[] delArray = req.getParameterValues("checkact");
					String[] item_noArray = req.getParameterValues("item_no");
					String[] quantityArray = req.getParameterValues("quantity");
			

					for (int i = 0; i < delArray.length; i++) {

						int d = Integer.parseInt(delArray[i]);
						String item_no = item_noArray[d];
						int quantity = Integer.parseInt(quantityArray[d]);
						cartSVC.deleteCart(mb_id, item_no, quantity);

					}
				}
				// 刪除單個商品
				else if (action.equals("DELETE")) {
					System.out.println("會員delete");
					String del = req.getParameter("del");
					int d = Integer.parseInt(del);
					String item_no = req.getParameter("item_no");
					Integer quantity = new Integer(req.getParameter("quantity"));
					cartSVC.deleteCart(mb_id, item_no, quantity);
					req.setAttribute("buylist", (List<ItemVO>) cartSVC.getAllItem_noBysessionID(sessionID));
					String url = "/frontend/shop/shopCartRedis.jsp";
					RequestDispatcher rd = req.getRequestDispatcher(url);
					rd.forward(req, res);
					return;
				}

				// 新增商品至購物車中
				else if (action.equals("ADD")) {
					System.out.println("會員ADD");
					ItemVO aitem = getItemVO(req);
					// 取得後來新增的商品
					if (RedisBuylist == null) {
						System.out.println("新增購物車");
						String item_no = aitem.getItem_no();
						Integer quantity = new Integer(aitem.getQuantity());
						cartSVC.insertCart(mb_id, item_no, quantity);

					} else {

						if (RedisBuylist.contains(aitem)) {
							System.out.println("增加數量");
							String item_no = aitem.getItem_no();
							Integer quantity = new Integer(aitem.getQuantity());
							cartSVC.updateCart(mb_id, item_no, quantity);

						} else {
							System.out.println("新增商品");
							String item_no = aitem.getItem_no();
							Integer quantity = new Integer(aitem.getQuantity());
							cartSVC.insertCart(mb_id, item_no, quantity);
						}
					}
				}

				req.setAttribute("buylist", (List<ItemVO>) cartSVC.getAllItem_noByMb_id(mb_id));
//				String url = "/frontend/shop/shopItemDetail.jsp";
//				RequestDispatcher rd = req.getRequestDispatcher(url);
//				rd.forward(req, res);
			}
		}
		// 結帳，計算購物車商品價錢總數
		else if (action.equals("CHECKOUT")) {
			System.out.println("CHECKOUT開始");
			// 非會員
			if (member == null) {

				// 會員
			} else if (req.getParameterValues("checkact") != null) {
				System.out.println("會員進結帳");

				List<ItemVO> buylist = new ArrayList<ItemVO>();

				String[] delArray = req.getParameterValues("checkact");
				String[] item_noArray = req.getParameterValues("item_no");
				String[] item_priceArray = req.getParameterValues("item_price");
				String[] pointArray = req.getParameterValues("points");
		
				double totalPrice = 0;
				Integer totalPoints = 0;
				
				for (int i = 0; i < delArray.length; i++) {
					ItemVO aitem = new ItemVO();
					int d = Integer.parseInt(delArray[i]);
					String item_no = item_noArray[d];
					aitem.setItem_no(item_no);
					Integer quantity = cartSVC.getValueByItem_no(mb_id, item_no);
					aitem.setQuantity(quantity);
					Double item_price = Double.parseDouble(item_priceArray[d]);
					aitem.setItem_price(item_price);
					Integer points = Integer.parseInt(pointArray[d]);
					aitem.setPoints(points);
					buylist.add(aitem);

//					Double item_price = itemSVC.getOneItem(order.getItem_no()).getItem_price();
//					Integer quantity = cartSVC.getValueByItem_no(mb_id, order.getItem_no());
					totalPrice += (Math.round(item_price * quantity));
					totalPoints += (Math.round(points * quantity));
				}

				for (ItemVO itemVO : buylist) {
					System.out.println(" Item_no:" + itemVO.getItem_no());
					System.out.println(" Item_name:" + itemVO.getItem_name());
					System.out.println(" Item_price:" + itemVO.getItem_price());
					System.out.println(" Points:" + itemVO.getPoints());
					System.out.println(" Quantity:" + itemVO.getQuantity());
				}
				System.out.println(totalPrice);
				System.out.println(totalPoints);
				
				Double amount = (double) totalPrice;
				Integer poamount = (int) totalPoints;
				req.setAttribute("amount", amount);
				req.setAttribute("poamount", poamount);
				session.setAttribute("buylist", buylist);
				
				String url = "/frontend/shop/shopCheckOut.jsp";
				RequestDispatcher rd = req.getRequestDispatcher(url);
				rd.forward(req, res);

			} else {
				System.out.println("沒勾選,回Cart");
				req.setAttribute("buylist", (List<ItemVO>) cartSVC.getAllItem_noByMb_id(mb_id));
				String url = "/frontend/shop/shopCartRedis.jsp";
				RequestDispatcher rd = req.getRequestDispatcher(url);
				rd.forward(req, res);

			}
		}
	}

	private ItemVO getItemVO(HttpServletRequest req) {
		String item_no = req.getParameter("item_no");
		String item_name = req.getParameter("item_name");
		Integer quantity = new Integer(req.getParameter("quantity"));
		Double item_price = new Double(req.getParameter("item_price"));
		Integer points = new Integer(req.getParameter("points"));

		ItemVO item = new ItemVO();
		item.setItem_name(item_name);
		item.setItem_no(item_no);
		item.setItem_price(item_price);
		item.setQuantity(quantity);
		item.setPoints(points);

		return item;
	}
}
