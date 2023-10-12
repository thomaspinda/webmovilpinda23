let puntuacion = prompt("Ingrese puntuacion");
if(!isNaN(puntuacion)){
    let sueldo = 350000*puntuacion;
    if(puntuacion == 0.0 || puntuacion == 0.2 || puntuacion == 0.4 || puntuacion == 0.6 || puntuacion == 0.8){
        if(puntuacion == 0.0 || puntuacion == 0.2){
            alert("Su nivel de rendimiento es insuficiente, su sueldo es de "+ sueldo);
        }
        if(puntuacion == 0.4){
            alert("Su nivel de rendimiento es aceptable, su sueldo es de "+ sueldo);
        }
        if(puntuacion == 0.6){
            alert("Su nivel de rendimiento es meritorio, su sueldo es de " + sueldo);
        }
        if(puntuacion == 0.8){
            alert("Su nivel de rendimiento es excelente, su sueldo es de " + sueldo);
        }
    }
    else{
        alert("Puntuacion no aceptada");
    }
}
else{
    alert("Valor no aceptado");
}
//------------------------------------------
let frase =  prompt("Ingrese una frase");
let x = 0;
if(isNaN(frase)){
    let letra = prompt("Ingrese una letra");
        if(isNaN(letra)){

        for (let i = 0; i < frase.length; i++) {
            if(letra == frase[i]){
                x++;
            }
        }
        if( x > 1 ){
            alert("La frase tiene " + x + " letras " + letra);
        }
        if(x == 1){
            alert("La frase tiene " + x + " letra " + letra);
        }
        if(x == 0){
            alert("La frase no contiene la letra " + letra);
        }
    }
    else{
        alert("Letra no aceptada")
    }
}
else{
    alert("Frase no aceptada")
}
//---------------------------------------------------------



let nickname = prompt("Ingrese un nickname:");
let may = false;
let min = false;
let c = false;

if(nickname.length < 6){
    alert("El nickname debe tener al menos 6 caracteres de longitud");
}
for (let j = 0; j < nickname.length; j++) {
    if(isNaN(nickname[0]) && !isNaN(nickname[nickname.length-1])){
        c = true;
    }

}
if (c == true && may == true && min == true){
    alert("nickname aceptado");
}
else{
    alert("Nickname invalido");
}


//----------------------------------------------------------------------

let val = prompt("Ingrese el valor a calcular");
let porc = prompt("Ingrese el porcentaje");

if(!isNaN(val) && !isNaN(porc) && porc.length > 0){
    var total = parseInt(val) + (val * (porc/100));
    alert("El total de la factura es de "+ total);
}
if(!isNaN(val) && porc.length == 0){
    var total = parseInt(val) + (val * 0.19);
    alert("El total de la factura es de "+ total);
}
