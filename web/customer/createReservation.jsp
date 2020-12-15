<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            PreparedStatement ps;

            String rd =
                    "INSERT INTO reservation_data (reservationDate, fare) " +
                    "VALUES (?, ?)";

            String getStationSid =
                    "SELECT sid " +
                    "FROM station_data " +
                    "WHERE stationName LIKE ?";

            String ori =
                    "INSERT INTO origin";

            ps = con.prepareStatement(rd);
            ps.setTimestamp(1, Timestamp.valueOf(request.getParameter("dtime")));
            ps.setInt(2, Integer.parseInt(request.getParameter("fare")));
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</html>
