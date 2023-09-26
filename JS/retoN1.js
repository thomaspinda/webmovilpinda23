let numero = prompt('Ingrese un número');
if(!isNaN(numero) || Number.isInteger(numero)){

if(numero % 2 == 0){
    alert(numero + " es par");
}
if(numero % 2 != 0){
    alert(numero + " es impar");
}
}
else{
    alert("ingrese un numero valido")
}