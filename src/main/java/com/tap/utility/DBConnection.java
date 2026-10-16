package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL="jdbc:mysql://localhost:3306/foodwalla";
	private static final String USERNAME="root";
	private static final String PASSWORD="Root";
	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
		Connection connection=null;
		try {
			connection=DriverManager.getConnection(URL,USERNAME,PASSWORD);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}
	

}
