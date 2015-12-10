<%
    session.removeAttribute("idUsuario");
    session.removeAttribute("tipoUsuario");
    session.removeAttribute("nombreUsuario");
    response.sendRedirect(""); 
%>
