package com.services_cart.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddCartServlet")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddCartServlet() {
        super();
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
			String text = req.getParameter("text");
			if (!text.equals("") && text != null) {
				int num = Integer.parseInt(text);
				int sum = num + 1;
				res.getWriter().write(String.valueOf(sum));
				return;
			}
		
	}

}
