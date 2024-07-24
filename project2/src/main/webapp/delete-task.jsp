<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete a Task</title>
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

.container {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	width: 100%;
}

form {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 80%;
	margin: 20px auto;
	max-width: 600px;
}

form label {
	display: block;
	margin-bottom: 8px;
}

form input[type="text"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

form input[type="submit"] {
	background-color: #f44336;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
}

form input[type="submit"]:hover {
	background-color: #ff6659;
}

table {
	width: 90%;
	border-collapse: collapse;
	margin-top: 20px;
	background-color: #f9f9f9;
	text-align: center;
}

table th, table td {
	border: 1px solid #ddd;
	padding: 8px;
}

table th {
	background-color: #f2f2f2;
	color: #333;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

.delete-section {
	display: flex;
	justify-content: center;
	width: 100%;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Delete a Task</h2>
		<form action="delete-task.jsp" method="post">
			<input type="submit" name="getTasks" value="Get Today's Tasks" />
		</form>

		<% 
        if (request.getParameter("getTasks") != null) {
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");

                String currentDate = java.time.LocalDate.now().toString();
                PreparedStatement pst = con.prepareStatement("SELECT * FROM task_table WHERE task_date = ?");
                pst.setString(1, currentDate);

                ResultSet rs = pst.executeQuery();
        %>

		<table>
			<thead>
				<tr>
					<th>Employee ID</th>
					<th>Employee Name</th>
					<th>Task ID</th>
					<th>Project Name</th>
					<th>Task Role</th>
					<th>Task Date</th>
					<th>Start Time</th>
					<th>End Time</th>
					<th>Task Category</th>
					<th>Task Description</th>
				</tr>
			</thead>
			<tbody>
				<% while (rs.next()) { %>
				<tr>
					<td><%= rs.getString("emp_id") %></td>
					<td><%= rs.getString("emp_name") %></td>
					<td><%= rs.getInt("task_id") %></td>
					<td><%= rs.getString("project_name") %></td>
					<td><%= rs.getString("task_role") %></td>
					<td><%= rs.getString("task_date") %></td>
					<td><%= rs.getString("start_time") %></td>
					<td><%= rs.getString("end_time") %></td>
					<td><%= rs.getString("task_category") %></td>
					<td><%= rs.getString("task_description") %></td>
				</tr>
				<% } %>
			</tbody>
		</table>

		<% 
                rs.close();
                pst.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error occurred: " + e.getMessage() + "</p>");
            }
        }
        %>

		<!-- Form to delete specific task by task_id -->
		<h2>Delete Specific Task</h2>
		<form action="delete-task.jsp" method="post">
			<label for="task_id">Enter Task ID:</label> <input type="text"
				id="task_id" name="task_id" required /> <input type="submit"
				name="deleteTaskById" value="Get Task" />
		</form>

		<% 
        if (request.getParameter("deleteTaskById") != null) {
            String task_id = request.getParameter("task_id");
            if (task_id != null && !task_id.isEmpty()) {
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");

                    PreparedStatement pst = con.prepareStatement("SELECT * FROM task_table WHERE task_id = ? AND task_date = CURDATE()");
                    pst.setString(1, task_id);

                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
        %>

		<table>
			<tr>
				<th>Employee ID</th>
				<th>Employee Name</th>
				<th>Task ID</th>
				<th>Project Name</th>
				<th>Task Role</th>
				<th>Task Date</th>
				<th>Start Time</th>
				<th>End Time</th>
				<th>Task Category</th>
				<th>Task Description</th>
			</tr>
			<tr>
				<td><%= rs.getString("emp_id") %></td>
				<td><%= rs.getString("emp_name") %></td>
				<td><%= rs.getInt("task_id") %></td>
				<td><%= rs.getString("project_name") %></td>
				<td><%= rs.getString("task_role") %></td>
				<td><%= rs.getString("task_date") %></td>
				<td><%= rs.getString("start_time") %></td>
				<td><%= rs.getString("end_time") %></td>
				<td><%= rs.getString("task_category") %></td>
				<td><%= rs.getString("task_description") %></td>
			</tr>
		</table>
		<br>
		<div class="delete-section">
			<form action="delete-task" method="post">
				<input type="hidden" name="task_id" value="<%= task_id %>" /> <input
					type="submit" value="Delete Task" />
			</form>
		</div>

		<% 
                    } else {
                        out.println("<br>No task found with the provided task ID for today.");
                    }
                    rs.close();
                    pst.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                }
            }
        }
        %>
	</div>
</body>
</html>