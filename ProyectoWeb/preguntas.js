let preguntasJSON = "preguntas.json";
let preguntas = [];
let preguntaActual = 0;
let puntos = 0;

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
        window.location.href = "pagina2.html";
    }
}
function manejarRespuesta() {
    const selectedAnswer = document.querySelector('input[name="respuesta"]:checked');
  
    if (selectedAnswer) {
      const respuesta = selectedAnswer.nextElementSibling.textContent;
      const pregunta = preguntas[preguntaActual];
  
      if (respuesta === pregunta.respuesta_correcta) {
        puntos++;
        const puntosElement = document.getElementById("puntos");
        puntosElement.textContent = puntos;
        preguntaActual++;
        mostrarPregunta(preguntaActual);
        console.log(preguntaActual);
      } else {
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