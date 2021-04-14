<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New File</title>
<script type="text/javascript">
function validateForm() {
	var supplier  = document.getElementById("mat_type");
		if (supplier.value=="0" || supplier.value==null || supplier.value=="" || supplier.value=="null") {
			alert("Company Name ?");
			return false;
		}
}
</script>
</head>
<body>
<form action="Sandbox_CNTRL" method="post" enctype="multipart/form-data">
Import for : <input type="text" name="mat_type" id="mat_type"><br/>
Import File : <input type="file" name="fileName" value="File Name"><br/>
<input type="submit" value="Save">
</form>
</body>
</html>