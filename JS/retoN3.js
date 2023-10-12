
let porcentaje = (document.getElementById('porcentajes'));


document.getElementById("Boton").addEventListener("click",function(){
let total = document.getElementById("Total");
console.log(valueOf(total));
document.getElementById("propina").innerHTML = "Propina"+ total*porcentaje
}
);