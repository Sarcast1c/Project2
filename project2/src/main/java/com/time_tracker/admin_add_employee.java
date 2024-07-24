package com.time_tracker;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class admin_add_employee
 */
@WebServlet("/admin_add_emp")
public class admin_add_employee extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String emp_name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String role = request.getParameter("employee_role");
        String phone_number = request.getParameter("phone_number");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        int emp_id = generate_employee_id();
        String emp_password = generate_employee_password();

        RequestDispatcher dispatcher = null;
        Connection con1 = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");
            pst = con1.prepareStatement("INSERT INTO employee_table (emp_id, emp_name, age, role, phone_number, email, password, emp_password) VALUES(?,?,?,?,?,?,?,?)");

            pst.setInt(1, emp_id); 
            pst.setString(2, emp_name);
            pst.setInt(3, age);
            pst.setString(4, role);
            pst.setString(5, phone_number);
            pst.setString(6, email);
            pst.setString(7, password);
            pst.setString(8, emp_password);

            int rowcount = pst.executeUpdate();
            dispatcher = request.getRequestDispatcher("admin_home.jsp");
            if (rowcount > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "exception: " + e.getMessage());
            dispatcher = request.getRequestDispatcher("admin_home.jsp");
            dispatcher.forward(request, response);
        } finally {
            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con1 != null) {
                try {
                    con1.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
	}
    private int generate_employee_id() {
        return new Random().nextInt(99999999); 
    }

    private String generate_employee_password() {
        return String.valueOf(new Random().nextInt(999999));
    
    }
}