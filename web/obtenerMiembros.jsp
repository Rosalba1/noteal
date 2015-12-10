<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql" %>
<sql:setDataSource var="snapshop" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/noteal" user="root" password="s3cr3tsyst3mlog"/>
<sql:query var="result" scope="session" dataSource="${snapshop}">
        SELECT <%out.print(request.getParameter("valor2"));%>,id FROM usuario WHERE <%out.print(request.getParameter("valor2"));%> LIKE '<%out.print(request.getParameter("valor1"));%>%' LIMIT 0,10
</sql:query>
<script src="js/miembrosEquipo.js"></script>        
<% int contador = 0;%>
<ul class="listaResultado" id="sa_ul" style="margin-top:5px;"> <c:forEach var="row" items="${result.rowsByIndex}">
        <li id="<% out.print(contador);%>" style="text-decoration: none; list-style: none;" onclick="idUsuario = ${row[1]}; agregarUsuario();">
            <div id="INDjhg${row[1]}" style="width: 20px; height: 20px; border: 1px solid black; display: inline-block;">
            </div>
            <div style="display: inline-block;">${row[0]}</div>
        </li><% contador ++;%></c:forEach>
</ul>
