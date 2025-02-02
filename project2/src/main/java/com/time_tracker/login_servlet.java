package com.time_tracker;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class login_servlet
 */
@WebServlet("/login")
public class login_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String employee_id= request.getParameter("employee-id");
		String employee_password= request.getParameter("employee-password");
		HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;
		
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");
        	PreparedStatement pst= con.prepareStatement("SELECT * FROM employee_table WHERE emp_id=? AND emp_password=?");
        	
        	pst.setString(1, employee_id);
        	pst.setString(2, employee_password);
        	
        	ResultSet rs = pst.executeQuery();
        	if(rs.next()) {
        		session.setAttribute("emp_name", rs.getString("emp_name"));
        		session.setAttribute("emp_id", rs.getString("emp_id"));
        		dispatcher = request.getRequestDispatcher("home.jsp");
        	}else {
        		request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("login.jsp");
        	}
        	dispatcher.forward(request, response);
        	rs.close();
        	pst.close();
        	con.close();
        }
        catch(Exception e) {
        	e.printStackTrace();
            throw new ServletException("Database access error", e);
        }
	}

}