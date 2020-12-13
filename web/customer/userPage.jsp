<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <link rel="stylesheet" href="../resources/navbar.css">
        <link rel="stylesheet" href="../resources/base.css">
        <title>My Home</title>
    </head>

    <body>

        <ul id="navbar" class="nav">
            <li class="navbar-entry"><a id="home-text" class="active" href="userPage.jsp">Schedule</a></li>
            <li class="navbar-entry"><a href="reservations.jsp">My Reservations</a></li>
            <li class="navbar-entry"><a href="questions.jsp">Questions</a></li>
            <li class="navbar-entry right-padding"><a id="logout" href="../login/logout.jsp">Logout</a></li>
        </ul>
        <br>
        <%
            out.print("Welcome, " + session.getAttribute("user"));
        %>
        <br>
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection(); %>


            <form action="userPage.jsp" method="GET">
                <label for="origin">Origin Station:</label>
                <select name="origin" id="origin">
                    <option></option>
                    <%
                        String str = "SELECT * FROM test1.stationNames";
                        PreparedStatement ps = con.prepareStatement(str);
                        ResultSet stationResults = ps.executeQuery();

                        String lastSelected;
                        while(stationResults.next()) {
                            lastSelected = stationResults.getString("name").equals(request.getParameter("origin")) ? "selected" : ""; %>
                            <option <%=lastSelected%> value="<%=stationResults.getString("name")%>"><%=stationResults.getString("name")%></option>
                        <% }
                    %>
                </select>
                <label for="dest">Destination Station:</label>
                <select name="dest" id="dest">
                    <option></option>
                    <%
                        stationResults = ps.executeQuery();

                        while(stationResults.next()) {
                            lastSelected = stationResults.getString("name").equals(request.getParameter("dest")) ? "selected" : ""; %>
                            <option <%=lastSelected%> value="<%=stationResults.getString("name")%>"><%=stationResults.getString("name")%></option>
                        <% }
                    %>
                </select>
                <label for="dtime">Departure Time:</label>
                <input type="datetime-local" name="dtime" id="dtime" value="<%=request.getParameter("dtime")%>">
                <input type="submit" value="Search">
            </form>

        <!-- Generate table with all valid train schedules -->

        <%
            // Get info from GET
            String origin = request.getParameter("origin");
            String dest = request.getParameter("dest");
            String dtime = request.getParameter("dtime");

            String oddStr = "SELECT * FROM bookingsystem.reservation_data";
            ps = con.prepareStatement(oddStr);
            ResultSet result = ps.executeQuery();

            // Generate table from query
            while(result.next()) {

            }
        } catch (Exception e) {
            e.printStackTrace();
        } %>
    </body>
</html>
