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
        <link rel="stylesheet" type="text/css" href="style/estiloTablero.css">
        <link rel="stylesheet" href="themes/base/jquery.ui.all.css">
        <script type="text/javascript" src="engine1/jquery.js"></script>
	<script src="js/jquery.ui.core.js"></script>
	<script src="js/jquery.ui.widget.js"></script>
	<script src="js/jquery.ui.mouse.js"></script>
	<script src="js/jquery.ui.sortable.js"></script>
	<script src="js/jquery.ui.button.js"></script>
	<script src="js/jquery.ui.draggable.js"></script>
	<script src="js/jquery.ui.position.js"></script>
	<script src="js/jquery.ui.dialog.js"></script>
	<script src="js/jquery.ui.effect.js"></script>
        <script type="text/javascript" src="js/manejoTablero.js"></script>
        <title>NoteAL</title>
         
    </head>
    <body style="background-color: #E6E6FA;" >
        
<div id="dialog-confirm" title="Desea eliminar esta lista">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>¿Esta seguro de eliminar esta lista?, Una vez eliminada no podra recuperarse.</p>
</div>
        
<div id="dialog-form" title="Crear nueva lista">
    <p class="validateTips">Todos los campos son requeridos.</p>
    <fieldset>
        <label for="name">Nombre de la lista</label>
        <input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />
    </fieldset>
</div>
        
<div id="dialog-form-tarjeta" title="Agregar una tarjeta">
    <p class="validateTips">Todos los campos son requeridos.</p>
    <fieldset>
        <label for="name">Nombre de la Tarjeta</label>
        <input type="text" name="name" id="nameTarjeta"/>
    </fieldset>
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
            <div id="cuerpoTa">
                <div class="contInicioTrelloTa">
                    <div id="tablero">
                        <sql:setDataSource var="snapshop" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/noteal" user="root" password="s3cr3tsyst3mlog"/>
                        <sql:query var="result"  scope="session" dataSource="${snapshop}">
                            SELECT tablero.alcance, tablero.idCreador, tablero.nombre FROM tablero WHERE id = <%out.print(request.getParameter("idTablero").toString());%> AND idcreador = <%out.print(session.getAttribute("idUsuario").toString());%>;
                        </sql:query>
                        <c:choose>
                            <c:when test="${result.getRowCount() == 0}">
                                <div class="ErrorTablero"> La página que desea abrir no existe. </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="row" items="${result.rowsByIndex}">
                                    <c:choose>
                                        <c:when test="${row[0]==2}">
                                            <div class="ErrorTablero"> La página se redireccionara a equipo. </div>
                                        </c:when>
                                        <c:when test="${row[0]==3}">
                                            <div class="ErrorTablero"> La página se redireccionara a Público. </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="datosTablero">
                                                ${row[2]}
                                            </div>
                                            <sql:query var="resultLista" scope="session" dataSource="${snapshop}">
                                                SELECT lista.id, lista.nombre, lista.posicion FROM lista WHERE idTablero= <%out.print(request.getParameter("idTablero").toString());%> ORDER BY posicion;
                                            </sql:query>

                                            <div class="contenedor-listas">
                                                <c:forEach var="row" items="${resultLista.rowsByIndex}">
                                                    <div class="container-list" id="IIDL${row[0]}">
                                                        <div class="lista">
                                                            <div class="header-list">
                                                                <h3> ${row[1]} </h3> <span class="Eliminar" id="IDL${row[0]}" onclick="iddd = this.id; console.log(iddd);">Eliminar Lista/span>
                                                            </div>
                                                            <div class = "contenedor-tarjetas" id="T${row[0]}">
                                                                <sql:query var="resultTarje" scope="session" dataSource="${snapshop}">
                                                                    SELECT tarjeta.nombre, tarjeta.id FROM tarjeta WHERE idLista = ${row[0]} ORDER BY posicion;
                                                                </sql:query>
                                                                <c:forEach var="rowT" items="${resultTarje.rowsByIndex}">
                                                                    <div class="tarjeta" id="IT${rowT[1]}" onclick="alerta(this);" >
                                                                        ${rowT[0]} <br>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                            <div id="NT${row[0]}" class = "nueva-tarjeta" onclick="agregarID(this);">
                                                                Añadir nueva tarjeta...
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <div class="create-new-container" id="IDT<%out.print(request.getParameter("idTablero").toString());%>">
                                                crear nueva lista...
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
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
