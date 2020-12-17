<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <link rel="stylesheet" href="../resources/navbar.css">
        <link rel="stylesheet" href="../resources/base.css">
        <title>Ask us!</title>
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

        <div style="width: 90%; margin-right: auto; margin-left: auto;">
            <form method="post" id="qForm" onsubmit="setSubmittingForm()">
                <h2>Question: </h2>
                <br>
                <textarea id="question" rows="4" cols="100" name="question" form="qForm" style="margin-left: auto; margin-right: auto"></textarea>
                <br>
                <input type="submit" value="   Ask   " style="margin-right: 0">
            </form>
        </div>

    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            if(request.getParameter("question") != null) {
                String insQ =
                        "INSERT INTO unanswered_q (question, customer_username)" +
                                "VALUES (?, ?)";
                PreparedStatement ps = con.prepareStatement(insQ);
                ps.setString(1, request.getParameter("question"));
                ps.setString(2, (String) session.getAttribute("user"));
                ps.executeUpdate();
                response.sendRedirect("questions.jsp");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    </body>
</html>
