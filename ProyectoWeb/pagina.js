function pagina2(){
    window.location.href = "pagina2.html";
};


function botonEntrar(){
    let usuario = document.getElementById("Usuario");
    let entrar = document.getElementById("Entrar");

    let contraseña = document.getElementById("Contraseña");
    function contraseñaValida(con){
        return /[a-z]/.test(con) && /[A-Z]/.test(con) && /\d/.test(con)
    }

    if(usuario.value.trim() !== "" && contraseña.value.trim() !== "" && contraseñaValida(contraseña.value)){
        entrar.removeAttribute("disabled");
    }
    else {
        entrar.setAttribute("disabled", "disabled");
    }
}
function botonTutorial(){
    window.location.href = "pagina4.html";
}
let puntos = 1;
function botonGeografia(){
    window.location.href = "pagina3.html";
}
let preguntasJSON = "preguntas.json";
let preguntas = [];
let preguntaActual = 0;

function cargarPreguntas(){
    fetch(preguntasJSON)
    .then(function(response){
        return response.json();
    })
    .then(function(data){
        preguntas = data.preguntas;
        mostrarPregunta(preguntaActual);
    })
}
function mostrarPregunta(indice){
    const preguntaContainer = document.getElementById("pregunta-container");
    const preguntaElement = document.getElementById("pregunta");
    const respuestasForm = document.getElementById("respuestas-form");
    const siguientePreguntaButton = document.getElementById("siguiente-pregunta");
    if(indice < preguntas.length){
        const pregunta = preguntas[indice];
        preguntaElement.textContent = pregunta.pregunta;

        for(let i = 1; i <= 4; i++){
            const opcionID = "opcion" + i;
            const labelID = "label" + i;
            const input = document.getElementById(opcionID);
            const label = document.getElementById(labelID);

            if(i <= pregunta.respuestas.length){
                input.style.display = "block";
                label.textContent = pregunta.respuestas[i-1];
                label.style.display = "block";
            } else{
                input.style.display = "none";
                label.style.display = "none";
            }
        }
        siguientePreguntaButton.style.display = "block";
        siguientePreguntaButton.disabled = true;
        respuestasForm.reset();
        preguntaContainer.style.display = "block";
    }else{
        preguntaContainer.style.display = "none";

    }

}
function manejarRespuesta() {
    const selectedAnswer = document.querySelector('input[name="respuesta"]:checked');
  
    if (selectedAnswer) {
      siguientePreguntaButton.disabled = false;
      const respuesta = selectedAnswer.nextElementSibling.textContent;
      const pregunta = preguntas[preguntaActual];
  
      if (respuesta === pregunta.respuesta_correcta) {
        console.log("¡Respuesta correcta!");

        return console.log(puntos++);;
      } else {
        console.log("Respuesta incorrecta. La respuesta correcta es: " + pregunta.respuesta_correcta);
        return console.log(puntos--);
    }
    } else {
      siguientePreguntaButton.disabled = true;
    }
  }
const siguientePreguntaButton = document.getElementById("siguiente-pregunta");
siguientePreguntaButton.addEventListener("click", function () {
    document.getElementById("Puntos").innerHTML = puntos;
    manejarRespuesta();
    preguntaActual++;
    if(preguntaActual>=preguntas.length){
        window.location.href="pagina5.html";
    }else{
    mostrarPregunta(preguntaActual);
    }
});

const respuestasInputs = document.querySelectorAll('input[name="respuesta"]');
respuestasInputs.forEach(function (input) {
  input.addEventListener("change", manejarRespuesta);
});
  
window.onload = cargarPreguntas;
