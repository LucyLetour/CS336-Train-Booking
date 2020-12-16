<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.*" %>
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
            ResultSet r;
            PreparedStatement ps;

            String rd =
                    "INSERT INTO reservation_data (reservationDate, fare) " +
                    "VALUES (?, ?)";

            String getStationSid =
                    "SELECT sid " +
                    "FROM station_data " +
                    "WHERE stationName LIKE ?";

            String ori =
                    "INSERT INTO origin " +
                    "VALUES (?, ?)";

            String des =
                    "INSERT INTO destination " +
                    "VALUES (?, ?)";

            String pas =
                    "INSERT INTO passenger " +
                    "VALUES (?, ?)";

            String tri =
                    "INSERT INTO trip " +
                    "VALUES (?, ?)";


            ps = con.prepareStatement(getStationSid);
            ps.setString(1, request.getParameter("origin"));
            r = ps.executeQuery();
            r.next();
            int oStationSid = r.getInt("sid");

            ps.setString(1, request.getParameter("dest"));
            r = ps.executeQuery();
            r.next();
            int dStationSid = r.getInt("sid");

            int mult = request.getParameter("roundtrip") == null ? 1 : 2;

            ps = con.prepareStatement(rd, Statement.RETURN_GENERATED_KEYS);
            ps.setTimestamp(1, Timestamp.valueOf(request.getParameter("departure_time")));
            ps.setInt(2, Integer.parseInt(request.getParameter("fare")) * mult);
            ps.executeUpdate();

            r = ps.getGeneratedKeys();
            r.next();
            int rid = r.getInt(1);

            ps = con.prepareStatement(ori);
            ps.setInt(1, rid);
            ps.setInt(2, oStationSid);
            ps.executeUpdate();

            ps = con.prepareStatement(des);
            ps.setInt(1, rid);
            ps.setInt(2, dStationSid);
            ps.executeUpdate();

            ps = con.prepareStatement(pas);
            ps.setString(1, (String) session.getAttribute("user"));
            ps.setInt(2, rid);
            ps.executeUpdate();

            ps = con.prepareStatement(tri);
            ps.setInt(1, Integer.parseInt(request.getParameter("tid")));
            ps.setInt(2, rid);
            ps.executeUpdate();

            response.sendRedirect("reservations.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</html>
