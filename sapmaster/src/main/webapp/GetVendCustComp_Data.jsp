<%@page import="org.antlr.grammar.v3.ANTLRv3Parser.qid_return"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Data</title>
<script type="text/javascript">
function checkFunction() {
	var name_org = document.getElementById("name_org").value;
	var xmlhttp;
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest(); 
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("already_avail").innerHTML = xmlhttp.responseText; 
		}
	};
	xmlhttp.open("POST", "GetVendCustMaster.jsp?q=" + name_org , true);   
	xmlhttp.send();
}
</script>
</head>
<body>
<%
try{
 	String company = request.getParameter("q");
 	Connection con = Connection_Utility.getConnectionMaster();
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String uname = session.getAttribute("username").toString();
	PreparedStatement ps_mst = null;
	ResultSet rs_mst = null;
%>
<span id=company_data>
<%
if(company.equalsIgnoreCase("")){
%>
<table class="tftable" id="myForm">
<tr style="background-color: #eaf2ff;font-size:16px; font-weight: bold;text-align: center;">
<td colspan="4">
<hr />
New Customer / Vendor Creation &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="New_VendCust.jsp">Reset</a>
<br />
<hr />
</td>
</tr> 
<tr><td  style="width:200px;">COMPANY</td><td colspan="3">
<select  id="company" name="company"  style="font-weight: bold;" onchange="updateCompany_Data(this.value)">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='company_code' and enable=1");
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
</td></tr>

<!-- <tr>
<td><b style="font-size: 13px;">Add New</b></td>
<td>
<select name="vendSupp" id="vendSupp" style="font-weight: bold;">
<option value="0"> - - - - - Select  - - - - - </option>
<option value="1">Vendor</option>
<option value="2">Customer</option> 
</select>
</td>
</tr> -->
<!-- <tr>
<td>Name (40 Characters)</td>
<td colspan="3"><input type="text" name="mat_name" id="mat_name" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"  onkeyup="this.value = this.value.toUpperCase();"/></td> 
</tr> -->  

<tr><td style="width:200px;">Customer / Vendor For</td><td>
<select id="cust_vend" name="cust_vend"  style="font-weight: bold;" onchange="check_PayTerms(this.value)">
<option value=""> - - - - - Select - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='BP_Group' and enable=1 and descr not in('INTER PLANT VENDOR')");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("descr").replace("VENDOR", "")%>"><%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr").replace("VENDOR", "")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select>
</td>

<%-- <td>ROLE</td><td>  
<select name="role" id="role"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
	<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='BP_Role' and enable=1");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select>
</td> --%> 
<td>Reason / Required For</td>
<td>
<textarea rows="1" cols="30" name="reason_for" id="reason_for" style="font-size: 15px;font-weight: bold;"></textarea>
</td>
 
</tr>

<tr> <td>NAME OF ORG</td><td colspan="3"> <input type="text" name="name_org" id="name_org" maxlength="80" style="width:400px;font-size: 15px;font-weight: bold;" onkeyup="checkFunction()"/></td></tr>

<!-- <tr> <td>NAME ORG 2</td><td colspan="3"> <input type="text" name="name_org2"  id="name_org2"  maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr> -->

<tr> <td>SEARCH TERM</td><td colspan="3"> <input type="text" name="search_term" id="search_term"  maxlength="20" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
 
<tr><td>ADDRESS 1 <br />(House / Floor / Building No)</td><td colspan="3"><input type="text" name="address1" id="address1" maxlength="10" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 2 <br />(Street / Locality)</td><td colspan="3"><input type="text" name="address2" id="address2" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 3</td><td colspan="3"><input type="text" name="address3" id="address3" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 4</td><td colspan="3"><input type="text" name="address4" id="address4" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>

<tr><td>POSTAL CODE</td><td>
<input type="text" name="postal_code" id="postal_code" maxlength="6" style="width:100px;font-size: 15px;font-weight: bold;" style="cursor: text" onkeypress="return validatenumerics(event);"/>   </td><td>CITY</td><td> <input type="text" name="city" id="city" maxlength="20" style="width:100px;font-size: 15px;font-weight: bold;"/>
</td></tr>
<tr><td>COUNTRY</td><td>
<select name="country" id="country" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='country_code' and enable=1");
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
</td>
<td>REGION</td><td> 
<select name="region" id="region" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='CN_Region' and enable=1");
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
</td></tr>
<tr><td>LANGUAGE</td><td><strong>EN (English)</strong><input  type="hidden" name="language" id="language" value="EN"/></td> 
<td>SALES ORG</td><td>  
<select name="sales_org" id="sales_org" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT DISTINCT code, descr  FROM master_data where tablekey='sales_org'  order by code");
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
</td>  </tr>
<!-- <tr><td>VALID FROM</td><td><select name="valid from" id="valid_from" name="valid_from"  style="font-weight: bold;"></select></td><td>VALID TO</td><td> <input type="text" name="valid to" id="valid to"/></td></tr> -->
<!-- <tr><td>TAX TYPE</td><td><select name="tax type" id="tax_type" name="tax_type"  style="font-weight: bold;"></select></td><td>GST NO</td><td> <input type="text" name="gst_no" id="gst_no" maxlength="15" style="width:250px;font-size: 15px;font-weight: bold;"/></td></tr> -->

<!-- <tr><td>CUST REC. ACCT</td><td> <input type="text" name="cust_rec_acct" id="cust_rec_acct"/></td><td>VEND REC. ACCT</td><td><input type="text" name="vend_rec_acct" id="vend_rec_acct"/></td></tr> -->

<tr><td>DIST. CHANNEL</td><td>
<select name="dist_channel" id="dist_channel"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT  DISTINCT code, descr  FROM master_data where tablekey='dist_channel' and enable=1 order by code");
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
</td><td>DIVISION</td><td>
<select name="division" id="division"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='division' and enable=1 order by Plant");
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
</td></tr>


<tr><td>CURRENCY</td><td>
<select name="currency" id="currency" style="font-weight: bold;">
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='currency' and enable=1 order by Plant");
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

</td><td>SHIPPING COND.</td>
<td>
<select id="shipping_cond" name="shipping_cond"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='shipping_cond' and enable=1");
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
</td></tr>

<!-- <tr><td>VENDOR PAY TERM</td><td>
<input type="text" name="vendor_pay_term" id="vendor_pay_term" maxlength="20" style="font-weight: bold;"/></td><td>CUST PAY TERM</td><td> 
<input type="text" name="cust_pay_term" id="cust_pay_term" maxlength="20" style="font-weight: bold;"/></td></tr> -->

<tr>
<td>VENDOR PAY TERM</td><td colspan="3">
<span id="vendData">
<select  id="vendor_pay_term" name="vendor_pay_term"  style="font-weight: bold;width:30%;">
<option value=""> - - - - - Select  - - - - - </option>
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
</span>
</td>
</tr>
<tr>
<td>CUST PAY TERM</td><td colspan="3"> 
<span id="custData">
<select  id="cust_pay_term" name="cust_pay_term"  style="font-weight: bold;width:30%;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='payment_term_cust' and enable=1 order by Plant");
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
</span>
</td></tr>





<tr><td>GST NO</td><td> <input type="text" name="gst_no" id="gst_no" maxlength="15" style="width:250px;font-size: 15px;font-weight: bold;"/></td>
<td>PURCHAGE GROUP</td>
<td colspan="3"><select  id="purchage_group" name="purchage_group" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='purchase_Group' and enable=1 order by Plant");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select></td></tr>
<!-- <tr><td>SGST</td><td><input type="text" name="cgst" id="cgst"/></td><td>IGST</td><td> <input type="text" name="igst" id="igst"/></td></tr> -->
<tr><td>PURCHASE ORG.</td>
<td>
<select id="purchase_org" name="purchase_org"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='purchase_org' and enable=1 order by Plant");
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
</td>
<td>VENDOR CURRENCY</td><td>  
<select name="vendor_currency" id="vendor_currency" style="font-weight: bold;">
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='currency' and enable=1 order by Plant");
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
</td></tr>

<tr><td>INCO TERM</td><td>  
<select id="inco_term" name="inco_term"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='inco_term' and enable=1 order by Plant");
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
</td>
<td>INCO TERM LOCATION</td><td>
<input  type="text" name="inco_location" id="inco_location" maxlength="20" style="font-weight: bold;"/></td>
</tr>
	
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Other Details</td>
							</tr> 
<tr><td>PAN NO</td><td> <input type="text" name="pan_no" id="pan_no" maxlength="10" style="width:250px;font-size: 15px;font-weight: bold;"/></td>
<td>Email ID</td><td> <input type="text" name="email" id="email" style="width:250px;font-size: 15px;font-weight: bold;"/></td></tr>				
<tr><td>Mobile NO</td><td> <input type="text" name="mobile_no" id="mobile_no" maxlength="10" style="width:250px;font-size: 15px;font-weight: bold;" onkeypress="return validatenumerics(event);"/></td>
<td>Remark / Details</td><td><textarea rows="1" cols="30" name="remark" id="remark"></textarea> </td></tr> 
							<tr>
							<tr>
								<td colspan="4" align="center">
								<input type="submit" name="Submit" id="Submit" value="Submit Data" class="button"/>
								<b style="visibility: hidden;" id="wait_sub">
								<img id="progress_image" style="padding-left: 5px; padding-top: 5px;" src="images/loader.gif"/> 
								</b>
								</td> 
							</tr>
						</table> 
<%
}else{
%>
<table class="tftable" id="myForm">
<tr style="background-color: #eaf2ff;font-size:16px; font-weight: bold;text-align: center;">
<td colspan="4">
<hr />
New Customer / Vendor Creation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="New_VendCust.jsp">Reset</a>
<br />
<hr />
</td>
</tr> 
<tr><td  style="width:200px;">COMPANY</td><td colspan="3">
<select  id="company" name="company"  style="font-weight: bold;" onchange="updateCompany_Data(this.value)"> 
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='company_code' and enable=1 and code='"+company+"'");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
	<option value=""> - - - - - Select  - - - - - </option>
	<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='company_code' and enable=1 and code!='"+company+"'");
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
</td></tr>


<!-- <tr>
<td><b style="font-size: 13px;">Add New</b></td>
<td>
<select name="vendSupp" id="vendSupp" style="font-weight: bold;">
<option value="0"> - - - - - Select  - - - - - </option>
<option value="1">Vendor</option>
<option value="2">Customer</option> 
</select>
</td>
</tr> -->
<!-- <tr>
<td>Name (40 Characters)</td>
<td colspan="3"><input type="text" name="mat_name" id="mat_name" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"  onkeyup="this.value = this.value.toUpperCase();"/></td> 
</tr> --> 

<tr><td  style="width:200px;">Customer / Vendor For</td><td>
<select id="cust_vend" name="cust_vend" style="font-weight: bold;" onchange="check_PayTerms(this.value)">
<option value=""> - - - - - Select - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='BP_Group' and enable=1 and descr not in('INTER PLANT VENDOR')");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("descr").replace("VENDOR", "")%>"><%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr").replace("VENDOR", "")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select>
</td>
<%-- <td>ROLE</td><td>  
<select name="role" id="role"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
	<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='BP_Role' and enable=1");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select>
</td> --%> 
<td>Reason / Required For</td>
<td>
<textarea rows="1" cols="30" name="reason_for" id="reason_for" style="font-size: 15px;font-weight: bold;"></textarea>
</td>
</tr>

<tr> <td>NAME OF ORG</td><td colspan="3">
<input type="text" name="name_org" id="name_org" maxlength="80" style="width:400px;font-size: 15px;font-weight: bold;" onkeyup="checkFunction()"/> </td></tr>

<!-- <tr> <td>NAME ORG 2</td><td colspan="3"> <input type="text" name="name_org2"  id="name_org2"  maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr> -->
<tr> <td>SEARCH TERM</td><td colspan="3"> <input type="text" name="search_term" id="search_term"  maxlength="20" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
 
<tr><td>ADDRESS 1<br />(House / Floor / Building No)</td><td colspan="3"><input type="text" name="address1" id="address1" maxlength="10" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 2<br />(Street / Locality)</td><td colspan="3"><input type="text" name="address2" id="address2" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 3</td><td colspan="3"><input type="text" name="address3" id="address3" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 4</td><td colspan="3"><input type="text" name="address4" id="address4" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>

<tr><td>POSTAL CODE</td><td>
<input type="text" name="postal_code" id="postal_code" maxlength="6" style="width:100px;font-size: 15px;font-weight: bold;" style="cursor: text" onkeypress="return validatenumerics(event);"/>   </td><td>CITY</td><td> <input type="text" name="city" id="city" maxlength="20" style="width:100px;font-size: 15px;font-weight: bold;"/>
</td></tr>
<tr><td>COUNTRY</td><td>
<select name="country" id="country" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='country_code' and enable=1");
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
</td>
<td>REGION</td><td> 
<select name="region" id="region" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='CN_Region' and enable=1");
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
</td></tr>
<tr><td>LANGUAGE</td><td><strong>EN (English)</strong> <input  type="hidden" name="language" id="language"  value="EN"/></td> 
<td>SALES ORG</td><td>  
<select name="sales_org" id="sales_org" style="font-weight: bold;">

<%
		ps_mst = con.prepareStatement("SELECT DISTINCT code, descr FROM master_data where tablekey='sales_org' and code='"+company+"'  ORDER BY code");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("Code")%> - <%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
	<%-- <option value=""> - - - - - Select  - - - - - </option>
	<%
		ps_mst = con.prepareStatement("SELECT DISTINCT code, descr FROM master_data where tablekey='sales_org' and code!='"+company+"'  order by code");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("Code")%> - <%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%> --%>	
</select>
</td>  </tr>
<!-- <tr><td>VALID FROM</td><td><select name="valid from" id="valid_from" name="valid_from"  style="font-weight: bold;"></select></td><td>VALID TO</td><td> <input type="text" name="valid to" id="valid to"/></td></tr> -->
<!-- <tr><td>TAX TYPE</td><td><select name="tax type" id="tax_type" name="tax_type"  style="font-weight: bold;"></select></td><td>GST NO</td><td> <input type="text" name="gst_no" id="gst_no" maxlength="15" style="width:250px;font-size: 15px;font-weight: bold;"/></td></tr> -->

<!-- <tr><td>CUST REC. ACCT</td><td> <input type="text" name="cust_rec_acct" id="cust_rec_acct"/></td><td>VEND REC. ACCT</td><td><input type="text" name="vend_rec_acct" id="vend_rec_acct"/></td></tr> -->

<tr><td>DIST. CHANNEL</td><td>
<select name="dist_channel" id="dist_channel"  style="font-weight: bold;"> 
<%
String plant_check = company.substring(0,2) + "%"; 
		ps_mst = con.prepareStatement("SELECT distinct code, descr FROM master_data where tablekey='dist_channel' and enable=1 and plant like '"+plant_check+"'  order by code");
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
</td><td>DIVISION</td><td>
<select name="division" id="division"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='division' and enable=1 order by Plant");
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
</td></tr>


<tr><td>CURRENCY</td><td>
<select name="currency" id="currency" style="font-weight: bold;">
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='currency' and enable=1 order by Plant");
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

</td><td>SHIPPING COND.</td>
<td>
<select id="shipping_cond" name="shipping_cond"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='shipping_cond' and enable=1");
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
</td></tr>

<!-- <tr><td>VENDOR PAY TERM</td><td>
<input type="text" name="vendor_pay_term" id="vendor_pay_term" maxlength="20" style="font-weight: bold;"/></td>
<td>CUST PAY TERM</td><td> <input type="text" name="cust_pay_term" id="cust_pay_term" maxlength="20" style="font-weight: bold;"/></td></tr> -->

<tr>
<td>VENDOR PAY TERM</td><td colspan="3">
<span id="vendData">
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
</span>
</td>
</tr>
<tr>
<td>CUST PAY TERM</td><td colspan="3"> 
<span id="custData">
<select  id="cust_pay_term" name="cust_pay_term"  style="font-weight: bold;width:30%;">
<option value="0"> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='payment_term_cust' and enable=1 order by Plant");
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
</span>
</td></tr>






<tr><td>GST NO</td><td> <input type="text" name="gst_no" id="gst_no" maxlength="15" style="width:250px;font-size: 15px;font-weight: bold;"/></td>
<td>PURCHAGE GROUP</td>
<td colspan="3"><select  id="purchage_group" name="purchage_group" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='purchase_Group' and enable=1 order by Plant");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
	%>
		<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr")%></option>
	<%
		}
		ps_mst.close();
		rs_mst.close();
	%>
</select></td>
</tr>
<!-- <tr><td>SGST</td><td><input type="text" name="cgst" id="cgst"/></td><td>IGST</td><td> <input type="text" name="igst" id="igst"/></td></tr> -->
<tr><td>PURCHASE ORG.</td>
<td>
<select id="purchase_org" name="purchase_org"  style="font-weight: bold;"> 
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='purchase_org' and enable=1 and code='"+company+"'");
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
</td>
<td>VENDOR CURRENCY</td><td>  
<select name="vendor_currency" id="vendor_currency" style="font-weight: bold;">
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='currency' and enable=1 order by Plant");
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
</td></tr>


<tr><td>INCO TERM</td><td>  
<select id="inco_term" name="inco_term"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT *  FROM master_data where tablekey='inco_term' and enable=1 order by Plant");
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
</td>
<td>INCO TERM LOCATION</td><td>
<input  type="text" name="inco_location" id="inco_location" maxlength="20" style="font-weight: bold;"/></td>
</tr>
	
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Other Details</td>
							</tr> 
<tr><td>PAN NO</td><td> <input type="text" name="pan_no" id="pan_no" maxlength="10" style="width:250px;font-size: 15px;font-weight: bold;"/></td>
<td>Email ID</td><td> <input type="text" name="email" id="email" style="width:250px;font-size: 15px;font-weight: bold;"/></td></tr>				
<tr><td>Mobile NO</td><td> <input type="text" name="mobile_no" id="mobile_no" maxlength="10" style="width:250px;font-size: 15px;font-weight: bold;" onkeypress="return validatenumerics(event);"/></td>
<td>Remark / Details</td><td><textarea rows="1" cols="30" name="remark" id="remark"></textarea> </td></tr> 
							<tr>
							<tr>
								<td colspan="4" align="center">
								<input type="submit" name="Submit" id="Submit" value="Submit Data" class="button"/>
								<b style="visibility: hidden;" id="wait_sub">
								<img id="progress_image" style="padding-left: 5px; padding-top: 5px;" src="images/loader.gif"/> 
								</b>
								</td> 
							</tr>
						</table> 
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