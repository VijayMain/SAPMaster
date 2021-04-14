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
	function ValidationEvent() {				
	 	/* var fileType = document.getElementById("fileType");		 */        
	 	var masterFile = document.getElementById("masterFile");		        
		/* if (fileType.value == "") {
			alert("Please Provide Import Material Master For !!!");
			document.getElementById("importData").disabled = false; 
			return false;
		} */
		if (masterFile.value == "") {
			alert("Please Provide Import Master File !!!");
			document.getElementById("importData").disabled = false; 
			return false;
		}
		document.getElementById("Submit").disabled = true; 
	}
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
			Connection conMaster = Connection_Utility.getConnectionMaster();  
	%>
	<div id="container">
		<div id="content">
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
<%@include file="Header.jsp" %>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->		
   
			<div style="text-align: center;">
				<hr />
				<b>Master Upload Utility for SAP</b>
				<br />
				<hr />
			</div>			
			<div id="main" style="height: 500px;">
				<%
					if (request.getParameter("success") != null) {
				%>
				<script type="text/javascript">alert("<%=request.getParameter("success")%>"); </script>
				<%
					}
				%>
				<div style="width: 60%; float: left;height: 100%;">
					<form action="Import_MasterDataControl" method="post" enctype="multipart/form-data" onsubmit="return ValidationEvent()">
						<table class="tftable">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Master Header Upload</td>
							</tr>
							<tr>
								<td>Import Data</td>
								<td colspan="3">
									<select id="datafor" name="datafor" style=" font-weight: bold;">
										<option value="">- - - - - Select - - - - - </option> 
										<option value="1">Data Template Upload</option>
										<option value="2">Master Upload</option> 
									</select>
								</td>
							</tr> 
							<tr>
								<td>Import File</td>
								<td colspan="3"><input type="file" name="masterFile" id="masterFile" /></td>
							</tr>  							
							<tr> 
								<td colspan="4" align="center">
								<input type="submit" name="submit" id="importData" value="Import Data" class="button"/> 
								</td> 
							</tr>

						</table>
					</form> 
				</div>
				<div style="width: 39%; float: right; height: 100%;overflow: scroll;">
					<table class="tftable">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td>Code</td>
								<td>Description</td>
								<td>Plant</td>
								<td>Index</td>
							</tr>
								<%
								String plant="";
								PreparedStatement ps_fileType= conMaster.prepareStatement("select * from master_data where enable=1 order by plant desc");
								ResultSet rs_fileType = ps_fileType.executeQuery();
								while(rs_fileType.next()){
								%> 
								<tr>
								<td><%=rs_fileType.getString("code")%></td>
								<td><%=rs_fileType.getString("descr")%></td>
								<%
								plant = rs_fileType.getString("plant");
								if(plant=="" || plant =="null"){
								%>
								<td>For All Plant</td>
								<%
								}else{
								%>
								<td><%=rs_fileType.getString("plant")%></td>
								<%	
								}
								%> 
								<td><%=rs_fileType.getString("tablekey")%></td>
								</tr>
								<%
								plant="";
								}
								%>
					</table>		
				</div>
			</div>
		</div>
	</div>
	<!-- <div id="footer" style="width: 900px; margin: 0 auto; background: #FFFFFF;">
		<a href="http://www.muthagroup.com/"><strong>Mutha Group
				of Foundries</strong> </a> &nbsp; | &nbsp; <strong>Mail to :</strong>&nbsp; <a
			href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance"
			target="_top" style="color: blue;">itsupports@muthagroup.com</a>
		&nbsp; </strong>
	</div> -->
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>