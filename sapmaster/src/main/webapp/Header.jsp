<%
int uid = Integer.parseInt(session.getAttribute("uid").toString());
String uname = session.getAttribute("username").toString(), d_Id = session.getAttribute("dept_id").toString();
%>
<script>
function didYouCheck() {
	alert("Did you check availability in SAP...?");	
}
</script>
<div id="menu" style="font-size: 16px; font-family: Arial; text-align: left;">
				<a href="Home.jsp"><strong>Home</strong></a> &nbsp; &nbsp;
				<div class="dropdown" style="cursor: pointer; font-family: Arial;">
					<strong style="color: white; font-size: 13px">AddMaster</strong>
				<div class="dropdown-content">  
						<a href="New_VendCust.jsp" onclick="didYouCheck()"><strong>Add Customer or Supplier</strong></a> 
						<!-- <a href="New_Master.jsp" onclick="didYouCheck()"><strong>Add New Material</strong> </a> -->
						<!-- <a href="BulkMat_Create.jsp" onclick="didYouCheck()"><strong>Bulk Material Create</strong> </a>	 -->					
						<a href="My_Registrations.jsp"><strong>My Registrations</strong></a>
						<%
						if(d_Id.equalsIgnoreCase("Information Technology") || d_Id.equalsIgnoreCase("IT Development")){
						%>
						<!-- <a href="New_MasterBlkup.jsp" onclick="didYouCheck()"><strong>New Material Upload</strong></a> -->
						<a href="ImportFile.jsp"><strong>Master Upload</strong></a>
						<%
						}
						%>
				</div>
				</div>
				<a href="Logout.jsp">&nbsp;&nbsp;&nbsp;&nbsp; <strong>LogOut (<%=uname%>) </strong></a>
			</div>