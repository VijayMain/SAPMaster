package com.vendorform.control;

import java.io.IOException;

import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vendorform.dao.User_login_dao;
 
 
@WebServlet("/LoginControl")
public class LoginControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String name = request.getParameter("uname");
			String pass = request.getParameter("pass");
			/*String access = request.getParameter("access"); */
			HttpSession session = request.getSession();
			
			User_login_dao dao = new User_login_dao();
			dao.login_user(session,name,pass,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
