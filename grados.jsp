<!DOCTYPE html>
<html>
    <head>
        <jsp:useBean id="grados" class="beans.Grados" scope="request"/>
    </head>
    <body>
        <jsp:setProperty name="grados" property="temperatura" value="20 grados"/>
        <h1><jsp:getProperty name="grados" property="temperatura"/></h1>
    </body>
</html>