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
<%!
    String driver="com.mysql.jdbc.Driver";
    Connection con;
    HttpSession sesion;
%>
<%--service--%>
<%
    String nombre_distrito;
    String codigo_distrito;
    try{
        con= DriverManager.getConnection("jdbc:mysql://localhost/madrid_centro","root","");
        nombre_distrito=request.getParameter("nombre_distrito");
        codigo_distrito=request.getParameter("codigo_distrito");
        /*distrito=loadDistrito(nombre_distrito);*/
    }catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>   
<%--construir pagina--%>
<HTML>
    <BODY>
        <H1><center>Crear queja en <%=nombre_distrito%></center></H1>
        <form action='crearqueja.jsp?codigo_distrito=<%=codigo_distrito%>' method="POST">
            <center>
                    <h5>Introduzca sexo</h5>
                    <label>Masculino<input type="radio" id="sexo" name="sexo" value="M"></label><br><br>
                    <label>Femenino<input type="radio" id="sexo" name="sexo" value="H"></label><br><br>
                    <h5>Tipo de queja</h5>
                        <label>Ambiental<input type="radio" id="tipo" name="tipo" value="Ambiental"></label><br>
                        <label>Social<input type="radio" id="tipo" name="tipo" value="Social"></label><br>
                        <label>Conflictiva<input type="radio" id="tipo" name="tipo" value="Conflictiva"></label><br>
                    <h5>Descripcion de la incidencia</h5>
                    <textarea name="descripcion" id="descripcion" rows="10" cols="50"></textarea><br>
                <input type="submit" value="Enviar">
            </center>
        </form>
    </BODY>
</HTML>