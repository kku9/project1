<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%
         String DB_URL = "jdbc:mysql://10.100.0.147/user_management";
         String DB_USER = "jangmaker";
         String DB_PASSWORD= "password";
         Connection conn;
         Statement stmt;

         try {
              Class.forName("com.mysql.jdbc.Driver");
              conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
              stmt = conn.createStatement();
              conn.close();
              out.println("MySQL Connection Success!");
        }
	catch(Exception e) {
        out.println("MySQL Connection Failed: " + e.getMessage());
    	}  
	finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
%>
