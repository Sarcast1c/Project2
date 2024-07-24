<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.Date"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.annotation.WebServlet"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Employee</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
	margin: 0;
	padding: 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
	min-height: 100vh;
}

h2 {
	text-align: center;
	color: #343a40;
}

.container {
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	margin-top: 20px;
	max-width: 600px;
}

.container form {
	display: flex;
	flex-direction: column;
}

.container label {
	margin-bottom: 10px;
}

.container input[type="text"], .container input[type="email"],
	.container input[type="number"], .container input[type="password"],
	.container select, .container input[type="submit"] {
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	width: calc(100% - 22px);
}

.container input[type="submit"] {
	background-color: #007bff;
	color: white;
	border: none;
	cursor: pointer;
}

.container input[type="submit"]:hover {
	background-color: #0056b3;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

.list-employees {
	width: 80%
}

th, td {
	border: 1px solid #dee2e6;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #343a40;
	color: #ffffff;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
	<h2>Welcome Admin</h2>
	<hr>
	<div class="container">
		<h2>Add New Employee</h2>
		<form action="admin_add_emp" method="post">
			<div>
				<label for="name">Employee Name</label> <input type="text"
					name="name" placeholder="Enter employee name" required />
			</div>
			<div>
				<label for="age">Age</label> <input type="number" name="age"
					placeholder="Enter employee age" required />
			</div>
			<div>
				<label for="role">Role</label> <input type="text"
					name="employee_role" placeholder="Enter employee role" required />
			</div>
			<div>
				<label for="phone">Phone Number</label> <input type="text"
					name="phone_number" placeholder="Enter phone number" required />
			</div>
			<div>
				<label for="email">Email</label> <input type="email" name="email"
					placeholder="Enter email" required />
			</div>
			<div>
				<label for="password">Password</label> <input type="password"
					name="password" placeholder="Enter password" required />
			</div>
			<input type="submit" value="Add Employee" />
		</form>
	</div>
	<br />
	<br />
	<div class="operation">
		<a href="admin_edit_employee.jsp">Edit Employee Details</a> <a
			href="admin_delete_employee.jsp">Delete Employee Details</a>
	</div>
	<h2>List of Employees</h2>
	<div class="list-employees">
		<table>
			<tr>
				<th>Employee ID</th>
				<th>Name</th>
				<th>Age</th>
				<th>Role</th>
				<th>Phone Number</th>
				<th>Email</th>
			</tr>
			<%
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");
                PreparedStatement pst= con.prepareStatement("SELECT emp_id,emp_name,age,role,phone_number,email FROM employee_table ");
                ResultSet rs=pst.executeQuery();
                
                while(rs.next()){
                    %>
			<tr>
				<td><%=rs.getString("emp_id") %></td>
				<td><%=rs.getString("emp_name") %></td>
				<td><%=rs.getString("age") %></td>
				<td><%=rs.getString("role") %></td>
				<td><%=rs.getString("phone_number") %></td>
				<td><%=rs.getString("email") %></td>
			</tr>
			<%
                }
                 rs.close();
                 pst.close();
                 con.close();
            }
            catch(Exception e){
                e.printStackTrace();
            }
                    %>
		</table>
	</div>
</body>
</html>