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

function validatenumerics(key) {
	//getting key code of pressed key
	var keycode = (key.which) ? key.which : key.keyCode;
	//comparing pressed keycodes	 
	if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46 && keycode != 37 && keycode != 38 && keycode != 39 && keycode != 40) {
	    alert("Only allow numeric Data entry");
	    return false;
	}else 
	{
		return true;
	};
}	

function ValidationForm() { 
	var name_org3 = document.getElementById("name_org3");
	// var name_org4 = document.getElementById("name_org4");
	var role = document.getElementById("role");
	var acct_assign_grp = document.getElementById("acct_assign_grp"); 
	if (name_org3.value == "") {
		alert("Please Provide Name of org 3 !!!");
		document.getElementById("Submit").disabled = false; 
		return false;  
	}
	/* if (name_org4.value == "") {
		alert("Please Provide Name of org 4 !!!");
		document.getElementById("Submit").disabled = false; 
		return false;  
	} */
	if (acct_assign_grp.value == "") {
		alert("Please Select / Provide Account Assignment Group !!!");
		document.getElementById("Submit").disabled = false; 
		return false;  
	}
	if (role.value == "") {
		alert("Please Select / Provide Role !!!");
		document.getElementById("Submit").disabled = false; 
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
    font-family: Serif;
}
.dropdown {
    position: relative;
    display: inline-block;
}
.dropdown-content {
    display: none;
	font-family: Serif;
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
	font-family: Serif;
	font-size: 12px;
	color: #333333; 
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}
.tftable tr {
	background-color: white;
	font-family: Serif;
}
.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
	font-family: Serif; 
	background-color: white;
}
</style>
</head>
<body>
	<%
		try {
			Connection con =  Connection_Utility.getConnectionMaster();
			Connection con1 =  Connection_Utility.getLocalUserConnection();
			String hid = request.getParameter("hid_myreg");
	%>
	<div id="container">
		<div id="content">
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!---------------------------------------------------------------------  Include Header ------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
<%@include file="Header.jsp" %>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
 <div style="text-align: center;">
 <hr />
 <strong style="font-family: Serif;font-size: 16px;color: #10006E;">Customer / Vendor Details</strong><br/>
 <hr />
 </div>
  <div id="main" style="overflow: scroll;height: 750px;"> 
  <table border='1' width='100%' style="background-color: #feffc5">
 <%
  int s_no=1;
 String region="",cust_vend="", user_Req="", comp_data="";
 
 PreparedStatement ps_mst = null, ps_mst1=null ,ps_mst2=null;
	ResultSet rs_mst = null,rs_mst1=null,rs_mst2=null;
  	PreparedStatement ps_check = null, ps_check1 = null, ps_upload = null;
	ResultSet rs_check = null, rs_check1 = null,rs_upload = null;
  	ps_check = con.prepareStatement("SELECT * FROM sap_masterVendCust where id ="+ Integer.valueOf(hid));
	rs_check = ps_check.executeQuery();
	while (rs_check.next()) {
		cust_vend = rs_check.getString("cust_vend");
		    ps_check1 = con.prepareStatement("SELECT * FROM master_data where code ='"+ rs_check.getString("region")+"'");
			rs_check1 = ps_check1.executeQuery();
			while (rs_check1.next()) {
				region=rs_check1.getString("descr");
			}
			
			 ps_mst2 = con1.prepareStatement("SELECT * FROM complaintzilla.user_tbl where u_id="+ Integer.parseInt(rs_check.getString("uid")));
			 rs_mst2 = ps_mst2.executeQuery();
				while (rs_mst2.next()) {
					user_Req=rs_mst2.getString("U_Name");
				}
 	%>
  <tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th width="20">COMPANY</th>
	<th width="10">Customer / Vendor For</th>
	<th width="10">Reason / Required For</th>
	<th width="20">NAME OF ORG</th>
	<th width="20">NAME ORG 2</th>
	<th width="10">SEARCH TERM</th>
	<th width="10">ADDRESS 1</th></tr>				
	<tr style='font-size: 12px; background-color: white;'><td> 
	<%
	ps_mst = con.prepareStatement("SELECT * FROM master_data where tablekey ='company_code' and enable=1 and code='"+rs_check.getString("company")+"'");
	rs_mst = ps_mst.executeQuery();
	while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> 
</td>	
<td> 
<%
		ps_mst = con.prepareStatement("SELECT  *  FROM master_data where tablekey='BP_Group' and enable=1 and descr like '"+rs_check.getString("cust_vend")+"%'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
%>
		<%=rs_mst.getString("descr").replace("VENDOR", "") %>
<%
		}
		ps_mst.close();
		rs_mst.close();
%> 
		  </td>
		  <td><%=rs_check.getString("reason_for")%></td> 
		  <td><%=rs_check.getString("name_org")%></td>
		  <td><%=rs_check.getString("name_org2")%></td> 
		  <td><%=rs_check.getString("search_term")%></td> 
		  <td><%=rs_check.getString("address1")%></td></tr>
	<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>ADDRESS 2</th>
	<th>ADDRESS 3</th>
	<th>ADDRESS 4</th>
	<th>POSTAL CODE</th>
	<th>CITY</th>
	<th>COUNTRY</th>
	<th>REGION</th></tr>	
	<tr style='font-size: 12px; background-color: white;'><td><%=rs_check.getString("address2")%></td>
		  <td><%=rs_check.getString("address3")%></td> 
		  <td><%=rs_check.getString("address4")%></td> 
		  <td><%=rs_check.getString("postal_code")%></td> 
		  <td><%=rs_check.getString("city")%></td> 
		  <td>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='country_code' and enable=1 and code='"+rs_check.getString("country")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> 
	</td>
	<td> 
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='CN_Region' and enable=1 and descr= '"+region+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> 
	</td></tr>
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>LANGUAGE</th>
	<th>SALES ORG</th>
	<th>DIST. CHANNEL</th>
	<th>DIVISION</th>
	<th>CURRENCY</th>
	<th>SHIPPING COND.</th>
	<th>VENDOR PAY TERM</th></tr>
	<tr style='font-size: 12px; background-color: white;'><td> <%=rs_check.getString("language")%> </td>
	<td>
	<%
		ps_mst = con.prepareStatement("SELECT DISTINCT code, descr FROM master_data where tablekey='sales_org' and code='"+rs_check.getString("sales_org")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
		  </td>
		  <td>
<%
		ps_mst = con.prepareStatement("SELECT DISTINCT code  FROM master_data where tablekey='dist_channel' and enable=1 and code='"+rs_check.getString("dist_channel")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("code")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
		  </td> 
		  <td>  
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='division' and enable=1 and code='"+rs_check.getString("division")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
	  </td> 
		  <td>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='currency' and enable=1 and code='"+rs_check.getString("currency")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> 
		  </td> 
		  <td> 
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='shipping_cond' and enable=1 and code='"+rs_check.getString("shipping_cond")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> 
		  </td>
		  <td> 
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='payment_term' and enable=1 and code='"+rs_check.getString("vendor_pay_term")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
		  </td> </tr>
		  
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>CUST PAY TERM</th>
	<th>GST NO</th>
	<th>PURCHAGE GROUP</th>
	<th>PURCHASE ORG.</th>
	<th>VENDOR CURRENCY</th>
	<th>INCO TERM</th>
	<th>INCO TERM LOCATION</th></tr>	
	<tr style='font-size: 12px; background-color: white;'><td>
	<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='payment_term_cust' and enable=1 and code='"+rs_check.getString("cust_pay_term")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
	</td>
		  <td><%=rs_check.getString("gst_no")%></td> 
		  <td> 
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='purchase_Group' and enable=1 and code='"+rs_check.getString("purchage_group")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
		  </td> 
		  <td> 
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='purchase_org' and enable=1 AND code='"+rs_check.getString("purchase_org")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> 
		  </td> 
		  <td>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='currency' and enable=1 and code ='"+rs_check.getString("vendor_currency")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> 		  
		  </td> 
		  <td>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='inco_term' and enable=1 and code='"+rs_check.getString("inco_term")+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<%=rs_mst.getString("descr")%>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
		  </td>
		  <td><%=rs_check.getString("inco_location")%></td></tr>
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>
	<th>PAN NO</th>
	<th>Email ID</th>
	<th>Mobile NO</th>
	<th>Requested By</th>
	<th colspan="3">Remark / Details</th> </tr>	
	<tr style='font-size: 12px; background-color: white;'><td><%=rs_check.getString("pan_no")%></td>
		  <td><%=rs_check.getString("email")%></td> 
		  <td><%=rs_check.getString("mobile_no")%></td> 
		  <td><b><%=user_Req %></b></td>
		  <td colspan="3"><%=rs_check.getString("remark")%></td> </tr>
	<%
		}
	%>
  </table>
  <br />
<!-- ***************************************************************************************************************************************************************** -->
<!-- ******************************************************************** Update Form Details ******************************************************************** -->  
<!-- ***************************************************************************************************************************************************************** -->  
<%
String keyGroup="";
ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='BP_Group' and enable=1 and descr like '"+cust_vend+"%'");
rs_mst = ps_mst.executeQuery();
while(rs_mst.next()){
	keyGroup = rs_mst.getString("code");
}
ps_mst.close();
rs_mst.close();
%>

<input  type="hidden" name="hid" id="hid" value="<%=hid%>"/>
<input  type="hidden" name="hid_group" id="hid_group" value="<%=keyGroup%>"/>
<%
String rawTest ="", selQuery="";

ps_check = con.prepareStatement("SELECT * FROM sap_masterVendCust where id ="+ Integer.valueOf(hid));
rs_check = ps_check.executeQuery();
while (rs_check.next()) {
%> 
<table class="tftable" id="myForm">
<tr style="background-color: #eaf2ff;font-size:16px; font-weight: bold;text-align: center;">
<td colspan="4">
<hr />
<strong>Updated data from Accounts</strong>
<br />
<hr />
</td>
</tr>
<tr>
<td width="250px">Name of org 3</td><td> 
<% 
String name33 ="";
if(rs_check.getString("name_org3")!=null) {
	name33 = rs_check.getString("name_org3");
}
%>
 <%=name33%>
</td>
</tr>
<tr>
<td width="250px">Name of org 4</td><td>
<%
String name44 ="";
if(rs_check.getString("name_org4")!=null) {
	name44 = rs_check.getString("name_org4");
}
%>
 <%=name44%>
</td>
</tr>
<tr>
<td width="250px">Account Assignment Group Cust.</td><td> 
	<%
	rawTest = rs_check.getString("acct_assign_grp");
	if(rawTest=="" || rawTest ==null){
		 	
	}else{
		selQuery = "SELECT * FROM master_data where tablekey='acct_assgnGroup_Cust' and code in (SELECT acct_assign_grp FROM sap_masterVendCust where acct_assign_grp=4)";
		ps_mst = con.prepareStatement(selQuery);
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
	<%=rs_mst.getString("descr")%>
	<%
		}
			}
		ps_mst.close();
		rs_mst.close(); 
	%>
</td>
</tr>

<tr>
<td width="250px">Customer / Vendor Role</td><td>  
<% 
rawTest = rs_check.getString("BP_Role");

	if(rawTest=="" || rawTest ==null){
		
	}else{
		ps_mst = con.prepareStatement("SELECT * FROM master_data where  tablekey='BP_Role' AND code in (SELECT BP_Role FROM vendcust_upRel where BP_Role='ZBPSUBX' and enable=1 and BP_Role!='')");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%> 
<%=rs_mst.getString("descr") %>	
	<%
		} 
	}
	%>	
</td>
</tr>
<tr>
<td>Customer Reconciliation Account</td><td>  
	<%
	String codeRef="";
	String custRecon = rs_check.getString("Cust_ReconACC");
	if(custRecon=="" || custRecon==null || custRecon.equalsIgnoreCase("")){
		
	}else{ 
	ps_mst = con.prepareStatement("SELECT * FROM master_data where tablekey='Cust_ReconACC' and enable=1 and code in (SELECT Cust_ReconACC  FROM vendcust_upRel where BP_Group='ZSUB' and enable=1 and Cust_ReconACC='"+custRecon+"')");
	rs_mst = ps_mst.executeQuery();
	while(rs_mst.next()){
	%>
	<%=rs_mst.getString("descr")%>
	<%	
	}
	ps_mst.close();
	rs_mst.close();	 
	}
	%> 
</td>
</tr>
<tr>
<td>Vendor Reconciliation Account</td><td> 
	<%
		codeRef="";
		String vend_recon = rs_check.getString("Vend_ReconACC");
		String veng_key =  keyGroup;
		// System.out.println("Data =  " + vend_recon + " = = " + veng_key);		
		if(vend_recon=="" || vend_recon==null || vend_recon.equalsIgnoreCase("")){
			
		}else{ 
ps_mst = con.prepareStatement("SELECT * FROM master_data where tablekey='Vend_ReconACC'  and enable=1 and code in (SELECT Vend_ReconACC  FROM vendcust_upRel where BP_Group='ZSUB' and enable=1 and Vend_ReconACC ='"+vend_recon+"')");
rs_mst = ps_mst.executeQuery();
while(rs_mst.next()){
%>
<%=rs_mst.getString("descr")%>
<%
} 
ps_mst.close();
rs_mst.close();
}
	%> 
</td>
</tr>
<tr>
<td>Customer Pricing Procedure</td><td>  
	<%
		codeRef = "";
		String custPrice = rs_check.getString("Cust_Price_Proc"); 
		if(custPrice=="" || custPrice==null || custPrice.equalsIgnoreCase("")){
		
		}else{
		ps_mst = con.prepareStatement("SELECT * FROM master_data where tablekey='Cust_Price_Proc' and code in(SELECT Cust_Price_Proc  FROM vendcust_upRel where BP_Group='ZSUB' and enable=1 and Cust_Price_Proc='"+custPrice+"')");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
		%>
		<%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr")%>
		<%	
		}
		}
	%> 
</td>
</tr>
<tr>
<td>Schema Group</td><td>  
	<%
		codeRef="";		
		String schema_code = rs_check.getString("Schema_Group"); 
		if(schema_code=="" || schema_code==null || schema_code.equalsIgnoreCase("")){
		
		}else{
			%> 		
			<%		
			ps_mst = con.prepareStatement("select * from master_data where tablekey='Schema_Group' and enable=1 and code in (SELECT Schema_Group FROM vendcust_upRel where BP_Group='ZSUB' and enable=1 and Schema_Group='"+schema_code+"')");
			rs_mst = ps_mst.executeQuery();
			while(rs_mst.next()){
		%>
			<%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr") %>
			<% 
			}
			} 
	%> 
</td>
</tr>
<tr>
<td>Sub Contracting Vendor ?</td><td>
<%  
if(keyGroup.equalsIgnoreCase("ZDPK") || keyGroup.equalsIgnoreCase("ZDCP") || keyGroup.equalsIgnoreCase("ZIRM") ||
		keyGroup.equalsIgnoreCase("ZSER") || keyGroup.equalsIgnoreCase("ZSUB") || keyGroup.equalsIgnoreCase("ZTOO") || keyGroup.equalsIgnoreCase("ZCSU")){
%>	
	<input type="checkbox" name="subVnd" id="subVnd" checked="checked" value="1" disabled="disabled"/>
	<input type="hidden" name="subconVend" id="subconVend" value="1"/>
<%		
}else{
%>
	<input type="checkbox" name="subVnd" id="subVnd" value="1" disabled="disabled"/>
	<input type="hidden" name="subconVend" id="subconVend" value=""/>
<%	
}
%>
</td>
</tr>




<tr>
<td><b style="color: red;">Reject Customer / Vendor </b><br /> (Provide Reason)</td>
<td>
<%
ps_check = con.prepareStatement("SELECT * FROM sap_masterVendCust where id ="+ Integer.valueOf(hid) +" and stage='4'");
rs_check = ps_check.executeQuery();
if(rs_check.next()){
%>
<input type="checkbox" name="reject" id="reject" readonly="readonly" value="1" onclick ="rejectMe()" checked/> 
<textarea rows="3" cols="30" name="rejectReason" id="rejectReason" readonly="readonly"><%=rs_check.getString("reject_reason") %>..Rejected By <%=rs_check.getString("rejected_by") %></textarea>

<%
}else{
%>
<input type="checkbox" name="reject" id="reject" value="1" onclick ="rejectMe()" readonly="readonly"/> 
<textarea rows="3" cols="30" name="rejectReason" id="rejectReason" readonly="readonly"></textarea>
<%	
}
%>
</td>
</tr>




<%-- <tr>
<td colspan="4" align="center">								 
	<%
  		if(request.getParameter("filepath")!=null){
	%> 
		<a href="DownloadFile.jsp?filepath=<%=request.getParameter("filepath") %>" class="button"><b>Download File</b></a>
	<%
		}else{
	%>
		<input type="submit" name="Submit" id="Submit" value="Generate Excel" class="button"/>
	<%	
		}
	%>
</td> 
</tr> --%>
</table>
<%
		}
%> 
<!-- ***************************************************************************************************************************************************************** --> 
<!-- ***************************************************************************************************************************************************************** -->
 </div>
</div>
<div id="footer" style="width: 900px; margin: 0 auto; background: #FFFFFF;">
<a href="http://www.muthagroup.com/"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp;
<strong>Mail to :</strong>&nbsp;
<a href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top" style="color: blue;">itsupports@muthagroup.com</a> &nbsp; 
</div>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>