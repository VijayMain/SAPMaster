<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX</title>
</head>
<body>
<span id="selectData">
<%
try{
Connection con =  Connection_Utility.getConnectionMaster();

String id = request.getParameter("q");
String matType = request.getParameter("p");
String userId = request.getParameter("r");
String plant = request.getParameter("plant");


PreparedStatement ps_mst = null, ps_check =null;
ResultSet rs_mst = null,rs_check =null; 
ps_check = con.prepareStatement("select * from sap_mastertran where id="+id);
rs_check = ps_check.executeQuery();
while(rs_check.next()){
%>
<span id="selectData">
  <input type="hidden" name="hid" id="hid" value="<%= rs_check.getString("id")%>"/>
  <input type="hidden" name="userId" id="userId" value="<%= userId%>"/>
 <table class="tftable"  id="myForm">
 <tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
		<td colspan="4">
		<strong style="font-family: Arial; font-size: 16px; color: #10006E;">&nbsp;&nbsp;Material Master Creation for </strong>
			<select name="typeMat" id="typeMat"  onchange="CheckMasterValidation()"> 
					    <%
						ps_mst = con.prepareStatement("select * from importfor where enable=1 and code='"+matType+"' union all select * from importfor where enable=1 and code!='"+matType+"'");
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
							</td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Basic Data
								<%-- <input type="hidden" name="material_type" id="material_type" value="<%=rs_check.getString("material_type")%>"/> --%>
								</td>
							</tr>
							<tr>
						<td>Plant</td><td>
						<select name="plant" id="plant" onchange="CheckMasterValidation()"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='plant'  and plant='"+plant+
						"' union all select * from master_data where tablekey='plant'  and plant!='"+plant+"'");
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
								<td colspan="3"><input type="text" value="<%=rs_check.getString("mat_name")%>" name="mat_name" id="mat_name" maxlength="40" style="width:400px;font-size: 15px;font-weight: bold;"/></td> 
							</tr>

							<tr>
								<td>OLD MATERIAL NUMBER</td>
								<td><input type="text" name="oldMaterialNo" id="oldMaterialNo" value="<%=rs_check.getString("oldMaterialNo")%>"/></td>
								<td>INDUSTRY SECTOR</td>
								<td>
								<select name="ind_sector" id="ind_sector">
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='ind_sector' and code='M'");
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
								<td><input type="text" name="netWt" id="netWt" value="<%=rs_check.getString("netWt")%>"/></td>
								<td>Base Unit of Measure</td>
								<td>
								<select name="baseUOM" id="baseUOM">
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='baseUOM' and code='" + rs_check.getString("baseUOM")+"' union all select * from master_data where tablekey='baseUOM' and code!='" + rs_check.getString("baseUOM")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='matGroup' and code='"+rs_check.getString("matGroup")+"' union all select * from master_data where tablekey='matGroup' and code!='"+rs_check.getString("matGroup")+"'");
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
								<td><input type="text" name="size_dim" id="size_dim" value="<%=rs_check.getString("size_dim")%>"/>
								</td>
								<td>Ext. Matl Group</td>
								<td>
								<select name="ext_matGroup" id="ext_matGroup">
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='ext_matGroup' and code='" + rs_check.getString("ext_matGroup") +"' union all select * from master_data where tablekey='ext_matGroup' and code!='"+rs_check.getString("ext_matGroup")+"'");
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
						<%
						ps_mst = con.prepareStatement("select distinct code, descr from master_data where tablekey='storage_loc' and code='"+rs_check.getString("storage_loc")+"' union all select distinct code, descr from master_data where tablekey='storage_loc' and code!='"+rs_check.getString("storage_loc")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='division' and code='" + rs_check.getString("division") +"' union all select * from master_data where tablekey='division' and code!='" + rs_check.getString("division") +"'");
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
								<td><input type="text" name="genItemCatGroup" id="genItemCatGroup" value="NORM" value="<%=rs_check.getString("genItemCatGroup")%>"/></td>
								<td>Gross Wt.</td>
								<td><input type="text" name="gross_wt" id="gross_wt" value="<%=rs_check.getString("gross_wt")%>" />
								</td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Sales: Sales Org. 1</td> 
							</tr>
							<tr>
								<td>Sales Org.</td>
								<td>
						<select name="sales_org" id="sales_org">
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='sales_org'  and plant='"+plant+"'");
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
								<td>Central GST - JOCG</td>
								<td>
						<select name="jocg" id="jocg"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='jocg' and code ='" + rs_check.getString("jocg") + "' union all select * from master_data where tablekey='jocg' and code !='" + rs_check.getString("jocg") + "'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='dist_channel' and plant='"+plant+"' and code='" + rs_check.getString("dist_channel") + "' union all select * from master_data where tablekey='dist_channel' and plant='"+plant+"' and code!='" + rs_check.getString("dist_channel") +"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='josg' and code ='" + rs_check.getString("josg")+"' union all select * from master_data where tablekey='josg' and code !='" + rs_check.getString("josg") +"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='sale_unit' and code='"+rs_check.getString("sale_unit")+"' union all select * from master_data where tablekey='sale_unit' and code!='"+rs_check.getString("sale_unit")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='joig' and code='"+rs_check.getString("joig")+"' union all select * from master_data where tablekey='joig' and code!='"+rs_check.getString("joig")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='acct_assgnGroup' and code='" +rs_check.getString("acct_assgnGroup")+"' union all select * from master_data where tablekey='acct_assgnGroup' and code!='" +rs_check.getString("acct_assgnGroup") +"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mat_grp1' and code='"+rs_check.getString("mat_grp1")+"' union all select * from master_data where tablekey='mat_grp1' and code!='"+rs_check.getString("mat_grp1") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						</select></td>
							</tr> 
							<tr>
								<td>Item category group</td>
								<td>
								<select name="itemCatGroup" id="itemCatGroup">
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='itemCatGroup' and code='" + rs_check.getString("itemCatGroup") +"' union all select * from master_data where tablekey='itemCatGroup' and code!='" + rs_check.getString("itemCatGroup")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mat_grp2' and code ='"+rs_check.getString("mat_grp2")+"' union all select * from master_data where tablekey='mat_grp2' and code !='"+rs_check.getString("mat_grp2")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						</select></td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Sales: General/Plant</td> 
							</tr>
							<tr>
								<td>Availability check</td>
								<td>
								<select name="availability_chk" id="availability_chk"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='availability_chk' and code ='"+rs_check.getString("availability_chk")+"' union all select * from master_data where tablekey='availability_chk' and code !='"+rs_check.getString("availability_chk")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='load_group' and code='" + rs_check.getString("load_group")+"' union all select * from master_data where tablekey='load_group' and code !='" + rs_check.getString("load_group")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='trans_group' and code='" +rs_check.getString("trans_group") +"' union all select * from master_data where tablekey='trans_group' and code !='" +rs_check.getString("trans_group")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='profitCenter'  and plant='"+plant+"' and code ='" +rs_check.getString("profitCenter")+"' union all select * from master_data where tablekey='profitCenter'  and plant='"+plant+"' and code !='" +rs_check.getString("profitCenter") + "'");
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
								<input  type="text" name="controlCode" id="controlCode" value="<%=rs_check.getString("controlCode")%>"/>
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='purchase_Group' and code='" + rs_check.getString("purchase_Group") +"' union all select * from master_data where tablekey='purchase_Group' and code !='" + rs_check.getString("purchase_Group") +"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='pur_valueKey' and code='" + rs_check.getString("pur_valueKey") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>		
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='pur_valueKey' and code!='" + rs_check.getString("pur_valueKey") +"'");
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
								<td><input type="text" name="tax_ind" id="tax_ind" value ="<%=rs_check.getString("tax_ind")%>"/></td>
								<td>GR processing time</td>
								<td><input type="text" name="gr_processingTime" id="gr_processingTime" value="<%=rs_check.getString("gr_processingTime")%>"/></td>
							</tr>

							<tr
								style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">MRP 1</td> 
							</tr>
							<tr>
								<td>MRP Type</td>
								<td>
						<select name="mrpType" id="mrpType">
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mrpType' and code='"+rs_check.getString("mrpType")+"' union all select * from master_data where tablekey='mrpType' and code!='"+rs_check.getString("mrpType")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='lotSizing_proc' and code='" + rs_check.getString("lotSizing_proc") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='lotSizing_proc' and code!='" + rs_check.getString("lotSizing_proc") +"'");
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
								<td><input type="text" name="mrp_group" id="mrp_group"  value="<%=rs_check.getString("mrp_group")%>" /></td>
								<td>Minimum Lot Size</td>
								<td><input type="text" name="min_LotSize" id="min_LotSize" value="<%=rs_check.getString("min_LotSize")%>" /></td>
							</tr>

							<tr>
								<td>Reorder Point</td>
								<td><input type="text" name="reorderPoint" id="reorderPoint" value="<%=rs_check.getString("reorderPoint")%>" /></td>
								<td>Maximum Lot Size</td>
								<td><input type="text" name="max_LotSize" id="max_LotSize" value="<%=rs_check.getString("max_LotSize")%>" /></td>
							</tr>

							<tr>
								<td>ABC INDICATOR</td>
								<td>
								<select name="abc_indicator" id="abc_indicator">
								
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='abc_indicator' and code='"+ rs_check.getString("abc_indicator")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='abc_indicator' and code !='"+ rs_check.getString("abc_indicator")+"'");
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
								<td><input type="text" name="fixLot" id="fixLot" value="<%=rs_check.getString("fixLot")%>"/></td>
							</tr>
						<tr>
						<td>MRP CONTROLLER</td>
						<td>
						<select name="mrp_Controller" id="mrp_Controller"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mrp_Controller'  and plant='"+plant+"' and code='" + rs_check.getString("mrp_Controller")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mrp_Controller'  and plant='"+plant+"' and code !='" + rs_check.getString("mrp_Controller")+"'");
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
								<td><input type="text" name="MaxStocklevel" id="MaxStocklevel" value="<%=rs_check.getString("MaxStocklevel")%>"/></td>
							</tr>

							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">MRP 2</td> 
							</tr>
							<tr>
						<td>Procurement type</td>
						<td>
						<select name="procure_type" id="procure_type"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='procure_type' and code='" +rs_check.getString("procure_type") + "'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='procure_type' and code !='" +rs_check.getString("procure_type") + "'");
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
								<td><input type="text" name="plan_delTime" id="plan_delTime" value="<%=rs_check.getString("plan_delTime")%>"/></td>
							</tr>

							<tr>
								<td>Special procurement</td>
								<td>
						<select name="specialProc" id="specialProc"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='specialProc' and code='" + rs_check.getString("specialProc") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='specialProc' and code !='" + rs_check.getString("specialProc") +"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='schMrg_Key' and code='"+rs_check.getString("schMrg_Key") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='schMrg_Key' and code !='"+rs_check.getString("schMrg_Key") +"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='storage_loc'  and plant='"+plant+"' and code='"+rs_check.getString("prod_StorageLoc")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>		
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='storage_loc'  and plant='"+plant+"' and code !='"+rs_check.getString("prod_StorageLoc")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='backflush' and code='" + rs_check.getString("backflush")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='backflush' and code !='" + rs_check.getString("backflush")+"'");
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
								<td><input type="text" name="minSafetyStock" id="minSafetyStock" value="<%=rs_check.getString("minSafetyStock")%>"/></td>
								<td>Safety stock</td>
								<td><input type="text" name="safety_stk" id="safety_stk"  value="<%=rs_check.getString("safety_stk")%>"/></td>
							</tr>
							<tr>
								<td>In-house production</td>
								<td><input type="text" name="inhouseProduction" id="inhouseProduction" value="<%=rs_check.getString("inhouseProduction")%>"/></td>
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='strategy_grp' and code='"+rs_check.getString("strategy_grp")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='strategy_grp' and code !='"+rs_check.getString("strategy_grp")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_supervisor'  and plant='"+plant+"' and code='"+rs_check.getString("prod_supervisor")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_supervisor'  and plant='"+plant+"' and code !='"+rs_check.getString("prod_supervisor")+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_schedProfile'  and plant='"+plant+"' and code='" + rs_check.getString("prod_schedProfile")+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("plant")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_schedProfile'  and plant='"+plant+"' and code !='" + rs_check.getString("prod_schedProfile")+"'");
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
								<td><input type="text" name="minRemain_ShelfLife" id="minRemain_ShelfLife" value="<%=rs_check.getString("minRemain_ShelfLife")%>"/></td>
								<td>Total shelf life</td>
								<td><input type="text" name="tot_shelfLife" id="tot_shelfLife" value="<%=rs_check.getString("tot_shelfLife")%>"/></td>
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='qm_controlKey' and code='" + rs_check.getString("qm_controlKey") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='qm_controlKey' and code !='" + rs_check.getString("qm_controlKey") +"'");
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
						<%   
						ps_mst = con.prepareStatement("select * from master_data where tablekey='valueation_class' and plant ='"+matType+"' and code='" +rs_check.getString("valueation_class") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();						
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='valueation_class' and plant ='"+matType+"' and code!='" +rs_check.getString("valueation_class") +"'");
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
								<td><input type="text" name="moveing_price" id="moveing_price" value="<%=rs_check.getString("moveing_price")%>"/></td>
							</tr>
						<tr>
						<td>PRICE CONTROL</td>
						<td>
						<select name="price_control" id="price_control"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='price_control' and code='" + rs_check.getString("price_control") +"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						%>
						<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='price_control' and code !='" + rs_check.getString("price_control") +"'");
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
								<td><input type="text" name="withQty_structure" id="withQty_structure" value="<%=rs_check.getString("withQty_structure")%>" /></td>
							</tr>
						<tr>
						<td><!-- PRICE UNIT -->OVERHEAD GROUP</td>
						<td>
						<input type="text" name="overhead_group" id="overhead_group" value="<%=rs_check.getString("overhead_group")%>"/>
						
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
								<td><input type="text" name="standardPrice" id="standardPrice" value="<%=rs_check.getString("standardPrice")%>"/></td>
								<td></td>
								<td></td>
							</tr>
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Remark / Details / Required for </td>
							</tr>
							<tr>
								<td>Remark / Details</td>
								<td colspan="3"><textarea rows="2" cols="50" name="remark" id="remark"><%=rs_check.getString("remark")%></textarea> </td> 
							</tr>
							
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4"><b style="color : red;">Reject the Material Creation</b> </td>
							</tr>
							
							<%
							int cnt=0;
							if(rs_check.getString("stage").equalsIgnoreCase("0")){
								cnt=1;
							}
							if(rs_check.getString("stage").equalsIgnoreCase("4")){
								cnt=1;
							%>
							<tr>
								<td>Wrong Data Given<br /><b style="color : red">Click if Data not proper</b></td>
								<td>
								<input type="checkbox" name="wrongID" id="wrongID" value="4" checked="checked"/> 
								</td>
								<td><b>Reason For Cancellation</b></td>
								<td><textarea rows="2" cols="50" name="cancellation" id="cancellation"><%=rs_check.getString("reject_reason")%></textarea> </td> 
							</tr>
							<%
								}else{
							%>
							<tr>
									<td>Wrong Data Given<br /><b style="color : red">Click if Data not proper</b></td>
									<td><input type="checkbox" name="wrongID" id="wrongID" value="4"/></td>
										<td><b>Reason For Cancellation</b></td>
										<td><textarea rows="2" cols="50" name="cancellation" id="cancellation"></textarea> </td> 
							</tr>
							<%		
								}
							if(cnt !=1){
							%>
							<tr>
								<td colspan="4" align="center">
								<input type="submit" name="Submit" id="Submit" value="SAVE / UPDATE" class="button" style="height: 25px;font-weight: bold;"/>
								<b style="visibility: hidden;" id="wait_sub">
								<img id="progress_image" style="padding-left: 5px; padding-top: 5px;" src="images/loader.gif"/> 
								</b>
								</td> 
							</tr>
							<%
							}
							%>	
						</table>	
 	
 	</span>
<%	
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</span>
</body>
</html>