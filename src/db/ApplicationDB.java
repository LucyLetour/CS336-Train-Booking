package db;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

    public ApplicationDB(){

    }

    public Connection getConnection(){
        //Create a connection string
        String connectionUrl = "jdbc:mysql://cs336-choochoo.c1kex6lbnshj.us-east-2.rds.amazonaws.com:3306";
        Connection connection = null;

        //Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            //Create a connection to your DB
            connection = DriverManager.getConnection(connectionUrl,"admin", "choochoo");
            connection.setCatalog("bookingsystem");
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return connection;
    }

    public void closeConnection(Connection connection){
        try {
            connection.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        ApplicationDB dao = new ApplicationDB();
        Connection connection = dao.getConnection();

        System.out.println(connection);
        dao.closeConnection(connection);
    }
}
