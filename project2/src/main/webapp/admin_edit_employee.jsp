<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Employee</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f0f2f5;
	margin: 0;
	padding: 20px;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

form {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 80%;
	margin: 0 auto;
	max-width: 600px;
}

form label {
	display: block;
	margin-bottom: 8px;
}

form input[type="text"], form input[type="email"], form input[type="number"]
	{
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

form input[type="submit"] {
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}

form input[type="submit"]:hover {
	background-color: #45a049;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

table th {
	background-color: #f2f2f2;
	color: #333;
}
</style>
</head>
<body>
	<h2>Edit Employee Details</h2>
	<form method="post" action="admin_edit_employee.jsp">
		<label>Enter Employee ID:</label> <input type="text" name="emp_id"
			required /> <input type="submit" value="Get Details" />
	</form>
	<%
String emp_id = request.getParameter("emp_id");
if (emp_id != null && !emp_id.isEmpty()) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM employee_table WHERE emp_id = ?");
        pst.setString(1, emp_id);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            %>
	<table>
		<tr>
			<th>Employee ID</th>
			<th>Name</th>
			<th>Age</th>
			<th>Role</th>
			<th>Phone Number</th>
			<th>Email</th>
		</tr>
		<tr>
			<td><%= rs.getString("emp_id") %></td>
			<td><%= rs.getString("emp_name") %></td>
			<td><%= rs.getString("age") %></td>
			<td><%= rs.getString("role") %></td>
			<td><%= rs.getString("phone_number") %></td>
			<td><%= rs.getString("email") %></td>
		</tr>
	</table>
	<br>
	<br>
	<form action="admin_update_employee" method="post">
		<input type="hidden" name="emp_id"
			value="<%= rs.getString("emp_id") %>" /> <label>Name</label> <input
			type="text" name="new_name" value="<%= rs.getString("emp_name") %>"
			required /><br>
		<br> <label>Age</label> <input type="text" name="new_age"
			value="<%= rs.getString("age") %>" required /><br>
		<br> <label>Role</label> <input type="text" name="new_role"
			value="<%= rs.getString("role") %>" required /><br>
		<br> <label>Phone Number</label> <input type="text"
			name="new_phone" value="<%= rs.getString("phone_number") %>" required /><br>
		<br> <label>Email</label> <input type="email" name="new_email"
			value="<%= rs.getString("email") %>" required /><br>
		<br> <input type="submit" value="Update">
	</form>
	<%
        } else {
            out.println("<p>No employee found with the provided ID.</p>");
        }
        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    }
}
%>
</body>
</html>