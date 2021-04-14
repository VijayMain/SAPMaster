package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class User_login_dao {

	public void login_user(HttpSession session, String name, String pass,
			HttpServletResponse response) {
		try {
			// Connection con =  Connection_Utility.getConnectionMaster();
			Connection con =  Connection_Utility.getLocalUserConnection();
			boolean flag = false;
			/*PreparedStatement ps = con.prepareStatement("select * from USER_LOGIN where user_name='"+ name +"' and login_password='"+pass+"' and enable=1");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
					flag=true;
					session.setAttribute("uid", rs.getInt("Id"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("username", rs.getString("name"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("dept_id", rs.getString("department"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("email_id", rs.getString("email_id"));
					session.setMaxInactiveInterval(-1);					
					response.sendRedirect("Home.jsp"); 
			}*/
			
			PreparedStatement ps=null, ps1 =null;
			ResultSet rs =null, rs1 =null;
			String dept_name = "";
			
			ps = con.prepareStatement("select * from user_tbl where Login_Name='"+ name +"' and Login_Password='"+pass+"' and enable_id=1");
			rs  = ps.executeQuery();
			while(rs.next()){
				ps1 = con.prepareStatement("SELECT * FROM complaintzilla.user_tbl_dept where dept_id="+rs.getInt("Dept_Id"));
				rs1 = ps1.executeQuery();
				while (rs1.next()) {
					dept_name = rs1.getString("Department");
				}
					flag=true;
					session.setAttribute("uid", rs.getInt("U_Id"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("username", rs.getString("U_Name"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("dept_id", dept_name);
					session.setMaxInactiveInterval(-1);
					session.setAttribute("email_id", rs.getString("U_email"));
					session.setMaxInactiveInterval(-1);
					response.sendRedirect("Home.jsp");
			}
			
			if(flag==false){
				String error = "Invalid login details, Please try again....";
				response.sendRedirect("Login.jsp?error="+error);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}