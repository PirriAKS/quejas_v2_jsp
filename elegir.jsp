<%@page import="java.sql.*"%>
<%@page import="javax.servlet.ServletConfig"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>

<%--declaracion--%>
<%-- <jsp:useBean id="midistrito" class="beans.Distrito" scope="request"/> --%>

<%!
    String driver="com.mysql.jdbc.Driver";
    Connection con;
    HttpSession sesion;

    beans.Distrito loadDistrito(String distrito) throws SQLException {
        Statement st = con.createStatement();
        ResultSet rs;
        rs = st.executeQuery("SELECT * FROM distrito WHERE nombre='"+distrito+"'");
        beans.Distrito d = null;
        while (rs.next()) {
            d = new beans.Distrito(rs.getInt(1), rs.getString(2));
        }
        return d;
    }
%>
<%--service--%>
<%
    beans.Distrito distrito;
    try{
        con= DriverManager.getConnection("jdbc:mysql://localhost/madrid_centro","root","");
        String nombre_distrito=request.getParameter("distrito");
        distrito=loadDistrito(nombre_distrito);
    }catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>   
<%--construir pagina con service--%>
<HTML>
    <BODY>
        <H1><center><%=distrito.getNombre()%></center></H1>
        <form action='insertarqueja.jsp?nombre_distrito=<%=distrito.getNombre()%>&codigo_distrito=<%=distrito.getCodigo()%>' method="POST">
            <center>
                <label>Crear queja<br>
                <input type="submit" value="Enviar">
            </center>
        </form>
        <form action='quejas.jsp?nombre_distrito=<%=distrito.getNombre()%>&codigo_distrito=<%=distrito.getCodigo()%>' method="POST">
            <center>
                <label>Consultar quejas<br>
                <input type="submit" value="Enviar">
            </center>
        </form>
    </BODY>
</HTML>