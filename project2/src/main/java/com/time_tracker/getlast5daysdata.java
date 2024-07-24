package com.time_tracker;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/GetLast5DaysData")
public class getlast5daysdata extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONArray jsonArray = new JSONArray();

        HttpSession session = request.getSession(false);
        if (session != null) {
            String employeeName = (String) session.getAttribute("emp_name");

            if (employeeName != null && !employeeName.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root","Vinay123@dad");

                    String query = "SELECT DATE(task_date) AS task_date, SUM(TIME_TO_SEC(duration)) AS total_duration "
                            + "FROM task_table "
                            + "WHERE task_date >= CURDATE() - INTERVAL 5 DAY "
                            + "AND emp_name = ? "
                            + "GROUP BY DATE(task_date) "
                            + "ORDER BY DATE(task_date) ASC"; 

                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, employeeName);
                    ResultSet rs = pst.executeQuery();

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    while (rs.next()) {
                        JSONObject jsonObject = new JSONObject();
                        String taskDate = sdf.format(rs.getDate("task_date"));
                        int totalDurationInSeconds = rs.getInt("total_duration");
                        jsonObject.put("task_date", taskDate);
                        jsonObject.put("total_duration", totalDurationInSeconds / 3600.0); // convert seconds to hours
                        jsonArray.put(jsonObject);
                    }

                    rs.close();
                    pst.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    jsonArray.put(new JSONObject().put("error", e.getMessage()));
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    jsonArray.put(new JSONObject().put("error", e.getMessage()));
                }
            } else {
                jsonArray.put(new JSONObject().put("error", "Employee name not found in session"));
            }
        } else {
            jsonArray.put(new JSONObject().put("error", "Session not found"));
        }

        out.print(jsonArray.toString());
        out.flush();
    }
}
