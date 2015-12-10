var iddd;
$(function() {
    var name = $( "#name" ),
        allFields = $( [] ).add( name ),
        tips = $( ".validateTips" );
        
    var nameT = $( "#nameTarjeta" ),
        allFieldsT = $( [] ).add( nameT ),
        tipsT = $( ".validateTips" );

    function updateTips( t ) {
        tips
            .text( t )
            .addClass( "ui-state-highlight" );
        setTimeout(function() {
            tips.removeClass( "ui-state-highlight", 1500 );
        }, 500 );
    }

    function checkLength( o, n, min, max ) {
        if ( o.val().length > max || o.val().length < min ) {
            o.addClass( "ui-state-error" );
            updateTips( "El tamaño del " + n + " debe tener entre " + min + " y " + max + " caracteres." );
            return false;
        } else {
            return true;
        }
    }

    function checkRegexp( o, regexp, n ) {
        if(!o.val().search(regexp)){
            return true;
        }else{
            o.addClass( "ui-state-error" );
            updateTips( n );
            return false; 
        }
    }

    $( "#dialog-form" ).dialog({
            autoOpen: false,
            height: 300,
            width: 350,
            modal: true,
            buttons: {
                "Crear una lista": function() {
                    var bValid = true;
                    allFields.removeClass( "ui-state-error" );
                    bValid = bValid && checkLength( name, "nombre del tablero", 3, 50 );
//                    bValid = bValid && checkRegexp( name, /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]$/, "El nombre del tablero consiste de a-z, A-Z, 0-9." );
                    if ( bValid ) {
                        var req = new XMLHttpRequest();
                        req.open('POST', 'nuevaListaE', true);
                        
                        req.onload = function () {
                            var datos = JSON.parse(this.response);
                            console.log(datos);
                            document.getElementsByClassName('contenedor-listas')[0].innerHTML+=("<div class=\"container-list\">\n" +
                            "        <div class=\"lista\">\n" +
                            "            <div class=\"header-list\">\n" +
                            "                <h3> "+datos.nombre+" </h3>\n" +
                            "            </div>\n" +
                            "            \n" +
                            "            <div class = \"contenedor-tarjetas\" id=\"T"+datos.IdLista+"\"> \n"  +
                            "            </div>\n" +
                            "            <div id=\"NT"+datos.IdLista+"\" class = \"nueva-tarjeta\" onclick=\"agregarID(this);\">  \n" +
                            "                Añadir nueva tarjeta...\n" +
                            "            </div>\n" +
                            "        </div>\n" +
                            "    </div>");
                            $( ".contenedor-listas" ).sortable();
                            $( ".contenedor-tarjetas" ).sortable({ connectWith: ".contenedor-tarjetas" });
                            $( ".nueva-tarjeta" ).click(function(){ $( "#dialog-form-tarjeta" ).dialog("open"); });
                        };
                        req.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
                        req.send("idTablero="+obtenerIDTablero().substring(3)+"&nombre="+document.getElementById("name").value+"&posicion="+obtenerPocicion());
                        $( this ).dialog( "close" );
                    }
                },
                Cancelar: function() {
                    $( this ).dialog( "close" );
                }
            },
            close: function() {
                    allFields.val( "" ).removeClass( "ui-state-error" );
            }
    });

    $( ".create-new-container" )
        .click(function() {
            $( "#dialog-form" ).dialog( "open" );
        });
        
    $( "#dialog-form-tarjeta" ).dialog({
            autoOpen: false,
            height: 300,
            width: 350,
            modal: true,
            buttons: {
                "Agregar tarjeta": function() {
                    var bValid = true;
                    allFieldsT.removeClass( "ui-state-error" );
                    bValid = bValid && checkLength( nameT, "nombre del tablero", 3, 50 );
//                    bValid = bValid && checkRegexp( nameT, /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]$/, "El nombre de la tarjeta consiste de a-z, A-Z, 0-9." );
                    if ( bValid ) {
                        var req = new XMLHttpRequest();
                        req.open('POST', 'nuevaListaE', true);
                        console.log("va a ir a la bd");
                        req.onload = function () {
                            console.log("Regreso de la BD");
                            var datos = JSON.parse(this.response);
                            document.getElementById(iddd).innerHTML+=("<div class=\"tarjeta\" id=\"IT"+datos.IdTarjeta+"\">"+ datos.nombre + "<br></div>");
                            $( ".contenedor-listas" ).sortable();
                            $( ".contenedor-tarjetas" ).sortable({ connectWith: ".contenedor-tarjetas" });
                            $(".nueva-tarjeta").click(function(){ $("#dialog-form-tarjeta").dialog("open");});
                        };
                        req.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
                        req.send("idLista="+iddd.substring(1)+"&nombre="+document.getElementById("nameTarjeta").value+"&posicion="+document.getElementById(iddd).children.length);
                        $( this ).dialog( "close" );
                    }
                },
                Cancelar: function() {
                    $( this ).dialog( "close" );
                }
            },
            close: function() {
                allFieldsT.val( "" ).removeClass( "ui-state-error" );
            }
    });
    $( "#dialog-confirm" ).dialog({
            resizable: false,
            height:160,
            autoOpen:false,
            modal: true,
            buttons: {
                "Eliminar la lista": function() {
                    var req = new XMLHttpRequest();
                    req.open('POST', 'EliminarP', true);

                    req.onload = function () {

                    };
                    req.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
                    req.send("idLista="+iddd.substring(1)+"&nombre="+document.getElementById("nameTarjeta").value+"&posicion="+document.getElementById(iddd).children.length);
                    var nodoAEliminar = document.getElementById('I'+iddd);
                    console.log(iddd.substring(2));
                    nodoAEliminar.parentNode.removeChild(nodoAEliminar);
                    $( this ).dialog( "close" );
                },
                Cancelar: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
    $( ".nueva-tarjeta" )
        .click(function() {
            $( "#dialog-form-tarjeta" ).dialog( "open" );
        });
        
    $(".Eliminar")
        .click(function (){
             $( "#dialog-confirm" ).dialog("open");
        })
        .button({
            icons: {
                primary: "ui-icon-close"
            },
            text: false
        });
});

function agregarID(e){
    iddd = e.id.substring(1);
    console.log(iddd);
}

function obtenerPocicion(){
    return document.getElementsByClassName('lista').length;
}

function obtenerIDTablero(){
    return document.getElementsByClassName('create-new-container')[0].id;
}

function alerta(e){
    console.log(e);
}

$(function() {
    $( ".contenedor-listas" ).sortable({
        update: function(){ 
            var ordenElementos = $(this).sortable("toArray"); 
            var req = new XMLHttpRequest();
            req.open('POST', 'moverTarjetaE', true);

            req.onload = function () {
//                console.log("Se ha movido en la bd");
            };
            req.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
            req.send("nuevoOrden="+ordenElementos+"&idTablero="+obtenerIDTablero().substring(3));
        } 
    });
    $( ".contenedor-tarjetas" ).sortable({
        connectWith: ".contenedor-tarjetas",
        update: function(){ 
            var ordenElementos = $(this).sortable("toArray"); 
            if(ordenElementos.length > 0){
                var req = new XMLHttpRequest();
                req.open('POST', 'moverTarjetaE', true);

                req.onload = function () {
                    console.log("Se ha movido en la bd");
                };
                req.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
                req.send("nuevoOrdenL="+ordenElementos+"&idTablero="+obtenerIDTablero().substring(3)+"&idLista="+document.getElementById(ordenElementos[0]).parentNode.id);
            }
        } 
    });
});

var evtSource = new EventSource("CambiosEquipo");
evtSource.onmessage = function(e){
    var data = JSON.parse(e.data);
    if(data.idMensaje==idMensaje){
        var received = data.user + ":  "+data.text +"\n";
        document.getElementById('mensajes').value+=(received);
    }
};

evtSource.addEventListener('nuevaTarjeta', function(e){
    var data = JSON.parse(e.data);
    var nuevoTema = document.createElement('div');
    nuevoTema.setAttribute('class', "temaChat");
    nuevoTema.setAttribute('id', data.nombreTema);
    nuevoTema.setAttribute('onclick', "idMensaje="+"\""+data.nombreTema+"\"; limpiar();");
    nuevoTema.appendChild(document.createTextNode(data.nombreTema));
    var ultimo_div = document.getElementById("nuevoTemaConversacion");
    document.getElementsByClassName('temas')[0].insertBefore(nuevoTema,ultimo_div);
});


evtSource.addEventListener('nuevaLista', function(e){
    var data = JSON.parse(e.data);
    var nuevoTema = document.createElement('div');
    nuevoTema.setAttribute('class', "temaChat");
    nuevoTema.setAttribute('id', data.nombreTema);
    nuevoTema.setAttribute('onclick', "idMensaje="+"\""+data.nombreTema+"\"; limpiar();");
    nuevoTema.appendChild(document.createTextNode(data.nombreTema));
    var ultimo_div = document.getElementById("nuevoTemaConversacion");
    document.getElementsByClassName('temas')[0].insertBefore(nuevoTema,ultimo_div);
});

evtSource.addEventListener('nuevoTarjeta', function(e){
    var data = JSON.parse(e.data);
    var nuevoTema = document.createElement('div');
    nuevoTema.setAttribute('class', "temaChat");
    nuevoTema.setAttribute('id', data.nombreTema);
    nuevoTema.setAttribute('onclick', "idMensaje="+"\""+data.nombreTema+"\"; limpiar();");
    nuevoTema.appendChild(document.createTextNode(data.nombreTema));
    var ultimo_div = document.getElementById("nuevoTemaConversacion");
    document.getElementsByClassName('temas')[0].insertBefore(nuevoTema,ultimo_div);
});

evtSource.addEventListener('nuevoLista', function(e){
    var data = JSON.parse(e.data);
    console.log(data);
});

evtSource.addEventListener('EliminarLista', function(e){
    var data = JSON.parse(e.data);
    var nuevoTema = document.createElement('div');
    nuevoTema.setAttribute('class', "temaChat");
    nuevoTema.setAttribute('id', data.nombreTema);
    nuevoTema.setAttribute('onclick', "idMensaje="+"\""+data.nombreTema+"\"; limpiar();");
    nuevoTema.appendChild(document.createTextNode(data.nombreTema));
    var ultimo_div = document.getElementById("nuevoTemaConversacion");
    document.getElementsByClassName('temas')[0].insertBefore(nuevoTema,ultimo_div);
});


evtSource.addEventListener('EliminarTarjeta', function(e){
    var data = JSON.parse(e.data);
    var nuevoTema = document.createElement('div');
    nuevoTema.setAttribute('class', "temaChat");
    nuevoTema.setAttribute('id', data.nombreTema);
    nuevoTema.setAttribute('onclick', "idMensaje="+"\""+data.nombreTema+"\"; limpiar();");
    nuevoTema.appendChild(document.createTextNode(data.nombreTema));
    var ultimo_div = document.getElementById("nuevoTemaConversacion");
    document.getElementsByClassName('temas')[0].insertBefore(nuevoTema,ultimo_div);
});
