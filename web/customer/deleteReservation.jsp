<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String del =
                "DELETE FROM passenger " +
                "WHERE rid = ?";
            String del2 =
                "DELETE FROM trip " +
                "WHERE rid = ?";
            String del3 =
                "DELETE FROM origin " +
                "WHERE rid = ?";
            String del4 =
                "DELETE FROM destination " +
                "WHERE rid = ?";
            String del5 =
                "DELETE FROM reservation_data " +
                "WHERE rid = ?";

            PreparedStatement ps;

            ps = con.prepareStatement(del);
            ps.setInt(1, Integer.parseInt(request.getParameter("rid")));
            ps.executeUpdate();

            ps = con.prepareStatement(del2);
            ps.setInt(1, Integer.parseInt(request.getParameter("rid")));
            ps.executeUpdate();

            ps = con.prepareStatement(del3);
            ps.setInt(1, Integer.parseInt(request.getParameter("rid")));
            ps.executeUpdate();

            ps = con.prepareStatement(del4);
            ps.setInt(1, Integer.parseInt(request.getParameter("rid")));
            ps.executeUpdate();

            ps = con.prepareStatement(del5);
            ps.setInt(1, Integer.parseInt(request.getParameter("rid")));
            ps.executeUpdate();

            response.sendRedirect("reservations.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
