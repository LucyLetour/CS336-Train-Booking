<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Questions</title>
</head>
<body>

    <ul id="navbar" class="nav">
        <li class="navbar-entry"><a id="home-text" class="active" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
        <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
        <li class="navbar-entry"><a href="empQuestionView.jsp">Q & A</a></li>
        <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
    </ul>

    <h1 style="font-family: 'Comic Sans MS',serif; font-size: 4em">Questions and Answers</h1>

    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String str = "SELECT * FROM bookingsystem.unanswered_q";
            PreparedStatement ps = con.prepareStatement(str);

            ResultSet result = ps.executeQuery();


            %><table align="center" border="2">
                <thead>
                    <tr>
                        <th> Question </th>
                        <th> Customer</th>
                    </tr>
                </thead>
                <tbody>
            <%

            while (result.next()){
                String question = result.getString("question");
                String cust_user = result.getString("customer_username");
                int qid = result.getInt("qid");
                %>
                <tr>
                    <td><%=question%></td>
                    <td><%=cust_user%></td>
                    <td>
                        <form method="post" action="empAnswerQuestion.jsp">
                            <input type="hidden" name="question" value="<%=question%>">
                            <input type="hidden" name="cust_user" value="<%=cust_user%>">
                            <input type="hidden" name="qid" value="<%=qid%>">
                            <input type="submit" value="Answer">
                        </form>
                    </td>

                </tr> <%
            }

            %>
                </tbody>
            </table>
            <%

            db.closeConnection(con);
        }
        catch(Exception e){
            e.printStackTrace();
        }

    %>

</body>
</html>
