
package com.time_tracker;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/add-task")
public class Add_task extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String employee_id = (String) session.getAttribute("emp_id");
        String employee_name = (String) session.getAttribute("emp_name");
        int task_id = generate_task_id();
        String project_name = request.getParameter("project-name");
        String role = request.getParameter("task-role");
        String Date = request.getParameter("task-date");
        String start_time = request.getParameter("task-start-time");
        String end_time = request.getParameter("task-end-time");
        String task_category = request.getParameter("task-category");
        String task_description = request.getParameter("task-description");

        RequestDispatcher dispatcher = null;
        Connection con1 = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");
            pst = con1.prepareStatement("INSERT INTO task_table (emp_id, emp_name, task_id, project_name, task_role, task_date, start_time, end_time, task_category, task_description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            
            pst.setString(1, employee_id);
            pst.setString(2, employee_name);
            pst.setInt(3, task_id);
            pst.setString(4, project_name);
            pst.setString(5, role);
            pst.setString(6, Date);
            pst.setString(7, start_time);
            pst.setString(8, end_time);
            pst.setString(9, task_category);
            pst.setString(10, task_description);

            int rowcount = pst.executeUpdate();
            dispatcher = request.getRequestDispatcher("home.jsp");
            if (rowcount > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }
            dispatcher.forward(request, response);
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (con1 != null) con1.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    private int generate_task_id() {
        return new Random().nextInt(99999999);
    }
}