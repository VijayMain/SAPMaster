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
	function CheckMasterValidation() {
		var typeMat = document.getElementById("typeMat").value; 
		
		if (typeMat != "") {
			document.getElementById("material_type").value = typeMat;
			/* alert(document.getElementById("material_type").value);  */
			var form = document.getElementById("formData");
			form.reset(); 
			/* Selected Select Option check*/
			var val = typeMat;
			var sel = document.getElementById("typeMat");
			
			  var opts = sel.options;
			  for (var opt, j = 0; opt = opts[j]; j++) {
			    if (opt.value == val) {
			      sel.selectedIndex = j;
			      break;
			    };
			  };
			/**************************************************************************/
			/* alert(document.getElementById("material_type").value); */
			document.getElementById("myForm").style.visibility = "visible"; 
			
		}else{
			alert("Please Provide Material Type !!!");
			document.getElementById("myForm").style.visibility = "hidden";
		}
	}
	
	function ValidationForm() {
		var material_type = document.getElementById("typeMat");
		var mat_name = document.getElementById("mat_name");
		if (material_type.value == "") {
			alert("Please Provide Material Type !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;
		}
		if (mat_name.value == "") {
			alert("Please Provide Material Name !!!");
			document.getElementById("Submit").disabled = false;
			document.getElementById("wait_sub").style.visibility = "hidden";
			return false;  
		}
		document.getElementById("Submit").disabled = true;
		document.getElementById("wait_sub").style.visibility = "visible"; 
	}
	
	function alreadyavailCheck() {
		var str = document.getElementById("mat_name").value;  
		
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
			xmlhttp.open("POST", "GetAvailableMaster.jsp?q=" + str , true);   
			xmlhttp.send();		
	};
	
	function updatePlant_Data(str) {
		var typeMat = document.getElementById("typeMat").value; 
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
					document.getElementById("plant_data").innerHTML = xmlhttp.responseText; 
				}
			};
			xmlhttp.open("POST", "GetPlant_Data.jsp?q=" + str +"&p=" + typeMat, true);
			xmlhttp.send();
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
		<div id="content" style="width : 110%;height : 600px;overflow : scroll;">
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
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
				%>
				<div style="width: 70%; float: left;"> 
				<hr />
				<form action="NewMaster_CreationControl" method="post" onsubmit="return ValidationForm();" id="formData">
				<input type="hidden" name="editedData" id="editedData" value="0"/>				
				
				<strong style="font-family: Arial; font-size: 16px; color: #10006E;">&nbsp;&nbsp;Material Master Creation for </strong>
					<select name="typeMat" id="typeMat" onchange="CheckMasterValidation()">
					<option value=""> - - - - - Select  - - - - - </option>
					    <%
						ps_mst = con.prepareStatement("select * from importfor where enable=1 order by code");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){		
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%>&nbsp;&nbsp;<%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
					</select>
					&nbsp;<a href="New_Master.jsp"><b>Reset</b></a>
					
				<br />
				<hr /> 
				<span id=plant_data>
						<table class="tftable" id="myForm_hide" style="visibility: hidden;">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Basic Data<input type="hidden" name="material_type" id="material_type"/></td>
							</tr>
							<tr>
								<td>Plant</td>
								<td><select name="plant" id="plant" onchange="updatePlant_Data(this.value)">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("SELECT * FROM master_data where tablekey  like '%plan%' and plant!=''");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>					
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select></td>
							</tr>
							<tr>
								<td>Material Name (40 Characters)</td>
								<td colspan="3"><input type="text" name="mat_name" id="mat_name" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"  onkeyup="alreadyavailCheck()"/></td> 
							</tr>

							<tr>
								<td>OLD MATERIAL NUMBER</td>
								<td><input type="text" name="oldMaterialNo"
									id="oldMaterialNo" /></td>
								<td>INDUSTRY SECTOR</td>
								<td>
								<select name="ind_sector" id="ind_sector">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='ind_sector'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>					
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>			
						</select>		
								</td>
							</tr>

							<tr>
								<td>Net Wt.</td>
								<td><input type="text" name="netWt" id="netWt" /></td>
								<td>Base Unit of Measure</td>
								<td>
								<select name="baseUOM" id="baseUOM">
								<option value="KG">KG Kilogram</option>
								<option value=""> - - - - - Select  - - - - - </option> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='baseUOM'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>					
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select>
								</td>
							</tr>
							<tr>
								<td>Weight unit</td>
						<td>
						<select name="wtUnit" id="wtUnit">
						<option value="KG">KG Kilogram</option>	 
						</select>
						</td>
								<td>Material Group</td>
								<td>
								<select name="matGroup" id="matGroup">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='matGroup'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>					
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select></td>
							</tr>

							<tr>
								<td>Size/dimensions</td>
								<td><input type="text" name="size_dim" id="size_dim" />
								</td>
								<td>Ext. Matl Group</td>
								<td>
								<select name="ext_matGroup" id="ext_matGroup">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='ext_matGroup'");
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
								</td>
							</tr>
							<tr>
								<td>STORAGE LOCATION</td>
								<td>
						<select name="storage_loc" id="storage_loc">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='storage_loc'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>					
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select>
								</td>
								<td>Division</td>
								<td>
						<select name="division" id="division">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='division'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>					
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
							</tr>

							<tr>
								<td>GenItemCatGroup</td>
								<td><input type="text" name="genItemCatGroup" id="genItemCatGroup" value="NORM" /></td>
								<td>Gross Wt.</td>
								<td><input type="text" name="gross_wt" id="gross_wt" />
								</td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Sales: Sales Org. 1</td> 
							</tr>
							<tr>
								<td>Sales Org.</td>
								<td>
						<select name="sales_org" id="sales_org">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='sales_org'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>											
						</select></td>
								<td>Central GST - JOCG</td>
								<td>
						<select name="jocg" id="jocg">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='jocg'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>	
								</select>
								</td>
							</tr>

							<tr>
								<td>Distr. Chl</td>
								<td>
						<select name="dist_channel" id="dist_channel">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='dist_channel'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("Plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>	
						</select></td>
						<td>State GST - JOSG</td>
						<td>
						<select name="josg" id="josg">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='josg'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select>
						</td>
						</tr>
						<tr>
						<td>Sales unit</td>
						<td>
						<select name="sale_unit" id="sale_unit">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='sale_unit'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
							</select>
							</td>
								<td>Integrated GST - JOIG</td>
								<td>
						<select name="joig" id="joig">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='joig'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){							
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select>
								</td>
							</tr>

							<tr
								style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Sales: Sales Org. 2</td> 
							</tr>
							<tr>
								<td>Acct assignment grp</td>
								<td>
						<select name="acct_assgnGroup" id="acct_assgnGroup">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='acct_assgnGroup'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){					
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
						<td>Material Group 1</td>
						<td>
						<select name="mat_grp1" id="mat_grp1">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mat_grp1'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
							</tr> 
							<tr>
								<td>Item category group</td>
								<td>
								<select name="itemCatGroup" id="itemCatGroup">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='itemCatGroup'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select></td>
								<td>Material Group 2</td>
								<td>
								<select name="mat_grp2" id="mat_grp2">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mat_grp2'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select></td>
							</tr>

							<tr
								style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Sales: General/Plant</td> 
							</tr>
							<tr>
								<td>Availability check</td>
								<td>
								<select name="availability_chk" id="availability_chk">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='availability_chk'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
						<td>LoadingGrp</td>
						<td>
						<select name="load_group" id="load_group">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='load_group'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
							</tr>
						<tr>
						<td>Trans. Grp</td>
						<td>
						<select name="trans_group" id="trans_group">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='trans_group'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
						<td>Profit Center</td>
						<td>
						<select name="profitCenter" id="profitCenter">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='profitCenter'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
						</tr>
						<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
							<td colspan="4">Intl Trade: Export</td> 
						</tr>
							<tr>
								<td>HSN : Control code</td>
								<td>
								<input  type="text" name="controlCode" id="controlCode"/> 
								
						<%-- <select name="controlCode" id="controlCode">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='controlCode'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select> --%> 
							</td>
								<td></td>
								<td></td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Purchasing</td> 
							</tr>
							<tr>
								<td>Purchasing Group</td>
								<td>
								<select name="purchase_Group" id="purchase_Group">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='purchase_Group'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>		
						</select></td>
						<td>Purchasing value key</td>
						<td>
						<select name="pur_valueKey" id="pur_valueKey">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='pur_valueKey'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>		
						</select></td>
						</tr>
							<tr>
								<td>Tax ind. f. Material</td>
								<td><input type="text" name="tax_ind" id="tax_ind" /></td>
								<td>GR processing time</td>
								<td><input type="text" name="gr_processingTime" id="gr_processingTime" /></td>
							</tr>

							<tr
								style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">MRP 1</td> 
							</tr>
							<tr>
								<td>MRP Type</td>
								<td>
						<select name="mrpType" id="mrpType">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mrpType'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>	
						</select></td>
						<td>Lot Sizing Procedure</td>
						<td>
						<select name="lotSizing_proc" id="lotSizing_proc">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='lotSizing_proc'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
						</tr> 
							<tr>
								<td>MRP Group</td>
								<td><input type="text" name="mrp_group"
									id="mrp_group" /></td>
								<td>Minimum Lot Size</td>
								<td><input type="text" name="min_LotSize"
									id="min_LotSize" /></td>
							</tr>

							<tr>
								<td>Reorder Point</td>
								<td><input type="text" name="reorderPoint"
									id="reorderPoint" /></td>
								<td>Maximum Lot Size</td>
								<td><input type="text" name="max_LotSize"
									id="max_LotSize" /></td>
							</tr>

							<tr>
								<td>ABC INDICATOR</td>
								<td>
								<select name="abc_indicator" id="abc_indicator">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='abc_indicator'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select></td>
								<td>FIX LOT</td>
								<td><input type="text" name="fixLot" id="fixLot" /></td>
							</tr>
						<tr>
						<td>MRP CONTROLLER</td>
						<td>
						<select name="mrp_Controller" id="mrp_Controller">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mrp_Controller'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
								<td>Maximum stock level</td>
								<td><input type="text" name="MaxStocklevel" id="MaxStocklevel" /></td>
							</tr>

							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">MRP 2</td> 
							</tr>
							<tr>
						<td>Procurement type</td>
						<td>
						<select name="procure_type" id="procure_type">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='procure_type'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
								<td>Planned Deliv. Time</td>
								<td><input type="text" name="plan_delTime"
									id="plan_delTime" /></td>
							</tr>

							<tr>
								<td>Special procurement</td>
								<td>
								<select name="specialProc" id="specialProc">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='specialProc'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select></td>
								<td>SchedMargin key</td>
								<td> 
								<select name="schMrg_Key" id="schMrg_Key">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='schMrg_Key'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>		
						</select> 
								</td>
							</tr>
							<tr>
								<td>Prod. stor. location</td>
								<td>
								<select name="prod_StorageLoc" id="prod_StorageLoc">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='storage_loc'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>		
						</select></td>
						<td>Backflush</td>
						<td>
						<select name="backflush" id="backflush"> 
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='backflush'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select>
						</td>
							</tr>

							<tr>
								<td>Min safety stock</td>
								<td><input type="text" name="minSafetyStock" id="minSafetyStock" /></td>
								<td>Safety stock</td>
								<td><input type="text" name="safety_stk" id="safety_stk" /></td>
							</tr>
							<tr>
								<td>In-house production</td>
								<td><input type="text" name="inhouseProduction" id="inhouseProduction" /></td>
								<td></td>
								<td></td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">MRP 3</td> 
							</tr>
							<tr>
								<td>Strategy Group</td>
						<td>
						<select name="strategy_grp" id="strategy_grp">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='strategy_grp'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
								<td></td>
								<td></td>
							</tr>
							<tr
								style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Work Scheduling</td> 
							</tr>
							<tr>
						<td>Production Supervisor</td>
						<td>
						<select name="prod_supervisor" id="prod_supervisor">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_supervisor'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
								<td><!-- Batch mag requ indicator --></td>
								<td>
								<input type="checkbox" name="batch_indicator" id="batch_indicator" value="X" style="visibility: hidden;"/> </td>
							</tr>

							<tr>
								<td>Production Scheduling Profile</td>
								<td>
						<select name="prod_schedProfile" id="prod_schedProfile">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_schedProfile'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
								<td></td>
								<td></td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Plant data / stor. 1</td> 
							</tr>
							<tr>
								<td>Minimum Remaining Shelf Life</td>
								<td><input type="text" name="minRemain_ShelfLife" id="minRemain_ShelfLife" /></td>
								<td>Total shelf life</td>
								<td><input type="text" name="tot_shelfLife"
									id="tot_shelfLife" /></td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Quality Management</td> 
							</tr>
							<tr>
								<td>INSPECTION SETUP TICK</td>
								<td><input type="checkbox" name="insp_setupTick" id="insp_setupTick" value="X"/> </td>
								<td><!-- QM PROC. ACTIVE --></td>
								<td>
								<input type="checkbox" name="qm_ProcActive" id="qm_ProcActive" value="X" style="visibility: hidden;"/></td>
							</tr>
							<tr>
								<td>QM CONTROL KEY</td>
								<td colspan="3">
								<select name="qm_controlKey" id="qm_controlKey">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='qm_controlKey'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
								</select>
								</td>
							</tr> 
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Accounting 1</td> 
							</tr>
							<tr>
						<td>VALUATION CLASS</td>
						<td>
						<select name="valueation_class" id="valueation_class">
						<option value=""> - - - - - Select  - - - - - </option> 
						<% 
						ps_mst = con.prepareStatement("select * from master_data where tablekey='valueation_class'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
								<td>MOVING PRICE</td>
								<td><input type="text" name="moveing_price" id="moveing_price" /></td>
							</tr>
						<tr>
						<td>PRICE CONTROL</td>
						<td>
						<select name="price_control" id="price_control">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='price_control'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select></td>
								<td>WITH QTY STRUCTURE</td>
								<td><input type="text" name="withQty_structure" id="withQty_structure" /></td>
							</tr>
						<tr>
						<td><!-- PRICE UNIT -->OVERHEAD GROUP</td>
						<td>
						<input type="text" name="overhead_group" id="overhead_group" />
						<input type="text" name="price_unit" id="price_unit" value="1" style="visibility : hidden"/>
						<%-- <select name="price_unit" id="price_unit">
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='price_unit'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						</select> --%>
								
						</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>STANDARD PRICE</td>
								<td><input type="text" name="standardPrice" id="standardPrice" /></td>
								<td></td>
								<td></td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Remark / Details / Required for</td>
							</tr>
							<tr>
								<td>Remark / Details</td>
								<td colspan="3"><textarea rows="2" cols="50" name="remark" id="remark"></textarea> </td> 
							</tr>
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
								<td>Material Descr.</td>
								<td>Plant</td>
								<td>Division</td>
								<td>Material No</td>
							</tr>
							<!-- <tr style="font-size: 10px;">
								<td style="text-align: Center">Material No</td>
								<td>Material Descr.</td>
								<td style="text-align: right">Plant</td>
								<td style="text-align: right">Division</td>
							</tr> -->
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