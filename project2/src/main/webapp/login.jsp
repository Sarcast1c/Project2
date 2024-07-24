<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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
	min-height: 100vh;
	color: #333;
}

h2 {
	font-size: 2em;
	margin-bottom: 20px;
	text-align: center;
}

.header {
	display: flex;
	justify-content: space-evenly;
	width: 100%;
}

h2 a {
	text-decoration: none;
	color: #007BFF;
}

h2 a:hover {
	color: #0056b3;
}

.form-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 80%;
	max-width: 400px;
	margin-bottom: 30px;
}

.form-container h2 {
	font-size: 1.5em;
	margin-bottom: 15px;
}

form label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

form input[type="text"], form input[type="password"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

form input[type="submit"] {
	width: 100%;
	background-color: #000;
	color: white;
	border: none;
	padding: 10px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 1em;
}

form input[type="submit"]:hover {
	background-color: #2f302f;
}

p {
	text-align: center;
	font-size: 1em;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="header">
		<h2>
			<a href="employee.jsp">Sign Up</a>
		</h2>
		<h2>Login</h2>
	</div>
	<div class="form-container get_emp_id">
		<h2>Get Employee ID</h2>
		<form action="get_employee_detail" method="post">
			<label for="phone_number">Phone Number</label> <input type="text"
				name="phone_number" required /><br> <label for="password">Password</label>
			<input type="password" name="password" required /><br> <input
				type="submit" value="Get" />
		</form>
		<%
            String emp_id = (String) request.getAttribute("emp_id");
            String emp_password = (String) request.getAttribute("emp_password");
            if (emp_id != null && emp_password != null) {
                out.println("<p>Your Employee ID: " + emp_id + "</p>");
                out.println("<p>Your Employee Password: " + emp_password + "</p>");
            }
        %>
	</div>
	<div class="form-container account-login">
		<h2>Account Login</h2>
		<form action="login" method="post">
			<label for="employee-id">Enter your Employee ID</label> <input
				type="text" name="employee-id" required /><br> <label
				for="employee-password">Enter your Account Password</label> <input
				type="password" name="employee-password" required /><br> <input
				type="submit" value="Login" />
		</form>
	</div>
</body>
</html>