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
        <li class="navbar-entry"><a id="home-text" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
        <li class="navbar-entry"><a href="empScheduleView.jsp">Schedules</a></li>
        <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
        <li class="navbar-entry"><a class="active" href="empQuestionView.jsp">Q & A</a></li>
        <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
    </ul>

    <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String str = "SELECT * FROM bookingsystem.unanswered_q";
            PreparedStatement ps = con.prepareStatement(str);

            ResultSet result = ps.executeQuery();


            %>
            <p>Unanswered Questions</p>
            <br>
            <table align="center" border="2">
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
            <br>
            <p>Answered Questions</p>
            <br>
            <table align="center" border="2">
                <thead>
                    <tr>
                        <th> Question </th>
                        <th> Answer </th>
                        <th> Customer </th>
                        <th> Representative </th>
                    </tr>
                </thead>
                <tbody>
                <%
            String str_ans = "Select * FROM bookingsystem.qa";
            PreparedStatement ps_answered = con.prepareStatement(str_ans);
            ResultSet res_answered = ps_answered.executeQuery();

            while (res_answered.next()) {
                String question = res_answered.getString("question");
                String answer = res_answered.getString("answer");
                String cust_user = res_answered.getString("customer_username");
                int ssn = res_answered.getInt("ssn");

                String str_emp = "SELECT username FROM bookingsystem.employee_data WHERE ssn = ?";
                PreparedStatement ps_emp = con.prepareStatement(str_emp);
                ps_emp.setString(1, Integer.toString(ssn));
                ResultSet res_emp = ps_emp.executeQuery();

                String employee_name = "default";

                if (res_emp.next()){
                    employee_name = res_emp.getString("username");
                }


                %>
                <tr>
                    <td><%=question%></td>
                    <td><%=answer%></td>
                    <td><%=cust_user%></td>
                    <td><%=employee_name%></td>
                </tr>
                <%


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
