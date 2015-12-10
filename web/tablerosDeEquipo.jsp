<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style/estiloCabecera.css">
        <link rel="stylesheet" type="text/css" href="style/estiloCuerpo.css">
        <link rel="stylesheet" type="text/css" href="style/estiloPie.css">
        <link rel="stylesheet" type="text/css" href="engine1/style.css" />
        <link rel="stylesheet" href="themes/base/jquery.ui.all.css">
        <script type="text/javascript" src="engine1/jquery.js"></script>
        <script type="text/javascript" src="js/tableroDeEquipo.js"></script>
	<script src="js/jquery.ui.core.js"></script>
	<script src="js/jquery.ui.widget.js"></script>
	<script src="js/jquery.ui.mouse.js"></script>
	<script src="js/jquery.ui.button.js"></script>
	<script src="js/jquery.ui.draggable.js"></script>
	<script src="js/jquery.ui.position.js"></script>
	<script src="js/jquery.ui.dialog.js"></script>
	<script src="js/jquery.ui.effect.js"></script>
        
        <style>
            body { font-size: 70.5%; }
            label, input { display:block; }
            input.text { margin-bottom:12px; width:95%; padding: .4em; }
            fieldset { padding:0; border:0; margin-top:25px; }
            h1 { font-size: 1.2em; margin: .6em 0; }
            .ui-dialog .ui-state-error { padding: .3em; }
            .validateTips { border: 1px solid transparent; padding: 0.3em; }
        </style>
        <title>Tableros de equipos</title>

    </head>
    <body style="background-color: #E6E6FA;">
        <div class="contenidoPrincipal">
            <div id="cabecera">
                <div id="menuInicio">
                    <ul>
                        <li><a href="index.jsp">INICIO</a></li>
                    </ul>
                    <div class="buscar">
                        <input class="inputBuscar" id="inputBuscar" type="text" spellcheck="false">
                        <div class="imgBuscar"></div>
                    </div>
                </div>
                <div id="contRegistro">
                    <div class="menuAjustes">
                        <ul style="display: block;">
                            <li class="liPrincipal"><%
                                    if(session.getAttribute("nombreUsuario")!=null){
                                        out.print(session.getAttribute("nombreUsuario").toString());
                                    }
                                %>
                                <ul>
                                    <li class="liSecundario"><a href="cerrarSesion.jsp">Cerrar Sesión</a></li>
                                    <li class="liSecundario"><a href="#">Nuevo1</a></li>
                                    <li class="liSecundario"><a href="#">Nuevo2</a></li>
                                </ul>
                            </li>
                        </ul>
                        <div class="btnNotificacion" onclick="alert('Aún no hay notificaciones por mostrar!!..')"></div>
                    </div>
                </div>
            </div>
            <div id="cuerpoE" style="border: 1px solid white;">
                <sql:setDataSource var="snapshop" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/noteal" user="root" password="s3cr3tsyst3mlog"/>
                <sql:query var="result" scope="session" dataSource="${snapshop}">
                    SELECT equipo.nombre, equipo.id FROM equipo, usuaequi WHERE equipo.id  = <%out.print(request.getParameter("idEquipo").toString());%> AND usuaequi.idEquipo=equipo.id AND usuaequi.idUsuario=<%out.print(session.getAttribute("idUsuario").toString());%>;
                </sql:query>
                <c:choose>
                    <c:when test="${result.getRowCount() == 0}">
                        <div class="ErrorTablero"> La página que desea abrir no existe. </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="row" items="${result.rowsByIndex}">
                            <div class="cabeceraE">
                                <div style="height: 75%; top: 20px;">
                                    <div class="fotografiaEquipo"> </div>
                                    <div style="display: inline-block">
                                        <h2>${row[0]}</h2>
                                        <h3>Equipo privado</h3>
                                    </div>

                                </div>
                                <ul>
                                    <li ><a href="#" style="background: #E0E0E0;">Tableros</a></li>
                                    <li ><a href="miembrosDeEquipo.jsp?idEquipo=${row[1]}">Miembros</a></li>
                                </ul>
                            </div>
                        </c:forEach>
                        <div class="contenidoE" style="border: 1px solid white;">
                            <div class="listaTableros" style="border-bottom: 10px;">
                                <sql:query var="resulta" scope="session" dataSource="${snapshop}">
                                        SELECT tablero.nombre, tablero.id, usuario.nombre FROM tablero, usuario, equiCreaTable WHERE equiCreaTable.idEquipo = <%out.print(request.getParameter("idEquipo").toString());%> AND equiCreaTable.idTablero = tablero.id AND equiCreaTable.idUsuario = usuario.id;
                                    </sql:query>
                                    <c:forEach var="rowa" items="${resulta.rowsByIndex}">
                                        <a href="manejoTableroEquipo.jsp?idTablero=${rowa[1]}">
                                            <div class="addTableroNew" id="addTableroNew" style="display: block;">
                                            <p style="display: block; margin-top: 5%; margin-left: 5%; color: #FFFFFF;">${rowa[0]}</p>
                                            <p style="display: block; margin-left: 5%; color: #FFFFFF;">${rowa[2]}</p>
                                        </div>
                                        </a>
                                    </c:forEach>
                                <div class="addTablero" id="create-table-personal">
                                    <p style="display: block; margin-top: 15%; margin-left: 12%;">Crear un tablero nuevo...</p>
                                </div> 
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="pie">
                <div class="creditos">
                    <b> &copy;  NOTE AL.</b><br>
                     Derechos reservados.<br>
                     Autores: Pérez Ramírez Epifanio and Zárate Pacheco Rosalba.
                </div>
            </div>
        </div>
    </body>
</html>
