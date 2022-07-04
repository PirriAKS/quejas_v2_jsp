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

    ArrayList loadDistritos() throws SQLException {
        Statement st = con.createStatement();
        ResultSet rs;
        ArrayList arrayList=new ArrayList();
        rs = st.executeQuery("SELECT * FROM distrito");
        while (rs.next()) {
            beans.Distrito d = new beans.Distrito(rs.getInt(1), rs.getString(2));
            arrayList.add(d);
        }
        return arrayList;
    }

    String buildComboBox(ArrayList<beans.Distrito> array){
        String text="";
        for (int i = 0; i < array.size(); i++) {
            beans.Distrito dis=array.get(i);
            text=text+"<option value="+dis.getNombre()+">"+dis.getNombre()+"</option>";
        }
        return text;
    }
%>
<%--service--%>
<%
    String pagina;
    try{
        con= DriverManager.getConnection("jdbc:mysql://localhost/madrid_centro","root","");
        ArrayList<beans.Distrito> distritos = new ArrayList<beans.Distrito>(loadDistritos());
        pagina=buildComboBox(distritos);
    }catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>   
<%--construir pagina con service--%>
<HTML>
    <HEAD>
        
    </HEAD>
    <BODY>
        <H1><center>Quejas Comunidad de Madrid</center></H1>
        <form action='elegir.jsp' method="POST">
            <center><select name="distrito" id="distrito">
                <%=pagina%>
            </select>
            <input type="submit" value="Enviar"></center>
        </form>
    </BODY>
</HTML>