<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Vendor Details</title> 
<link rel="stylesheet" type="text/css" href="css/style1.css"/>
<link rel="stylesheet" type="text/css" href="css/style2.css"/>
<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
} 
</script>
<script language="javascript">
	function button1(val) {
		var val1 = val; 
		document.getElementById("hid").value = val1;
		edit.submit();
	}
</script>
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}
 

.tftable tr {
	background-color: white;
}

.tftable td {
	font-family:Arial; 
	border-width: 1px;
	padding: 1px;
	border-style: solid;
	border-color: #729ea5;
}
</style> 
</head>
<body>
<%
try{
Connection con = Connection_Utility.getConnectionMaster();
DateFormat formatter   = new SimpleDateFormat("dd/MM/yyyy"); 
DateFormat formatter2   = new SimpleDateFormat("yyyy-MM-dd"); 
String uname="",department="";
int d_Id=0,comp_id=0;
Date date = new Date(); 
String strDate = formatter.format(date);  
String strDate2 = formatter2.format(date); 
String company = "";
ArrayList list_news = new ArrayList(); 

  	int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
  
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		d_Id = rs_uname.getInt("Dept_Id");
		PreparedStatement ps_dept=con.prepareStatement("select * from user_tbl_dept where dept_id="+d_Id);
		ResultSet rs_dept=ps_dept.executeQuery();
		while(rs_dept.next())
		{
			department = rs_dept.getString("Department");
		}
		uname=rs_uname.getString("U_Name"); 
	}
%>
<div id="container">
    <div id="content">
  <div id="menu" style="font-size: 16px;font-family: Arial;text-align: right;"> 
  <a href="Home.jsp"><strong>Home</strong></a> &nbsp; &nbsp; 
  <a href="New_Master.jsp"><strong>Add New Vendor</strong></a> &nbsp; &nbsp;
  <a href="Vendor_Details.jsp"><strong>Details</strong></a> &nbsp; &nbsp;  
  <a href="Logout.jsp"><strong>LogOut (<%=uname %>)</strong>&nbsp;&nbsp;&nbsp;&nbsp;</a> 
  </div>
 <div style="text-align: center;">
 <hr />
 <strong style="font-family: Arial;font-size: 16px;color: #10006E;">Vendor Details</strong><br/>
 <hr />
 </div>
  <div id="main" style="overflow: scroll;">
  <form action="Information.jsp" method="post" name="edit" id="edit">
  		<%
  		if(request.getParameter("success")!=null){
		%> 
	  <script type="text/javascript">
	  alert("<%=request.getParameter("success") %>");
	  </script>  
		<%
		}
		%>
  <input type="hidden" name="hid" id="hid"/>
  <table border="0" style="font-family: Arial;" class="tftable">
			<tr style="background-color: #acc8cc;text-align: center;font-size: 12px;">
				<td><strong>Sr. No.</strong> </td> 
				<td><strong>Name</strong>  </td> 
				<td><strong>Business Type</strong>  </td> 
				<td><strong>VAT/TIN </strong> </td> 
				<td><strong>Excise</strong> </td> 
				<td><strong>Activity</strong> </td>  
                <td><strong>Company</strong> </td>  
			</tr>
			<%
			int srno=1;
			PreparedStatement ps_all = con.prepareStatement("select * from vnd_info where enable_id=1");
			ResultSet rs_all = ps_all.executeQuery();
			while(rs_all.next()){
			%>
			<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=rs_all.getInt("code") %>');" style="cursor: pointer;font-size: 10px;">
				<td align="center"><%=srno %></td> 
				<td><%=rs_all.getString("name") %></td> 
				<td><%=rs_all.getString("business_type") %></td> 
				<td><%=rs_all.getString("VAT_TIN") %></td>
				<td><%=rs_all.getString("excise_no") %></td>
				<td><%=rs_all.getString("activity") %></td> 
                <td>
                <%
                PreparedStatement ps_ap = con.prepareStatement("select * from vnd_info_rel where vnd_code="+rs_all.getInt("code"));
                ResultSet rs_ap = ps_ap.executeQuery();
                while(rs_ap.next()){
                %>
               <b><%=rs_ap.getString("company") %></b>,
                <%
                }
                %>
                </td>
			</tr>
			<%
			srno++;
			}
			%>
		</table>
</form>
 </div>
</div>
<div id="footer" style="width: 900px; margin: 0 auto; background: #FFFFFF;">
<a href="http://www.muthagroup.com/"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp; 
<strong>Mail to :</strong>&nbsp;
<a href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top" style="color: blue;">itsupports@muthagroup.com</a> &nbsp; | &nbsp;
Date :&nbsp;<strong><%=formatter.format(date) %></strong> 
</div>
</div>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>