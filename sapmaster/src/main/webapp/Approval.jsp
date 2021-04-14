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

function ValidationForm() {
	var remark = document.getElementById("remark"); 
	
	if (remark.value == "") {
		alert("Please Provide Approval Remark !!!");
		document.getElementById("remark").disabled = false; 
		return false;  
	} 
	document.getElementById("Submit").disabled = true; 
}

</script>
<style>
.button {
	background-color: #f48342;
	border: none;
	color: white;
	padding: 13px 28px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	font-weight: bold; margin : 3px 1px;
	cursor: pointer;
	margin: 3px 1px;
}
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
			Connection con =  Connection_Utility.getConnectionMaster();
			String hid = request.getParameter("hid");
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
 <strong style="font-family: Arial;font-size: 16px;color: #10006E;">Approval for New Customer / Vendor</strong><br/>
 <hr />
 </div>
  <div id="main" style="overflow: scroll;"> 
  <table border='1' width='100%'>
 <%
  int s_no=1;
 String region="";
 PreparedStatement ps_mst = null;
	ResultSet rs_mst = null;
  	PreparedStatement ps_check = null, ps_check1 = null, ps_upload = null;
	ResultSet rs_check = null, rs_check1 = null,rs_upload = null;
  	ps_check = con.prepareStatement("SELECT * FROM sap_masterVendCust where id ="+ Integer.valueOf(hid));
	rs_check = ps_check.executeQuery();
	while (rs_check.next()) {
		    ps_check1 = con.prepareStatement("SELECT * FROM master_data where code ='"+ rs_check.getString("region")+"'");
			rs_check1 = ps_check1.executeQuery();
			while (rs_check1.next()) {
				region=rs_check1.getString("descr");
			} 
 %>	
  <tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>COMPANY</th>
	<th>Customer / Vendor For</th>
	<th>Reason / Required For</th>
	<th>NAME OF ORG</th>
	<th>NAME ORG 2</th>
	<th>SEARCH TERM</th>
	<th>ADDRESS 1</th></tr>					
	<tr><td> <%=rs_check.getString("company")%></td>
		  <td> <%=rs_check.getString("cust_vend")%></td> 
		  <td> <%=rs_check.getString("reason_for")%></td> 
		  <td> <%=rs_check.getString("name_org")%></td> 
		  <td> <%=rs_check.getString("name_org2")%></td> 
		  <td> <%=rs_check.getString("search_term")%></td> 
		  <td> <%=rs_check.getString("address1")%></td></tr>
	<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>ADDRESS 2</th>
	<th>ADDRESS 3</th>
	<th>ADDRESS 4</th>
	<th>POSTAL CODE</th>
	<th>CITY</th>
	<th>COUNTRY</th>
	<th>REGION</th></tr>	
	<tr><td> <%=rs_check.getString("address2")%></td>
		  <td> <%=rs_check.getString("address3")%></td> 
		  <td> <%=rs_check.getString("address4")%></td> 
		  <td> <%=rs_check.getString("postal_code")%></td> 
		  <td> <%=rs_check.getString("city")%></td> 
		  <td> <%=rs_check.getString("country")%></td>
		  <td> <%=region%></td></tr>
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>LANGUAGE</th>
	<th>SALES ORG</th>
	<th>DIST. CHANNEL</th>
	<th>DIVISION</th>
	<th>CURRENCY</th>
	<th>SHIPPING COND.</th>
	<th>VENDOR PAY TERM</th></tr>	
	<tr><td> <%=rs_check.getString("language")%></td>
		  <td> <%=rs_check.getString("sales_org")%></td> 
		  <td> <%=rs_check.getString("dist_channel")%></td> 
		  <td> <%=rs_check.getString("division")%></td> 
		  <td> <%=rs_check.getString("currency")%></td> 
		  <td> <%=rs_check.getString("shipping_cond")%></td>
		  <td> <%=rs_check.getString("vendor_pay_term")%></td> </tr>
		  
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>CUST PAY TERM</th>
	<th>GST NO</th>
	<th>PURCHAGE GROUP</th>
	<th>PURCHASE ORG.</th>
	<th>VENDOR CURRENCY</th>
	<th>INCO TERM</th>
	<th>INCO TERM LOCATION</th></tr>	
	<tr><td> <%=rs_check.getString("cust_pay_term")%></td>
		  <td> <%=rs_check.getString("gst_no")%></td> 
		  <td> <%=rs_check.getString("dist_channel")%></td> 
		  <td> <%=rs_check.getString("purchase_org")%></td> 
		  <td> <%=rs_check.getString("vendor_currency")%></td> 
		  <td> <%=rs_check.getString("inco_term")%></td>
		  <td> <%=rs_check.getString("inco_location")%></td> </tr>	
		  
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>PAN NO</th>
	<th>Email ID</th>
	<th>Mobile NO</th>
	<th colspan="4">Remark / Details</th> </tr>	
	<tr><td> <%=rs_check.getString("pan_no")%></td>
		  <td> <%=rs_check.getString("email")%></td> 
		  <td> <%=rs_check.getString("mobile_no")%></td> 
		  <td colspan="4"> <%=rs_check.getString("remark")%></td> </tr>
	<% 
			}
	%> 
  </table> 
  <br />

<!-- ***************************************************************************************************************************************************************** -->
<!-- ******************************************************************** Approval Form Details ****************************************************************** -->  
<!-- ***************************************************************************************************************************************************************** --> 
  
<form action="Approval_control" method="post" name="approved" id="approved" onsubmit="return ValidationForm();">
  <input type="hidden" name="hid" id="hid" value="<%=hid%>"/> 
  <table border='1' width='50%'>
  	<tr style='font-size: 12px; background-color: yellow; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: left;'>
	<th colspan="7">Approval Required :</th> 
	</tr>
	<tr><td><b> Approval Status </b></td>
	<td>
<select  id="approval_status" name="approval_status" style="font-weight: bold;">
<%
		ps_mst = con.prepareStatement("SELECT * FROM approval_type where enable=1");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("id")%>"><%=rs_mst.getString("approval_Type")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select>
	</td>	</tr>
	<tr><td><b> Approval Remark </b></td>
	<td> <textarea rows="1" cols="30" name="remark" id="remark" style="background-color: #cee7ff; font-weight: bold; font-size: 20px;"></textarea>
	</td>
	</tr>
	<tr><td colspan="2"><input type="submit" name="Submit" id="Submit" value="Submit Data" class="button"/>
	</td>
	</tr>
</table>
</form>

<!-- ***************************************************************************************************************************************************************** --> 
<!-- ***************************************************************************************************************************************************************** --> 

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