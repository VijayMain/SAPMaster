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
<title>Vendor</title>
</head>
<body>
<%
try{
 	String vendCode = request.getParameter("r");
 	Connection con = Connection_Utility.getConnectionMaster();
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	/* d_Id = Integer.parseInt(session.getAttribute("dept_id").toString()); */
	String uname = session.getAttribute("username").toString();
	PreparedStatement ps_mst = null, ps_mst1 = null;
	ResultSet rs_mst = null, rs_mst1 = null;
	String mstCode="", tbKey ="BP_Group",mst_data="" ;
	ps_mst = con.prepareStatement("SELECT  *  FROM master_data where tablekey='BP_Group' and enable=1 and descr like '"+vendCode+"%'");
	rs_mst = ps_mst.executeQuery();
	while(rs_mst.next()){
		mst_data = rs_mst.getString("code");
		ps_mst1 = con.prepareStatement("SELECT  *  FROM  vendcust_upRel where Vend_ReconACC !='' and BP_Group='"+mst_data+"'");
		rs_mst1 = ps_mst1.executeQuery();
		while(rs_mst1.next()){
			mstCode = rs_mst1.getString("BP_Group");			
		}
	} 
%>
<span id="vendData">
<%
if(!mstCode.equalsIgnoreCase("")){
%>
<select  id="vendor_pay_term" name="vendor_pay_term"  style="font-weight: bold;width:30%;">
<option value="0"> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='payment_term' and enable=1 order by Plant");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select>
<%
}else{
%>
<select  id="vendor_pay_term" name="vendor_pay_term"  style="font-weight: bold;width:30%;">
<option value=""> - - - - - Select  - - - - - </option>
</select>
<%	
}
%>

</span>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>