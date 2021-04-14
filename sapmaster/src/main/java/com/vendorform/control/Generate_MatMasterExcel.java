package com.vendorform.control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vendorform.dao.NewMasterGenerate_DAO;
import com.vendorform.vo.NewMasterGenerate_VO;
   
 
@WebServlet("/Generate_MatMasterExcel")
public class Generate_MatMasterExcel extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 try {
		NewMasterGenerate_VO vo = new NewMasterGenerate_VO();
		NewMasterGenerate_DAO dao = new NewMasterGenerate_DAO();
		ArrayList idList = new ArrayList(); 
		
		if(request.getParameterValues("cheked_id")!=null){
		
		String[] names = request.getParameterValues("cheked_id");
		
		for(int i=0; i< names.length; i++){
			idList.add(names[i]);
		}
 
		javax.servlet.ServletContext context = getServletContext(); 		 
		dao.generateExcel(vo,response,idList,context);  
		
		}else{
			response.sendRedirect("Home_MST.jsp");
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	}
}