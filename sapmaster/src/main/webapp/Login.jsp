<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<script type="text/javascript"> 
	window.onerror = function() {
		return true;
	};
</script>
<script language="JavaScript">
	var nHist = window.history.length;
	if (window.history[nHist] != window.location)
		window.history.forward();
</script>
<script type="text/javascript">
function ValidationEvent() {
	var name = document.getElementById("name").value;
	var pass = document.getElementById("pass").value; 

	if (name == "") {
		alert("Please Provide Login Name !!!");
		return false;
	}
	if (pass == "") {
		alert("Please Provide Password !!!");
		return false;
	}
}	
</script>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Login Form</title>
<link rel="stylesheet" href="css/style.css">
<style type="text/css">
label[for="name"] {
	color: black;
	font-weight: bold;
}

label[for="pass"] {
	color: black;
	font-weight: bold;
}

.errorMessage {
	font-weight: bold;
	color: red;
}
</style>
</head>
<body>
	<br>
	<br>
	<br>
	<section class="container">
	<div class="login">
		<h1 style="cursor: pointer;" title="MUTHA HRMS.....from professional  for professional ">MUTHA GROUP<br> SAP Material Master Registration Portal</h1>
		<form action="LoginControl" method="post" onsubmit="return ValidationEvent()"> 
			<p class="input"> 
				<strong>LOGIN ID  : &nbsp;&nbsp;</strong>
					<input type="text" name="uname" id="name"/>
			</p>
			<p class="input"> 
				<strong>PASSWORD :</strong>
					<input type="password" name="pass" id="pass"/>
			</p>  
			<!-- <p class="input"> 
				<strong>ACCESS :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
					<b style="font-size: 11px;">HR</b><input type="radio" name="access" id="access" value="1" checked="checked">
					<b style="font-size: 11px;">ADMIN</b><input type="radio" name="access" id="access" value="2">
			</p>  -->  
			<p class="submit"> 
				<input type="submit" name="commit" value="  Click to Login  " />
			</p>
			<marquee behavior="alternate" scrolldelay="200">
							<% 
							if(request.getParameter("error")!=null){
							%> 
							<b style="color: red;font-size: 11px;font-weight: bold;"><%= request.getParameter("error")%></b>
							<%	
							}
							%> 
			</marquee>
		</form>
	</div>
	<!-- <div class="login-help" style="font-size: 17px;">
	<span style="cursor: pointer" title="People who are appeared for the interview in MUTHA GROUP they Must Fill the recruitment form">New Vacancy ? <a href="NewRecruit.jsp" style="cursor: pointer;">Click Here</a></span>
	</div> -->
	</section> 
</body>
</html>