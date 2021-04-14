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
	/* function button1(val) {
		var val1 = val; 
		document.getElementById("hid").value = val1;
		approve.submit();
	} */
	function button_mst(val) {
		var val1 = val; 
		document.getElementById("hidMst").value = val1;
		masterUp.submit();
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
	
	function ValidationForm() {
		document.getElementById("generateExcel").disabled = true; 
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
	<th onclick="buttonCSTMst('cust');" style="cursor: pointer;">Customer / Vendor Master List</th>
	<th onclick="buttonCSTMst('mst');" style="cursor: pointer;background-color: #793800;color: white;">Material Master List</th>
</tr>
</table>
<!-- <strong style="font-family: Arial;font-size: 16px;color: #10006E;">Customer / Vendor Master Details</strong><br/> -->
<hr />
</div>
<div id="main" style="overflow: scroll;">
<%
Connection con =  Connection_Utility.getConnectionMaster();
Connection conLocal =  Connection_Utility.getLocalUserConnection();
String userId = session.getAttribute("uid").toString();
String masterLogin="";
int s_no=1;
PreparedStatement ps_check = null, ps_upload = null,ps_check2=null;
ResultSet rs_check = null, rs_upload = null,rs_check2=null;
  PreparedStatement	ps_check1 = con.prepareStatement("SELECT  * FROM user_rel where old_id="+ userId);
	ResultSet rs_check1 = ps_check1.executeQuery();
	if (rs_check1.next()) {
		masterLogin = rs_check1.getString("type_acct");
	}
	if(masterLogin.equalsIgnoreCase("MAT_CRTD_TEAM") || masterLogin.equalsIgnoreCase("PUR_MSTCHECK")){
%> 
<form action="Generate_MatMasterExcel" method="post" name="approve" id="approve"  onsubmit="return ValidationForm();">
<%
  		if(request.getParameter("filepath")!=null){
	%> 
		<a href="DownloadFile.jsp?filepath=<%=request.getParameter("filepath") %>" class="button"><b style="font-size: 12px;background-color: yellow;">Download File</b></a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Home_MST.jsp"><b>Reset</b></a>
	<%
		}else if (!masterLogin.equalsIgnoreCase("PUR_MSTCHECK")){
	%>
		<input type="submit" name="generateExcel" id="generateExcel" value="Generate Excel" style="font-weight: bold;height: 25px;"/>
	<%	
		}
	%>
  <table border='1' width='100%'>
  <tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th width='5%' height='25'>S. No</th>
	<th>Select</th>
	<th>Material Name</th>
	<th>Material Type</th>
	<th>Remark / Details / Required for </th>
	<th>Updated/Verified By</th> 
	<th>Requester</th>
	<th>Status / Update Record</th>
	</tr>
  <%
    String status="",requester="", updated_by=""; 
	int req_id=0, pur_teamID=0;
  	ps_check = con.prepareStatement("SELECT * FROM sap_mastertran where stage in(1,2,3) order by material_type");
	rs_check = ps_check.executeQuery();
	while (rs_check.next()) {
		req_id = rs_check.getInt("uid");  
		pur_teamID = rs_check.getInt("pur_teamID");
		ps_check2 = con.prepareStatement("select * from approval_config where stage in(SELECT stage FROM sap_mastertran where id="+rs_check.getString("id")+")");
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			status = rs_check2.getString("REMARK");
		}
		ps_check2 = conLocal.prepareStatement("SELECT  u_name FROM user_tbl where u_id = "+req_id);
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			requester = rs_check2.getString("u_name"); 
		}
		ps_check2 = conLocal.prepareStatement("SELECT  u_name FROM user_tbl where u_id = "+pur_teamID);
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			updated_by = rs_check2.getString("u_name"); 
		}
 	%>
					<tr>
						<td style='text-align: center;'> <%= s_no %></td>
						<td style='text-align: center;'><% if(!updated_by.equalsIgnoreCase("")){%> <input type="checkbox" name="cheked_id" id="cheked_id" value="<%= rs_check.getString("id")%>"/><% } %> </td>
						<td> <%=rs_check.getString("mat_name")%></td>
						<td> <%=rs_check.getString("material_type")%></td>
						<td> <%=rs_check.getString("remark")%></td>
						<td> <%=updated_by%></td> 
						<td> <%=requester%></td>
						<td> <b><a href="Approval_mst.jsp?hid=<%=rs_check.getString("id")%>" style="color: blue;"><%=status %> / Click to Edit</a> <%-- <input type="button" value="<%=status %>" onclick="button1('<%= rs_check.getString("id") %>');" style="font-weight: bold;width: 120px;"/> --%></b></td> 
					</tr>
	<%
	updated_by="";
	requester="";
	req_id=0;
		s_no ++;
		}
	// *********************************************************************************************************************************************************************
	
	ps_check = con.prepareStatement("SELECT * FROM sap_mastertran where stage=0 order by material_type");
	rs_check = ps_check.executeQuery();
	while (rs_check.next()) {
		req_id = rs_check.getInt("uid"); 
		pur_teamID = rs_check.getInt("pur_teamID");
		ps_check2 = con.prepareStatement("select * from approval_config where stage in(SELECT stage FROM sap_mastertran where id="+rs_check.getString("id")+")");
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			status = rs_check2.getString("REMARK");
		}
		ps_check2 = conLocal.prepareStatement("SELECT  u_name FROM user_tbl where u_id in("+req_id+")");
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			requester = rs_check2.getString("u_name");
		}
		ps_check2 = conLocal.prepareStatement("SELECT  u_name FROM user_tbl where u_id = "+pur_teamID);
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			updated_by = rs_check2.getString("u_name"); 
		}
 	%>
					<tr style="background-color: #cecece">
							<td style='text-align: center;'> <%= s_no %></td>
							<td style='text-align: center;'><% if(!updated_by.equalsIgnoreCase("")){%> <input type="checkbox" name="cheked_id" id="cheked_id" value="<%= rs_check.getString("id")%>"/><% } %> </td>
							<td> <%=rs_check.getString("mat_name")%></td>
							<td> <%=rs_check.getString("material_type")%></td> 
							<td> <%=rs_check.getString("remark")%></td>  
							<td> <%=updated_by%></td> 
							<td> <%=requester%></td>
							<td> <b><a href="Approval_mst.jsp?hid=<%=rs_check.getString("id")%>" style="color: blue;"><%=status %> / Click to Edit</a> <%-- <input type="button" value="<%=status %>" onclick="button1('<%= rs_check.getString("id") %>');" style="font-weight: bold;width: 120px;"/> --%></b></td> 
					</tr>
	<%
	updated_by="";
	requester="";
	req_id=0;
		s_no ++;
		}
	
	// *********************************************************************************************************************************************************************
	ps_check = con.prepareStatement("SELECT * FROM sap_mastertran where stage=4 order by material_type");
	rs_check = ps_check.executeQuery();
	while (rs_check.next()) {
		req_id = rs_check.getInt("uid"); 
		pur_teamID = rs_check.getInt("pur_teamID");
		ps_check2 = con.prepareStatement("select * from approval_config where stage in(SELECT stage FROM sap_mastertran where id="+rs_check.getString("id")+")");
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			status = rs_check2.getString("REMARK");
		}
		ps_check2 = conLocal.prepareStatement("SELECT  u_name FROM user_tbl where u_id in("+req_id+")");
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			requester = rs_check2.getString("u_name");
		}
		ps_check2 = conLocal.prepareStatement("SELECT  u_name FROM user_tbl where u_id = "+pur_teamID);
		rs_check2 = ps_check2.executeQuery();
		while (rs_check2.next()) {
			updated_by = rs_check2.getString("u_name"); 
		}
 	%>
					<tr style="background-color: red;color: white;">
							<td style='text-align: center;'> <%= s_no %></td>
							<td style='text-align: center;'><% if(!updated_by.equalsIgnoreCase("")){%> <input type="checkbox" name="cheked_id" id="cheked_id" value="<%= rs_check.getString("id")%>"/><% } %> </td>
							<td> <%=rs_check.getString("mat_name")%></td>
							<td> <%=rs_check.getString("material_type")%></td> 
							<td> <%=rs_check.getString("remark")%></td>  
							<td> <%=updated_by%></td> 
								<td> <%=requester%></td>
								<td> <b><a href="Approval_mst.jsp?hid=<%=rs_check.getString("id")%>" style="color: white;"><%=status %> / Click to Edit</a> <%-- <input type="button" value="<%=status %>" onclick="button1('<%= rs_check.getString("id") %>');" style="font-weight: bold;width: 120px;"/> --%></b></td> 
					</tr>
	<%
	updated_by="";
	requester="";
	req_id=0;
		s_no ++;
		}
	
	// *********************************************************************************************************************************************************************
	
	%> 
  </table>
</form>
<%
}else {
%>
	 <table border='1' width='100%'>
	  <tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
		<th width='5%' height='25'>S. No</th> 
		<th>Material Name</th>
		<th>Material Type</th>
		<th>Remark / Details / Required for </th>
		<th>Status / Update Record</th>
		</tr>
	  <%
	    String status="";
	  	ps_check = con.prepareStatement("SELECT * FROM sap_mastertran where uid="+Integer.valueOf(userId)+" order by material_type");
		rs_check = ps_check.executeQuery();
		while (rs_check.next()) {
			ps_check2 = con.prepareStatement("select * from approval_config where stage in(SELECT stage FROM sap_mastertran where id="+rs_check.getString("id")+")");
			rs_check2 = ps_check2.executeQuery();
			while (rs_check2.next()) {
				status = rs_check2.getString("REMARK");
			}
	 	%>
						<tr>
								<td style='text-align: center;'> <%= s_no %></td> 
								<td> <%=rs_check.getString("mat_name")%></td>
								<td> <%=rs_check.getString("material_type")%></td> 
								<td> <%=rs_check.getString("remark")%></td>  
								<td> <b><a href="Approval_mst.jsp?hid=<%=rs_check.getString("id")%>" style="color: blue;"><%=status %></a> <%-- <input type="button" value="<%=status %>" onclick="button1('<%= rs_check.getString("id") %>');" style="font-weight: bold;width: 120px;"/> --%></b></td>
						</tr>
		<%
			s_no ++;
			}
		// *********************************************************************************************************************************************************************
		%>
		</table>
		<%
			}
		%>
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