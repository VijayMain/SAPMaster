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
<title>Add New Vendor</title>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/style1.css" />
<link rel="stylesheet" type="text/css" href="css/style2.css" />
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
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: black;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: black;
}

.tftable {
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
	font-size: 12px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
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
$(function() {
    $( "#revision_date").datepicker({
      changeMonth: true,
      changeYear: true
    });
    $( "#vat_tindate").datepicker({
	      changeMonth: true,
	      changeYear: true
	    });
    $( "#ssi_date").datepicker({
	      changeMonth: true,
	      changeYear: true
	    }); 
  }); 
</script>
<script language="javascript">
/* 	function CheckMasterValidation() { 
		var typeMat = document.getElementById("typeMat").value;	 
		if (typeMat != "") {
			document.getElementById("material_type").value = typeMat;
		 
			var form = document.getElementById("formData");
			form.reset(); 
		 
			var val = typeMat;
			var sel = document.getElementById("typeMat");
			
			  var opts = sel.options;
			  for (var opt, j = 0; opt = opts[j]; j++) {
			    if (opt.value == val) {
			      sel.selectedIndex = j;
			      break;
			    };
			  };
			document.getElementById("myForm").style.visibility = "visible"; 
		}else{
			alert("Please Provide Material Type !!!");
			document.getElementById("myForm").style.visibility = "hidden";
		}
	}  */
	
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
		
	
	function ValidationForm() {
		var company = document.getElementById("company");
		var cust_vend = document.getElementById("cust_vend");
		var reason_for = document.getElementById("reason_for");		
		var name_org = document.getElementById("name_org");		
		var search_term  = document.getElementById("search_term");		
		var address1  = document.getElementById("address1");		
		var postal_code = document.getElementById("postal_code");
		var city = document.getElementById("city");
		var country = document.getElementById("country");
		var region = document.getElementById("region");  
		var vendor_pay_term  = document.getElementById("vendor_pay_term");
		var cust_pay_term   = document.getElementById("cust_pay_term");		
		var gst_no = document.getElementById("gst_no");  
		var purchage_group = document.getElementById("purchage_group");   
		var pan_no = document.getElementById("pan_no");   
		var email = document.getElementById("email");    
		var mobile_no = document.getElementById("mobile_no");
		
		if (company.value == "") {
			alert("Please Provide COMPANY !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (cust_vend.value == "") {
			alert("Please Provide Customer / Vendor For !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (reason_for.value == "") {
			alert("Please Provide Reason / Required For !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (name_org.value == "") {
			alert("Please Provide NAME OF ORG !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (search_term.value == "") {
			alert("Please Provide SEARCH TERM !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (address1.value == "") {
			alert("Please Provide Address1 !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}		
		if (postal_code.value == "") {
			alert("Please Provide POSTAL CODE !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (city.value == "") {
			alert("Please Provide City !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (country.value == "") {
			alert("Please Provide Country !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (region.value == "") {
			alert("Please Provide Region !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		
		 if (vendor_pay_term.value == "0") {
			alert("Please Provide Vendor Pay Term !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		if (cust_pay_term.value == "0") {
			alert("Please Provide Customer Pay Term !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		} 
		
		
		if (gst_no.value == "") {
			alert("Please Provide GST No !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}		
		if (purchage_group.value == "") {
			alert("Please Provide PURCHAGE GROUP !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;
		}
		if (pan_no.value == "") {
			alert("Please Provide PAN No !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;
		}
		if (email.value == "") {
			alert("Please Provide Email ID !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;
		}
		if (mobile_no.value == "") {
			alert("Please Provide Mobile No !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;
		}
		document.getElementById("Submit").disabled = true;
		document.getElementById("wait_sub").style.visibility = "visible"; 
	}
	
	function updateCompany_Data(str) {
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
					document.getElementById("company_data").innerHTML = xmlhttp.responseText; 
				}
			};
			xmlhttp.open("POST", "GetVendCustComp_Data.jsp?q=" + str , true);   
			xmlhttp.send();
	};
	
	function check_PayTerms(str) {
		var xmlhttp, xmlhttp1;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
			xmlhttp1 = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("custData").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp1.onreadystatechange = function() {
			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
				document.getElementById("vendData").innerHTML = xmlhttp1.responseText;
			}
		};
		xmlhttp.open("POST", "CustPayTermsAjax.jsp?q=" + str , true);			
		xmlhttp.send();	
		xmlhttp1.open("POST", "VendPayTermsAjax.jsp?r=" + str , true);
		xmlhttp1.send();
};
</script>
<style type="text/css">
.tftable {
	font-family: Arial;
	font-size: 12px;
	color: #333333;
	width: 100%;
}

.tftable tr {
	background-color: white;
	font-size: 13px;
}

.tftable td {
	font-size: 12px;
	font-family: Arial;
	padding: 3px;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style4 {
	font-size: 12px
}

.style5 {
	font-weight: bold;
	font-size: 12px;
}

.style6 {
	color: #FF0000
}
</style>
</head>
<body>
	<%
		try {
			Connection con = Connection_Utility.getConnectionMaster();
			/* int uid = Integer.parseInt(session.getAttribute("uid").toString()),
			d_Id = Integer.parseInt(session.getAttribute("dept_id").toString());
			String uname = session.getAttribute("username").toString(); 
			 */
			PreparedStatement ps_mst = null;
			ResultSet rs_mst = null;
	%>
	<div id="container">
		<div id="content" style="width : 110%;">
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!-------------------------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
<%@include file="Header.jsp" %>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->			
			<div id="main">
				<%
					if (request.getParameter("success") != null) {
				%>
				<script type="text/javascript">alert("<%=request.getParameter("success")%>");
				</script>
				<%
					}				
				/* String nname = "918092309812094812048028409128409209";
				System.out.println("Nname = " + nname.substring(0, 5) + " = " + nname.substring(5, 12)); */				
				%>
				<div style="width: 70%; float: left;">	
				<form action="NewCustVend_CreationControl" method="post" onsubmit="return ValidationForm();" id="formData">
<!-- 	<hr />				
		<strong>Material Master Creation </strong>&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;<a href="New_VendCust.jsp"><b>Reset</b></a>
		<br />
<hr />  	 -->
<span id=company_data>
<table class="tftable" id="myForm">
<tr style="background-color: #eaf2ff;font-size:16px; font-weight: bold;text-align: center;">
<td colspan="4">
<hr />
New Customer / Vendor Creation &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="New_VendCust.jsp">Reset</a>
<br />
<hr />
</td>
</tr>
<tr><td style="width:200px;">COMPANY</td><td colspan="3">
<select   id="company" name="company"  style="font-weight: bold;" onchange="updateCompany_Data(this.value)">
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
<tr><td  style="width:200px;">Customer / Vendor For</td><td>
<select id="cust_vend" name="cust_vend"  style="font-weight: bold;" onchange="check_PayTerms(this.value)">
<option value=""> - - - - - Select - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT  *  FROM master_data where tablekey='BP_Group' and enable=1 and descr not in('INTER PLANT VENDOR')");
		rs_mst = ps_mst.executeQuery();
		while(rs_mst.next()){
%>
		<option value="<%=rs_mst.getString("descr").replace("VENDOR", "") %>"><%=rs_mst.getString("code")%> - <%=rs_mst.getString("descr").replace("VENDOR", "") %></option>
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
<td  style="width:200px;">Reason / Required For</td>
<td>
<textarea rows="1" cols="30" name="reason_for" id="reason_for" style="font-size: 15px;font-weight: bold;"></textarea>
</td>
</tr>
<tr><td>NAME OF ORG</td><td colspan="3"> <input type="text" name="name_org" id="name_org" maxlength="80" style="width:400px;font-size: 15px;font-weight: bold;" onkeyup="checkFunction()"/></td></tr>

<!-- <tr> <td>NAME ORG 2</td><td colspan="3"> <input type="text" name="name_org2"  id="name_org2"  maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr> -->

<tr> <td>SEARCH TERM</td><td colspan="3"> <input type="text" name="search_term" id="search_term"  maxlength="20" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
 
<tr><td>ADDRESS 1<br />(House / Floor / Building No)</td><td colspan="3"><input type="text" name="address1" id="address1" maxlength="10" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 2<br />(Street / Locality)</td><td colspan="3"><input type="text" name="address2" id="address2" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 3</td><td colspan="3"><input type="text" name="address3" id="address3" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>
<tr><td>ADDRESS 4</td><td colspan="3"><input type="text" name="address4" id="address4" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td></tr>

<tr><td>POSTAL CODE</td><td>
<input type="text" name="postal_code" id="postal_code" maxlength="6" style="width:100px;font-size: 15px;font-weight: bold;" style="cursor: text" onkeypress="return validatenumerics(event);"/>   </td>
<td>CITY</td><td> <input type="text" name="city" id="city" maxlength="20" style="width:100px;font-size: 15px;font-weight: bold;"/>
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
<tr><td>LANGUAGE</td><td><strong>EN (English)</strong> <input  type="hidden" name="language" id="language"  value="EN"/> </td> 
<td>SALES ORG</td><td>  
<select name="sales_org" id="sales_org" style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT DISTINCT code, descr FROM master_data where tablekey='sales_org'  ORDER BY code");
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



<!-- <tr><td>CUST REC. ACCT</td><td> <input type="text" name="cust_rec_acct" id="cust_rec_acct"/></td><td>VEND REC. ACCT</td><td><input type="text" name="vend_rec_acct" id="vend_rec_acct"/></td></tr> -->

<tr><td>DIST. CHANNEL</td><td>
<select name="dist_channel" id="dist_channel"  style="font-weight: bold;">
<option value=""> - - - - - Select  - - - - - </option>
<%
		ps_mst = con.prepareStatement("SELECT DISTINCT code, descr  FROM master_data where tablekey='dist_channel' and enable=1 ORDER BY code");
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

<tr>
<td>VENDOR PAY TERM</td><td colspan="3">
<span id="vendData"></span>
<select  id="vendor_pay_term" name="vendor_pay_term" style="font-weight: bold;width:30%;">
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

</td>
</tr>
<tr>
<td>CUST PAY TERM</td><td colspan="3"> 
<span id="custData">
<select  id="cust_pay_term" name="cust_pay_term" style="font-weight: bold;width:30%;">
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

<!-- <tr><td>TAX TYPE</td><td><select name="tax type" id="tax_type" name="tax_type"  style="font-weight: bold;"></select></td><td>GST NO</td><td> <input type="text" name="gst_no" id="gst_no" maxlength="15" style="width:250px;font-size: 15px;font-weight: bold;"/></td></tr> -->


<tr>
<td>GST NO</td><td> <input type="text" name="gst_no" id="gst_no" maxlength="15" style="width:250px;font-size: 15px;font-weight: bold;"/></td>
<td>PURCHAGE GROUP</td>
<td colspan="3">
<select  id="purchage_group" name="purchage_group" style="font-weight: bold;">
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
</select>
</td></tr>
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
</td><td>INCO TERM LOCATION</td><td>
<input  type="text" name="inco_location" id="inco_location" maxlength="20" style="font-weight: bold;"/></td></tr>
<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
<td colspan="4">Other Details</td></tr>
<tr><td>PAN NO</td><td> <input type="text" name="pan_no" id="pan_no" maxlength="10" style="width:250px;font-size: 15px;font-weight: bold;"/></td>
<td>Email ID</td><td> <input type="text" name="email" id="email" style="width:250px;font-size: 15px;font-weight: bold;"/></td></tr>				
<tr><td>Mobile NO</td><td> <input type="text" name="mobile_no" id="mobile_no" maxlength="10" style="width:250px;font-size: 15px;font-weight: bold;" onkeypress="return validatenumerics(event);"/></td>
<td>Remark / Details</td><td><textarea rows="1" cols="30" name="remark" id="remark"></textarea> </td></tr>
							<tr>
								<td colspan="4" align="center">
								<input type="submit" name="Submit" id="Submit" value="Submit Data" class="button"/>
								<b style="visibility: hidden;" id="wait_sub">
								<img id="progress_image" style="padding-left: 5px; padding-top: 5px;" src="images/loader.gif"/> 
								</b>
								</td> 
							</tr>
						</table> 
						</span>
					</form>
				</div>
				<div style="width: 29%; float: right;">
				<div  id="already_avail" style="height : 600px;overflow : scroll;">
					<table class="tftable">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold; text-align: center;"> 
								<td>Already Available Name of Org.</td> 
							</tr>
					</table>		
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer"
		style="width: 900px; margin: 0 auto; background: #FFFFFF;">
		<a href="http://www.muthagroup.com/"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp; <strong>Mail to :</strong>&nbsp; 
		<a href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top" style="color: blue;">itsupports@muthagroup.com</a>
		&nbsp; 
	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>