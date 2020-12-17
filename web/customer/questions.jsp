<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <link rel="stylesheet" href="../resources/navbar.css">
        <link rel="stylesheet" href="../resources/base.css">
        <title>Questions</title>
    </head>
    <body>
        <ul id="navbar" class="nav">
            <li class="navbar-entry"><a id="home-text" href="userPage.jsp">Schedule</a></li>
            <li class="navbar-entry"><a href="reservations.jsp">My Reservations</a></li>
            <li class="navbar-entry"><a class="active" href="questions.jsp">Questions</a></li>
            <li class="navbar-entry right-padding"><a id="logout" href="../login/logout.jsp">Logout</a></li>
        </ul>
        <div style="width: 95%; margin-left: auto; margin-right: auto">

            <br>

            <br>
            <table style="border: none">
                <tbody>
                    <td style="border: none">
                        <form action="questions.jsp" method="get"><label for="searchKeywords">Search keywords: </label><input id="searchKeywords" name="searchKeywords" type="text"><input type="submit" value="Search"></form>
                    </td>
                    <td style="border: none">
                        <form action="askQuestion.jsp" method="post"><input type="submit" value="Ask Question"></form>
                    </td>
                </tbody>
            </table>


            <%
                try {
                    ApplicationDB db = new ApplicationDB();
                    Connection con = db.getConnection();

                    String[] keywords;

                    if (request.getParameter("searchKeywords") == null) {
                        keywords = new String[] {"%"};
                    } else {
                        keywords = request.getParameter("searchKeywords").split(" ");
                    }

                    String wordQuery =
                            "SELECT * " +
                            "FROM qa " +
                            "WHERE question LIKE ? or answer LIKE ? ";

                    StringBuilder q = new StringBuilder("");

                    for (int i = 0; i < keywords.length; i++) {
                        q.append(wordQuery.replace("?", "'%" + keywords[i] + "%'"));

                        if (i != keywords.length - 1) {
                            q.append("UNION ");
                        }
                    }

                    @SuppressWarnings("SqlResolve") String priorityQuery = "SELECT *, COUNT(*) c " +
                            "FROM (" + q.toString() + ") wq " +
                            "GROUP BY qid " +
                            "ORDER BY c DESC";

                    PreparedStatement ps = con.prepareStatement(priorityQuery);
                    ResultSet r = ps.executeQuery();
                    %>
            <br>
            <br>
                    <table border="2" align="center">
                        <thead>
                        <tr>
                            <th> Question </th>
                            <th> Answer </th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                        while(r.next()) {%>
                            <tr>
                                <td><%=r.getString("question")%></td>
                                <td><%=r.getString("answer")%></td>
                            </tr>
                        <% }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </body>
</html>
