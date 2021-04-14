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
<title>Home Page</title> 
<!-- <link rel="stylesheet" type="text/css" href="css/style1.css"/> -->
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
		approve.submit();
	}
	function button_mst(val) {
		var val1 = val; 
		document.getElementById("hidMst").value = val1;
		masterUp.submit();
	}
	function button_mstReg(val) {
		var val1 = val; 
		document.getElementById("hid_myreg").value = val1;
		masterReg.submit();
	}
	function buttonCSTMst(val){
		var val1 = val;  
		if(val1=='cust'){
			window.location = 'Home.jsp';
		}
		if(val1=='mst'){
			window.location = 'Home_MST.jsp';	
		}
	}
</script>
<style>
.dropbtn {
    background-color: black;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
    font-family: Arial;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
	font-family: Arial;
    position: absolute;
    background-color: #3b7687;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: black;}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: black;
}
.tftable {
	font-size: 12px;
	color: #333333; 
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}
.tftable tr {
	background-color: white;
}
.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
</head>
<body>
	<%
		try {
	%>
	<div id="container">
		<div id="content">
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
<%@include file="Header.jsp" %>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
   		<%
  		if(request.getParameter("success")!=null){
		%>
	  <script type="text/javascript">
	  alert("<%=request.getParameter("success") %>");
	  </script>
		<%
		}
		%>
<div style="text-align: center;">
<hr /> 
 <table border='1' width='100%'>
 <tr style='font-size: 14px; background-color: #e9d2be; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;height: 25px;'>
	<th onclick="buttonCSTMst('cust');" style="cursor: pointer;background-color: #793800;color: white;">My Registrations</th>
	<!-- <th onclick="buttonCSTMst('mst');" style="cursor: pointer;">Material Master List</th>
	<th style="cursor: pointer;">Material Master List</th> -->
</tr>
</table>
<!-- <strong style="font-family: Arial;font-size: 16px;color: #10006E;">Customer / Vendor Master Details</strong><br/> -->
<hr /> 

</div>
<div id="main" style="overflow: scroll;">
<%
Connection con =  Connection_Utility.getConnectionMaster();
String userId = session.getAttribute("uid").toString(); 
int s_no=1;
PreparedStatement ps_check = null, ps_upload = null, ps_apset = null;
ResultSet rs_check = null, rs_upload = null, rs_apset=null; 
%>
<form action="All_Registrations.jsp" method="post" name="masterReg" id="masterReg">
		  <input type="hidden" name="hid_myreg" id="hid_myreg"/>
		  <table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
			<th width='5%' height='25'>S. No</th>
			<th>Customer / Vendor For</th>
			<th>NAME OF ORG</th>
			<th>Reason / Required For</th>
			<th>PAN NO </th>
			<th>Email ID</th>
			<th>Mobile NO</th>
			<th>Approval Status</th>
			</tr> 
		  <% 
		  String apr_set="", nameAppr="";
		  	ps_check = con.prepareStatement("SELECT * FROM sap_masterVendCust where uid ="+userId+" and id IN (SELECT id_vendormaster FROM approval_VendCust_rel)");
			rs_check = ps_check.executeQuery();
			while (rs_check.next()) {
				ps_apset = con.prepareStatement("SELECT approval_Type FROM approval_type where id in(SELECT  id_approval FROM approval_VendCust_rel where id_vendormaster='"+rs_check.getInt("id")+"')");
				rs_apset=ps_apset.executeQuery();
				while(rs_apset.next()){
					apr_set = rs_apset.getString("approval_Type");
				}
				ps_apset = con.prepareStatement("SELECT approver_name FROM approval_VendCust_rel where id_vendormaster="+rs_check.getInt("id"));
				rs_apset=ps_apset.executeQuery();
				while(rs_apset.next()){
					nameAppr = rs_apset.getString("approver_name");
				}
		 %>
						<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button_mstReg('<%= rs_check.getString("id") %>');" style="cursor: pointer;">
									<td style='text-align: center;'> <%= s_no %></td>
									<td> <%=rs_check.getString("cust_vend")%></td>
									<td> <%=rs_check.getString("name_org")%></td> 
									<td> <%=rs_check.getString("reason_for")%></td> 
									<td> <%=rs_check.getString("pan_no")%></td> 
									<td> <%=rs_check.getString("email")%></td> 
									<td> <%=rs_check.getString("mobile_no")%></td> 
									<td><b><%=apr_set %> : <%=nameAppr %></b></td></tr>
			<%
				s_no ++;
				} 
			%>
		  </table>
		</form> 
 </div>
</div>
<div id="footer" style="width: 900px; margin: 0 auto; background: #FFFFFF;">
<a href="http://www.muthagroup.com/"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp; 
<strong>Mail to :</strong>&nbsp;
<a href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top" style="color: blue;">itsupports@muthagroup.com</a> &nbsp; </strong> 
</div>
</div>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>