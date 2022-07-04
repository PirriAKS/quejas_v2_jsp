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
<%-- <jsp:useBean id="miqueja" class="beans.Queja" scope="request"/> --%>

<%!
    String driver="com.mysql.jdbc.Driver";
    Connection con;
    HttpSession sesion;
    
    
    protected void crearQueja(beans.Queja queja){
        try {
            PreparedStatement ps=con.prepareStatement("INSERT INTO queja VALUES (?,?,?,?,?)");
            ps.setString(1,null);
            ps.setInt(2, queja.getCodigo_distrito());
            ps.setString(3, queja.getSexo());
            ps.setString(4,queja.getTipo());
            ps.setString(5,queja.getDescripcion());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
%>
<%--service--%>
<%
    beans.Queja queja;
    try{
        con= DriverManager.getConnection("jdbc:mysql://localhost/madrid_centro","root","");
        int codigo_distrito= Integer.parseInt(request.getParameter("codigo_distrito"));
        String sexo=request.getParameter("sexo");
        String tipo=request.getParameter("tipo");
        String descripcion=request.getParameter("descripcion");
        queja=new beans.Queja(codigo_distrito,sexo,tipo,descripcion);
        crearQueja(queja);
        response.sendRedirect("menu.jsp");
    }catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>   
<%--construir pagina--%>