package com.example.mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection connection = null;
		
		String url = "jdbc:mariadb://localhost:3308/sample";
		String user = "root";
		String password = "1460";
		
		Class.forName("org.mariadb.jdbc.Driver");
		connection = DriverManager.getConnection(url, user, password);
		return connection;
	}
}
