<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX</title>
</head>
<body>
<%
try{
 	String plant = request.getParameter("q");
 	String matType = request.getParameter("p");
 	
 	Connection con = Connection_Utility.getConnectionMaster();
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	/* d_Id = Integer.parseInt(session.getAttribute("dept_id").toString()); */
	String uname = session.getAttribute("username").toString(); 
	PreparedStatement ps_mst = null;
	ResultSet rs_mst = null;
	
%> 
<span id=plant_data>
	<%
		if(plant!=""){
	%>
				<table class="tftable"  id="myForm">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Basic Data<input type="hidden" name="material_type" id="material_type" value="<%=matType%>"/></td>
							</tr>
							<tr>
								<td>Plant</td>
								<td><select name="plant" id="plant" onchange="updatePlant_Data(this.value)"> 
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='plant'  and plant='"+plant+"'");
						rs_mst = ps_mst.executeQuery();
						while(rs_mst.next()){
						%>					
						<option value="<%=rs_mst.getString("code")%>"><%=rs_mst.getString("code")%> <%=rs_mst.getString("descr")%></option>
						<%
						}
						ps_mst.close();
						rs_mst.close();
						ps_mst = con.prepareStatement("select * from master_data where tablekey='plant'  and  plant !='' and plant !='"+plant+"'");
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
								<td><input type="text" name="netWt" id="netWt" /></td>
								<td>Base Unit of Measure</td>
								<td>
								<select name="baseUOM" id="baseUOM">
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
						ps_mst = con.prepareStatement("select * from master_data where tablekey='storage_loc'  and plant='"+plant+"'");
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
								<td><input type="text" name="genItemCatGroup" id="genItemCatGroup" value="NORM"/></td>
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='dist_channel' and plant='"+plant+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='profitCenter'  and plant='"+plant+"'");
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
						<%
						ps_mst = con.prepareStatement("select * from master_data where tablekey='mrp_Controller'  and plant='"+plant+"'");
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
						ps_mst = con.prepareStatement("select * from master_data where tablekey='storage_loc'  and plant='"+plant+"'");
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
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_supervisor'  and plant='"+plant+"'");
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
						ps_mst = con.prepareStatement("select * from master_data where tablekey='prod_schedProfile'  and plant='"+plant+"'");
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
						ps_mst = con.prepareStatement("select * from master_data where tablekey='valueation_class' and plant ='"+matType+"'");
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
								<td colspan="4">Remark / Details / Required for </td>
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
	<%
	/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
	/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
	/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
	
		}else{
	%>		
	<table class="tftable" id="myForm">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
								<td colspan="4">Basic Data<input type="hidden" name="material_type" id="material_type"  value="<%=matType%>"/></td>
							</tr>
							<tr>
								<td>Plant</td>
								<td><select name="plant" id="plant" onchange="updatePlant_Data(this.value)">
								<option value=""> - - - - - Select  - - - - - </option>
						<%
						ps_mst = con.prepareStatement("SELECT * FROM master_data where tablekey  ='plant' and plant!=''");
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
								<td><input type="text" name="genItemCatGroup"
									id="genItemCatGroup" /></td>
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
						ps_mst = con.prepareStatement("select * from master_data where tablekey='valueation_class' and plant ='"+matType+"'");
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
								<td colspan="4">Remark / Details / Required for </td>
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
<%			
		}
}catch(Exception e){
	e.printStackTrace();
}
%>
</span>
</body>
</html>