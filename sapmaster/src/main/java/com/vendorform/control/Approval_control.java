package com.vendorform.control;

import java.io.IOException; 

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

import com.vendorform.dao.Approval_dao;
import com.vendorform.vo.FileUpload_vo;
import com.vendorform.vo.NewVendCustMaster_VO;

@WebServlet("/Approval_control")
public class Approval_control extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			
			HttpSession session = request.getSession();
			String hid="", approval="", company="", remark="";
			hid = request.getParameter("hid");
			approval =request.getParameter("approval_status");
			remark = request.getParameter("remark");
			
			NewVendCustMaster_VO vo = new NewVendCustMaster_VO();
			Approval_dao dao = new Approval_dao();
			
			vo.setHid(hid);
			vo.setApproval(approval);
			vo.setCompany(company);
			vo.setRemark(remark);
			
			String uid = session.getAttribute("uid").toString();			
			String uname = session.getAttribute("username").toString(), d_Id = session.getAttribute("dept_id").toString();						
			vo.setUid(uid);
			vo.setDept(d_Id);
			vo.setUname(uname);	
			 
			dao.approve_Vendor(session, vo, response);
						
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}