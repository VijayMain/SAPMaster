<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX</title>
</head>
<body>
<%
try{
 	String str = request.getParameter("q");
%>
<div  id="already_avail" style="height : 650px;overflow : scroll;">
					<table class="tftable">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold; text-align: center;"> 
								<td>Already Available Name of Org.</td> 
							</tr> 
	<%
	if(str!=""){
		String location="";
		Connection con =  Connection_Utility.getConnectionMaster();
		PreparedStatement ps_search = con.prepareStatement("select * from sap_masterVendCust where name_org like '%" + str + "%'");
		ResultSet rs_search = ps_search.executeQuery();
		while(rs_search.next()){
	%>
						<tr style="font-size: 9px;"> 
								<td style="background-color: #b23030;color: white;"><%=rs_search.getString("name_org") %></td>
						</tr>
	<%		
		}
	%>
		</table>	
	<%	
		con.close();
		}else{			
	%>		
			<!-- <table class="tftable">
					<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold; text-align: center;">
						<td>Material No</td>
						<td>Material Descr.</td>
						<td>Plant</td>
						<td>Division</td>
					</tr>
				</table>	 -->
	<%			
		}
}catch(Exception e){
	e.printStackTrace();
}
%>
</div>
</body>
</html>