let preguntasJSON = "preguntasCiencias.json";
let preguntas = [];
let preguntaActual = 0;
let puntos = 0;
let puntosSum = 15;
let interval = 80;
var progressBar = document.getElementById('progress-bar');
var width = 100;
var step = 0.1;
var totalSteps = width / step;
function animateProgressBar() {
    timer = setInterval(function () {
        width -= step;
        progressBar.style.width = width + '%';
        progressBar.setAttribute('aria-valuenow', width);

        if (width <= 0) {
            clearInterval(timer);
            document.body.style.background = "linear-gradient(to left,#322caf, #010100)";
            document.getElementById("Preguntas").style.display = "none";
            document.getElementById("Cargadepuntos").style.display = "block";
            document.getElementById("PuntosAcumulados").value = puntos;
        }
    },interval);
}
function reiniciarBar(){
    clearInterval(timer);
    width = 100;
    progressBar.style.width = width + '%';
    progressBar.setAttribute('aria-valuenow', width);
    animateProgressBar();
}
animateProgressBar()
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
    contadorInicial = 10;
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
        respuestasForm.reset();
        preguntaContainer.style.display = "block";
    }else{
        preguntaContainer.style.display = "none";
        document.body.style.background = "linear-gradient(to left,#322caf, #010100)";
        document.getElementById("Preguntas").style.display = "none";
        document.getElementById("Cargadepuntos").style.display = "block";
        document.getElementById("PuntosAcumulados").value = puntos;

    }
}
function manejarRespuesta() {
    const selectedAnswer = document.querySelector('input[name="respuesta"]:checked');
  
    if (selectedAnswer) {
      const respuesta = selectedAnswer.nextElementSibling.textContent;
      const pregunta = preguntas[preguntaActual];
  
      if (respuesta === pregunta.respuesta_correcta) {
        puntos+=puntosSum;
        const puntosElement = document.getElementById("puntos");
        puntosElement.textContent = puntos;
        preguntaActual++;
        mostrarPregunta(preguntaActual);
        console.log(preguntaActual);
        
      } else
      if(respuesta !== pregunta.respuesta_correcta)  {
        preguntaActual++;
        mostrarPregunta(preguntaActual);
        console.log(preguntaActual);
    }
    }
  }
const respuestasInputs = document.querySelectorAll('input[name="respuesta"]');
respuestasInputs.forEach(function (input) {
  input.addEventListener("change", manejarRespuesta);
});
window.onload = cargarPreguntas;