$(function() {
    var name = $( "input[name=name]" ),
        allFields = $( [] ).add( name),
        tips = $( ".validateTips" );

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
        if ( !( regexp.test( o.val() ) ) ) {
            o.addClass( "ui-state-error" );
            updateTips( n );
            return false;
        } else {
            return true;
        }
    }

    $( "#dialog-form" ).dialog({
        autoOpen: false,
        height: 300,
        width: 350,
        modal: true,
        buttons: {
            "Crear un tablero": function() {
                var bValid = true;
                allFields.removeClass( "ui-state-error" );

                bValid = bValid && checkLength( name, "nombre del tablero", 3, 16 );

                bValid = bValid && checkRegexp( name, /^[a-z][A-Z]([0-9a-z_/s])+$/i, "El nombre del tablero consiste de a-z, A-Z, 0-9." );

                if ( bValid ) {
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
    
    $( "#create-table-personal" )
        .click(function() {
            $( "#dialog-form" ).dialog( "open" );
        });
});
