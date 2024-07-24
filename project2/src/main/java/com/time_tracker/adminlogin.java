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
 * Servlet implementation class adminlogin
 */
@WebServlet("/adminlogin")
public class adminlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username=request.getParameter("username");
		String password= request.getParameter("password");
		HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");
        	PreparedStatement pst= con.prepareStatement("SELECT * FROM admin_details WHERE user_name=? AND password=?");
        	
        	pst.setString(1, username);
        	pst.setString(2, password);
        	
        	ResultSet rs=pst.executeQuery();
        	if(rs.next()) {
        		session.setAttribute("user_name", rs.getString("user_name"));
        		dispatcher=request.getRequestDispatcher("admin_home.jsp");
        	}
        	else {
        		request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("admin_login.jsp");
        	}
        	dispatcher.forward(request, response);
        	rs.close();
        	pst.close();
        	con.close();
        	
        }
        catch(Exception e){
        	e.printStackTrace();
        }
		
		
		
	}
}
