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
        <script type="text/javascript" src="engine1/jquery.js"></script>
	<script type="text/javascript" src="js/validacionRegistroUsuario.js"></script>
	
        <title>Registro</title>
    </head>
    <body style="background-color: #E6E6FA;">
        <div class="contenidoPrincipal">
            <div id="cabecera">
                <div id="menuInicio">
                    <ul>
                        <li><a href="index.jsp">INICIO</a></li>
                        <li><a href="#">VISITA GUIADA</a></li>
                        <li><a href="#">BLOG</a></li>
                    </ul>
                </div>
                <div id="contRegistro">
                    <a href="registrarUsuario.jsp"><input type="button" id="btnRegistro" class="btnRegistro" value="Registrarse"></a>
                    <input type="button" id="btnIniciarSesion" class="btnIniciarSesion" value="Iniciar Sesión" onclick="return desplegarFormulario();">
                </div>
            </div>
            <div id="cuerpo">
                <div class="contInicioTrello">
                    <div class="contAux">
                        <div class="conAux2">
                            <div class="contInicioLogo">
                                <div class="logotipo">
                                    <div class="registro" id="registro">
                                        <div class="subRegistro" id="subRegistro">
                                            <html:form action="formRegistro">
                                                Correo:<br><html:text property="correo"></html:text><br>
                                                Nombre:<br><html:text property="nombre"></html:text><br>
                                                Password:<br><html:password property="password"></html:password><br>
                                                <html:errors property="error"></html:errors>
                                                <div class="btnRegistrar"><html:submit value="Registrar" onclick="return validarNuevoUsuario();"></html:submit></div>
                                            </html:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="logeo" id="logeo" style="display: none;">
                            <div class="sublogin" id="sublogin">
                                <html:form action="formLogin">
                                    Usuario:<br> <html:text property="username"></html:text><br>
                                    Password:<br><html:password property="password"></html:password><br>
                                    <html:errors property="loginInvalido"></html:errors>
                                    <div class="btnRegistroLogin"><html:submit value="Iniciar sesión" onclick="return validarInicioDos()"></html:submit></div>
                                    
                                </html:form>
                            </div>
                        </div>
                    </div>
                    
                    <script type="text/javascript">
                        function desplegarFormulario(){
                            document.getElementById('logeo').style.display = 'block';
                        }
                    </script>
                </div>
                <div class="conInicioTelloSlider">
                    <div id="wowslider-container1">
                        <div class="ws_images"><ul>
                            <li><img src="data1/images/img1.png" alt="" title="" id="wows1_0"/></li>
                            <li><a href="http://wowslider.com"><img src="data1/images/img2.png" alt="http://wowslider.com/" title="" id="wows1_1"/></a></li>
                            <li><img src="data1/images/img3.png" alt="" title="" id="wows1_2"/></li>
                        </ul></div>
                        <div class="ws_bullets"><div>
                            <a href="#" title=""><span><img src="data1/tooltips/img1.png" alt=""/>1</span></a>
                            <a href="#" title=""><span><img src="data1/tooltips/img2.png" alt=""/>2</span></a>
                            <a href="#" title=""><span><img src="data1/tooltips/img3.png" alt=""/>3</span></a>
                        </div></div><div class="ws_script" style="position:absolute;left:-99%"><a href="http://wowslider.net">jquery carousel</a> by WOWSlider.com v8.5</div>
                        <div class="ws_shadow"></div>
                    </div>	
                    <script type="text/javascript" src="engine1/wowslider.js"></script>
                    <script type="text/javascript" src="engine1/script.js"></script>
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
