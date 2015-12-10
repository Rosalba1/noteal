<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%
    if(session.getAttribute("idUsuario")==null || session.getAttribute("idUsuario").toString().equals("0")){
        response.sendRedirect("primeroRegistrate.jsp");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style/estiloCabecera.css">
        <link rel="stylesheet" type="text/css" href="style/estiloCuerpo.css">
        <link rel="stylesheet" type="text/css" href="style/estiloPie.css">
        <title>NoteAL</title>
    </head>
    <body style="background-color: #E6E6FA;">
        <div class="contenidoPrincipal">
            <div id="cabecera">
                <div id="menuInicio">
                    <ul>
                        <li><a href="index.jsp">INICIO</a></li>
                        
                    </ul>
                </div>
                <div id="contRegistro">
                </div>
            </div>
            <div id="cuerpo">
                <div class="contInicioTrello">
                    Hola: ______________<br>
                    Antes de poder disfrutar de NoteAl primero confirma tu correo electronico, en tu bandeja de entrada.
                </div>
                <div class="conInicioTelloSlider">
	
                   
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
