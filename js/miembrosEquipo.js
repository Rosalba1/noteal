var idUsuario = 0;
var idEquipo = 0;

$(document).ready(function() {
$('#IdnombreCurso').keyup(function(tecla){
    if(document.getElementById('IdnombreCurso').value.length === 0){
        document.getElementById('opR_cont_MC').style.display = 'none';
    }else{
        if(tecla.keyCode>=48 && tecla.keyCode<=57 ||tecla.keyCode>=96 && tecla.keyCode<=105 || tecla.keyCode==189 || tecla.keyCode==191 || tecla.keyCode == 8){
            $("#resultadoClave").load('obtenerMiembros.jsp',{valor1: document.getElementById('IdnombreCurso').value, valor2:'nombre'});
            document.getElementById('opR_cont_MC').style.display = 'block';
            y=-1;
        }else if(tecla.keyCode===40 || tecla.keyCode ===38){
            if(tecla.keyCode === 40){
                y++;
                if(y>document.querySelectorAll('#resultadoClave li').length-1){
                    y=0;
                } 
            }else{
                y--;
                if(y<0){
                    y=document.querySelectorAll('#resultadoClave li').length-1;
                }
            }
            $('#resultadoClave li').attr('class','ikk');
            document.querySelectorAll('#resultadoClave li')[y].className = 'opcionResultadoTecla';
        }else if(tecla.keyCode ==13){

            document.getElementById('IdnombreCurso').value = $('#resultadoClave ul li').eq(y).text();
            document.getElementById('opR_cont_MC').style.display = 'none';
        }
    }
    });
$('#resultadoClave').on('click','li',function (){
    var oID = $(this).attr("id");
    document.getElementById('opR_cont_MC').style.display = 'none';
});
$('#resultadoClave').on('mouseover','li',function (){
    $('#resultadoClave li').attr('class','ikk');
    var oID = $(this).attr("id");
    y = oID;
    document.querySelectorAll('#resultadoClave li')[oID].className = 'opcionResultadoTecla';
});

$('#btnQuitar').on('click',function (){
    $("#resultadoClave").load('eliminarMiembro.jsp',{valor1: document.getElementById('IdnombreCurso').value, valor2:'nombre'});
});

});


function  agregarUsuario(){
    //Se va a mandar el id del usuario y la id del equipo
    idEquipo = document.getElementsByClassName("cabeceraE")[0].id;
    console.log(idUsuario);
    console.log(idEquipo);
}

