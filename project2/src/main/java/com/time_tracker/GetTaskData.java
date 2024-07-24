package com.time_tracker;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

@WebServlet("/GetTaskData")
public class GetTaskData extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String employee_id = (String) session.getAttribute("emp_id");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        Map<String, Integer> taskData = new HashMap<>();

        Connection con1 = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "Vinay123@dad");
            pst = con1.prepareStatement("SELECT task_category, SUM(TIME_TO_SEC(TIMEDIFF(end_time, start_time))) as duration FROM task_table WHERE emp_id = ? GROUP BY task_category");
            pst.setString(1, employee_id);
            rs = pst.executeQuery();

            while (rs.next()) {
                taskData.put(rs.getString("task_category"), rs.getInt("duration"));
            }

            String json = new Gson().toJson(taskData);
            out.print(json);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("Error fetching data: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pst != null) pst.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (con1 != null) con1.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
