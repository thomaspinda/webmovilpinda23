function Resultado(){
    let nombr = document.getElementById("Nom").value;
    let pes = document.getElementById("kg").value;
    let alt = document.getElementById("Alt").value;
    let imc = pes/alt**2;
    document.getElementById("ResultadoN").textContent = "Resultado de "+ nombr;
    document.getElementById("ResultadoIMC").textContent = "IMC: "+ imc.toFixed(2);
    if(imc<18,5){
        document.getElementById("ResultadoClas").textContent = "Clasificación: Bajo peso"
    }   document.getElementById("EstadoNutricional").textContent = "Estado nutricional adecuado";
    if(imc<24.9 && imc>18.6){
        document.getElementById("ResultadoClas").textContent = "Clasificación: Peso normal";
        document.getElementById("EstadoNutricional").textContent = "Estado nutricional adecuado";  
    }
    if(imc<29.9 && imc>25){
        document.getElementById("ResultadoClas").textContent = "Clasificación: Sobrepeso";
        document.getElementById("EstadoNutricional").textContent = "Necesita atención especializada";
    }
    if(imc>25){
        document.getElementById("ResultadoClas").textContent = "Clasificación: Obesidad";
        document.getElementById("EstadoNutricional").textContent = "Necesita atención especializada";
    }
    let actividad = document.getElementById("Act");
    let opcion = actividad.options[actividad.selectedIndex].value;
    let ged;
    switch (opcion) {
        case "Sedentario":
            ged = pes*1.2;
            break;
        case "Moderado":
            ged = pes*1.55;
            break;
        case "Activo":
            ged = pes*1.99;
        default:
            break;
    }
    document.getElementById("Gastoenergetico").textContent = "Gasto energetico diario: "+ ged + " kcal";


}   