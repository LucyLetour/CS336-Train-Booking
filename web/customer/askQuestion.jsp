<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
        <script>
            let submittingForm = false;
            const setSubmittingForm = function () {
                submittingForm = true;
            };

            window.onbeforeunload = function() {
                if (submittingForm) {
                    return undefined;
                }

                return "Warning: leaving this page now will delete this question";
            };
        </script>
        <ul id="navbar" class="nav">
            <li class="navbar-entry"><a id="home-text" href="userPage.jsp">Schedule</a></li>
            <li class="navbar-entry"><a href="reservations.jsp">My Reservations</a></li>
            <li class="navbar-entry"><a href="questions.jsp">Questions</a></li>
            <li class="navbar-entry right-padding"><a id="logout" href="../login/logout.jsp">Logout</a></li>
        </ul>
        <form method="post"><label for="question">Question: </label><input id="question" name="question" type="text"><input type="submit" value="Search"></form>

    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String insQ =
                    "INSERT INTO unanswered_q (question, )" +
                    "VALUES (?, ?)";
            PreparedStatement ps;
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    </body>
</html>
