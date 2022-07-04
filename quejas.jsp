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

    ArrayList loadQuejas(String codigo) throws SQLException {
        Statement st = con.createStatement();
        ResultSet rs;
        ArrayList arrayList=new ArrayList();
        rs = st.executeQuery("SELECT * FROM queja WHERE codigo_distrito="+codigo);
        while (rs.next()) {
            beans.Queja q = new beans.Queja(rs.getInt(1), rs.getInt(2),rs.getString(3),rs.getString(4),rs.getString(5));
            arrayList.add(q);
        }
        return arrayList;
    }

    protected static String buildQuejas(ArrayList<beans.Queja> array){
        String text="";
        for (int i = 0; i < array.size(); i++) {
            beans.Queja queja=array.get(i);
            text=text+"<h4> Queja de tipo "+queja.getTipo()+"</h4><br><h5>Descripcion: "+queja.getDescripcion()+"</h5>";
        }
        return text;
    }
%>
<%--service--%>
<%
    String pagina;
    try{
        con= DriverManager.getConnection("jdbc:mysql://localhost/madrid_centro","root","");
        String nombre_distrito=request.getParameter("nombre_distrito");
        String codigo_distrito=request.getParameter("codigo_distrito");
        ArrayList<beans.Queja> quejas=loadQuejas(codigo_distrito);
        pagina=buildQuejas(quejas);
    }catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>   
<%--construir pagina con service--%>
<html>
    <body>
        <%=pagina%>
    </body>
</html>