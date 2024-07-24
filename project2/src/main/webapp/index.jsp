<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Time Tracker</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f0f2f5;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
	color: #333;
}

h2 {
	font-size: 2.5em;
	margin-bottom: 20px;
}

a {
	display: inline-block;
	margin: 10px 20px;
	padding: 10px 20px;
	text-decoration: none;
	color: white;
	background-color: #007BFF;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

a:hover {
	background-color: #0056b3;
}

.container {
	text-align: center;
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 80%;
	max-width: 600px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Task Tracker</h2>
		<a href="admin_login.jsp">Admin</a> <a href="employee.jsp">Employee</a>
	</div>
</body>
</html>