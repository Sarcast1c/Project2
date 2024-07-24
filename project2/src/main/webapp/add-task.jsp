<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add a new Task</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f0f0f0;
	padding: 20px;
}

h2 {
	text-align: center;
	color: #333;
}

form {
	max-width: 600px;
	margin: 0 auto;
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
	margin-bottom: 8px;
	color: #555;
}

input[type="text"], input[type="date"], input[type="time"], textarea,
	select {
	width: 100%;
	padding: 8px;
	margin-bottom: 15px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
	box-sizing: border-box;
}

select {
	width: 100%;
	padding: 8px;
	margin-bottom: 15px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
	box-sizing: border-box;
	background-size: 16px;
}

textarea {
	resize: vertical;
	height: 100px;
}

input[type="submit"] {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 12px 20px;
	cursor: pointer;
	border-radius: 4px;
	font-size: 16px;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<h2>Add a new Task</h2>
	<form action="add-task" method="post">
		<label>Project Name</label> <input type="text" name="project-name"
			required /><br>
		<br> <label>Role</label> <input type="text" name="task-role"
			required /><br>
		<br> <label>Date</label> <input type="date" name="task-date"
			required /><br>
		<br> <label>Start Time</label> <input type="time"
			name="task-start-time" required /><br>
		<br> <label>End Time</label> <input type="time"
			name="task-end-time" required /><br>
		<br> <label>Task Category</label> <select name="task-category"
			required>
			<option value="Checking">Checking</option>
			<option value="Coding">Coding</option>
			<option value="Production">Production</option>
			<option value="Testing">Testing</option>
			<option value="Meeting">Meeting</option>
			<option value="Designing">Designing</option>
			<option value="Debugging">Debugging</option>
		</select><br>
		<br> <label>Description</label>
		<textarea name="task-description" required></textarea>
		<br>
		<br> <input type="submit" value="Add" />
	</form>
</body>
</html>