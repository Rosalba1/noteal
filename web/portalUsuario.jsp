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
        <script src="js/portalUsuario.js"></script>
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
        <title>NoteAL</title>
         <script type = "text/javascript" >
            function changeHashOnLoad() {
                 window.location.href += "#";
                 setTimeout("changeHashAgain()", "50"); 
            }

            function changeHashAgain() {
              window.location.href += "1";
            }

            var storedHash = window.location.hash;
            window.setInterval(function () {
                if (window.location.hash != storedHash) {
                     window.location.hash = storedHash;
                }
            }, 50);
        </script>
    </head>
    <body style="background-color: #E6E6FA;" onload="changeHashOnLoad();">
        <div id="dialog-form" title="Crear nuevo tablero" style="width: 300px;">
            <p class="validateTips">Todos los campos son requeridos.</p>
            <html:form action="formAgregarTablero">
                <fieldset>
                    <label for="name">Nombre del tablero</label>
                    <html:text property="name"></html:text><br><br>
                    
                    <label for="type">Alcance</label>
                    <select name="number" id="alcanceTablero" class="text ui-widget-content ui-corner-all">
                        <option value="1">Privado</option>
                        <option value="3">Publico</option>
                    </select>
                    
                </fieldset>
            </html:form>
        </div>
        <div id="dialog-form-equipo-tablero" title="Crear nuevo tablero para un equipo" style="width: 300px;">
            <p class="validateTips">Todos los campos son requeridos.</p>
                <fieldset>
                    <label for="name">Nombre del tablero</label>
                    <input type="text" id="nombreTableroEquipo"><br><br>
                    <input type="text" id="idEquipo" style="display: none;">
                    <label for="type">Alcance</label>
                    <select name="number" id="alcanceTablero" class="text ui-widget-content ui-corner-all">
                        <option value="2">Equipo</option>
                    </select>
                </fieldset>
        </div>
        <div id="dialog-form-equipo" title="Crear un nuevo equipo">
            <p class="validateTips">Todos los campos son requeridos.</p>
            <html:form action="formAgregarEquipo">
                <fieldset>
                    <label for="name">Nombre del equipo</label>
                    <input type="text" name="name" id="nameEquipo"/>
                </fieldset>
            </html:form>
            <br><br>Un equipo es un grupo de tableros y personas. Ayuda a mantener organizada su empresa, equipo o familia.
        </div>

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
            <div id="cuerpo">
                <div class="contInicioTrelloTab">
                    <div class="contPrinTabEqui">
                        <div class="contTablero">
                           <div class="tituloCrearTablero">
                                <div class="imgTablero"></div> 
                                <div class="titTablero">Mis Tableros</div>  
                            </div>
                            <div class="listaTableros" style="border-bottom: 10px;">
                                <sql:setDataSource var="snapshop" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/noteal" user="root" password="s3cr3tsyst3mlog"/>
                                <sql:query var="result" scope="session" dataSource="${snapshop}">
                                    SELECT tablero.nombre, tablero.id FROM tablero WHERE idCreador  = <%out.print(session.getAttribute("idUsuario").toString());%> AND alcance = 1;
                                </sql:query>
                                <c:forEach var="row" items="${result.rowsByIndex}">
                                    <a href="manejoDeTablero.jsp?idTablero=${row[1]}">
                                        <div class="addTableroNew" id="addTableroNew" style="display: block;" >
                                            <p style="display: block; margin-top: 5%; margin-left: 5%; color: #FFFFFF;">${row[0]}</p>
                                        </div>
                                    </a>
                                </c:forEach>
                                <div class="addTablero" id="create-table-personal">
                                    <p style="display: block; margin-top: 15%; margin-left: 12%;">Crear un tablero nuevo...</p>
                                </div> 
                            </div>
                        </div>
                        <sql:query var="result" scope="session" dataSource="${snapshop}">
                            SELECT equipo.nombre, equipo.id FROM equipo, usuaequi WHERE usuaequi.idUsuario  = <%out.print(session.getAttribute("idUsuario").toString());%> AND equipo.id = usuaequi.idEquipo;
                        </sql:query>
                        <c:forEach var="row" items="${result.rowsByIndex}">
                            <div class="contTablero">
                                <div class="tituloCrearTablero">
                                    <div class="imgTableroEquipo"></div> 
                                    <div class="titTablero">${row[0]}</div>
                                    <a href="tablerosDeEquipo.jsp?idEquipo=${row[1]}"><button>Tableros</button></a>
                                    <a href="miembrosDeEquipo.jsp?idEquipo=${row[1]}"><button>Miembros</button></a>
                                </div>
                                <div class="listaTableros">
                                    <sql:query var="resulta" scope="session" dataSource="${snapshop}">
                                        SELECT tablero.nombre, tablero.id, usuario.nombre FROM tablero, usuario, equiCreaTable WHERE equiCreaTable.idEquipo = ${row[1]} AND equiCreaTable.idTablero = tablero.id AND equiCreaTable.idUsuario = usuario.id;
                                    </sql:query>
                                    <c:forEach var="rowa" items="${resulta.rowsByIndex}">
                                        <a href="manejoTableroEquipo.jsp?idTablero=${rowa[1]}">
                                            <div class="addTableroNew" id="addTableroNew" style="display: block;">
                                            <p style="display: block; margin-top: 5%; margin-left: 5%; color: #FFFFFF;">${rowa[0]}</p>
                                            <p style="display: block; margin-left: 5%; color: #FFFFFF;">${rowa[2]}</p>
                                        </div>
                                        </a>
                                    </c:forEach>
                                    <div class="addTablero nuevotableroEquipal" id="${row[0]}" onclick="idEquipoV = '${row[1]}'">
                                        <p style="display: block; margin-top: 15%; margin-left: 12%;">Crear un tablero nuevo...</p>
                                    </div> 
                                </div>
                            </div>
                        </c:forEach>
                        <label for="type" class="NuevoEquipo"><p style="display: block; margin-top: 15%; ">Crear un nuevo equipo</p></label>
                    </div>
                </div>
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
