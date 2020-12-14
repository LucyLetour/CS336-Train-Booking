<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Answer a Question</title>
</head>
<body>
<%
    try{
        // Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String qid = request.getParameter("qid");
        String question = request.getParameter("question");
        String cust_user = request.getParameter("cust_user");
        String answer_text = request.getParameter("answer_text");

        //delete the unanswered question from unanswered_q table
        //insert into qa with answer text and employee ssn

        String del = "DELETE FROM bookingsystem.unanswered_q WHERE qid = ?";
        PreparedStatement ps = con.prepareStatement(del);
        ps.setString(1, qid);
        int result_delete = ps.executeUpdate();

        String ins = "INSERT INTO bookingsystem.qa VALUE (?, ?, ?, ?, ?)";
        PreparedStatement ps2 = con.prepareStatement(ins);
        ps2.setString(1,question);
        ps2.setString(2,answer_text);
        ps2.setString(3,cust_user);
        ps2.setString(4,session.getAttribute("emp_ssn").toString());
        ps2.setString(5,qid);
        int result_insert = ps2.executeUpdate();


        db.closeConnection(con);
        response.sendRedirect("empQuestionView.jsp");

    }
    catch (Exception e){
        e.printStackTrace();
    }


%>

</body>
</html>
