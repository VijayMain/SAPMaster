package it.muthagroup.connectionUtility;

import java.sql.Connection;
import java.sql.DriverManager;

//Connection Model For Database Connection

public class Connection_Utility {

	static Connection con = null;

	public static Connection getLocalUserConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintzilla", "root", "root");
			System.out.println("Connection Estab");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Connection Failed");
		}
		return con;
	}
	public static Connection getConnectionMaster() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=SAPMaster;user=vijay;password=fast123");
			// con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=TESTSAPMASTER;user=vijay;password=fast123");
			System.out.println("Connection Estab");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Connection Failed");
		}
		return con; // returns Connection
	}
}