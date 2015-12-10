$(document).ready(function() {
    // Al presionar cualquier tecla en cualquier campo de texto, ejectuamos la siguiente función
    $('input').on('keydown', function(e){
        if(e.keyCode === 13){
            // Obtenemos el número del tabindex del campo actual
            var currentTabIndex = $(this).attr('tabindex');
            // Le sumamos 1 :P
            var nextTabIndex    = parseInt(currentTabIndex) + 1;
            // Obtenemos (si existe) el siguiente elemento usando la variable nextTabIndex
            var nextField       = $('[tabindex='+nextTabIndex+']');
            // Si se encontró un elemento:
            if(nextField.length > 0){
                // Hacerle focus / seleccionarlo
                nextField.focus();
                // Ignorar el funcionamiento predeterminado (enviar el formulario)
                e.preventDefault();
            }
            // Si no se encontro ningún elemento, no hacemos nada (se envia el formulario)
        }
    });
});

function validarNuevoUsuario(){
    var correo = document.forms[0].correo.value;
    var nombre = document.forms[0].nombre.value;
    var password = document.forms[0].password.value;
    var errores = "";
    
    if(!validaSoloTexto(nombre))
        errores = errores +"->El nombre no es valido.\n";
    
    if(password.length<3)
        errores = errores +"->El password debe de tener mínimo tres caracteres.\n";
    
    if(!validaEmail(correo))
        errores = errores +"->El correo ingresado no es valido.\n";
    
    if(errores.length > 2){
        alert(errores);
        return false;
    }
}

function validaSoloTexto(cadena){
    var patron = /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]{3,30}$/;
    if(!cadena.search(patron))
      return true;
    else
      return false;
}

function validaEmail(correoElectronico){
    var patron = /^([a-z]+[a-z0-9._-]*)@{1}([a-z1-9\.]{2,})\.([a-z]{2,3})$/;
    if(!correoElectronico.search(patron))
      return true;
    else
      return false;
}

function validarInicio(){
    var correo = document.forms[0].username.value;
    var password = document.forms[0].password.value;
    var errores = "";
    
    if(password.length<3)
        errores = errores +"->El password debe de tener mínimo tres caracteres.\n";
    
    if(!validaEmail(correo))
        errores = errores +"->El correo ingresado no es valido.\n";
    
    if(errores.length > 2){
        alert(errores);
        return false;
    }
}

function validarInicioDos(){
    var correo = document.forms[1].username.value;
    var password = document.forms[1].password.value;
    var errores = "";
    
    if(password.length<3)
        errores = errores +"->El password debe de tener mínimo tres caracteres.\n";
    
    if(!validaEmail(correo))
        errores = errores +"->El correo ingresado no es valido.\n";
    
    if(errores.length > 2){
        alert(errores);
        return false;
    }
}
