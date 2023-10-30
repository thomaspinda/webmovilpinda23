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
function botonGeografia(){
    window.location.href = "pagina3.html";
}const contenedorInfo = document.getElementById("contenedorInfo");

function botonInfo() {
  if (contenedorInfo.style.display === "block") {

    contenedorInfo.style.display = "none";
  } else {
    contenedorInfo.style.display = "block";
  }
};

