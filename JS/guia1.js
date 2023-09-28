let numero = prompt('Ingrese un numero entero positivo');
n = 2;
x = 0;
while(n < numero){
    x +=n
    n +=2;
}
alert("el resultado es: " + x);

let oracion = prompt('Ingrese una oración');
let c = oracion.split(' ').length;
alert('La oración contiene '+ c +' palabras');
let contraseña = prompt('Cree una contraseña(Esta debe contener valores alfanumericos y almenos una mayuscula');
let mayusculas = false;
let minusculas = false;
let numeros = contraseña.match(/\d+/g);

for (let i = 0; i < contraseña.length; i++) {
  if (contraseña[i] === contraseña[i].toUpperCase()) {
    mayusculas = true;
  } else if (contraseña[i] === contraseña[i].toLowerCase()) {
    minusculas = true;
  }

}
if(mayusculas == true && minusculas == true && isNaN(numeros)==true){
    alert("Contraseña valida");
}
if(mayusculas == false){
    alert("La contraseña debe tener almenos una mayuscula");
}
if(isNaN(numeros)==false){
    alert("La contraseña debe tener almenos un número");
}

let lista = prompt("Ingrese una lista de numeros separados por comas")
let z = 0;
for(i=0; i < lista.length;i++){
  if(lista[i] > z){
    z = lista[i]
  }
}
alert("El numero más grande de la lista es " + z);

let estatura = prompt("Ingrese su estatura(en metros)");
let peso = prompt("Ingrese su peso(en kilos)");
let imc = (peso / (estatura*estatura));
if(imc<18.5){
alert("su indice de masa corporal es de " + imc + ", usted se encuentra en la categoria de bajo peso");
}
if(18.5<imc<24.9){
  alert("su indice de masa corporal es de " + imc + ", usted se encuentra en la categoria normal de peso");
}
if(imc>24.9){
  alert("su indice de masa corporal es de " + imc + ", usted se encuentra en la categoria de sobrepeso");
}
