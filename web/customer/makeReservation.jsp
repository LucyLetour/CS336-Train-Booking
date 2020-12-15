<%@ page contentType="text/html;charset=UTF-8"%>
<html>
    <head>
        <title>Make Reservation</title>
    </head>
    <body>
        <%
            int onewayFare = Integer.parseInt(request.getParameter("fare"));
        %>

        <form oninput="vFare.value=(!roundtrip.checked || roundtrip.indeterminate ? 1 : 2)*<%=onewayFare%>">
            <label for="roundtrip">Roundtrip: </label><input type="checkbox" id="roundtrip" value="unchecked">
            <output name="vFare" for="roundtrip fare"><%=onewayFare%></output>
        </form>

        <form oninput="x.value=parseInt(a.value)+parseInt(b.value)">
            <input type="range" id="a" value="50">
            +<input type="number" id="b" value="25">
            =<output name="x" for="a b"></output>
        </form>
    </body>
</html>
