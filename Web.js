function botonRegistro(){
    window.location.href = "registrar.html";
}
function botonVolver(){
    document.body.style.background = "linear-gradient(to left,#322caf, #010100)";
    document.getElementById('Categorias').style.display = 'block';
    document.getElementById("Tutorial").style.display = "none";
}
function Home(){
    window.location.href = "Home.html";
}
function imagenHistoria(){
    let imagen = document.getElementById("Historia");
    imagen.style.left = "50%";
    imagen.style.transform= "translate(-50%)";
}
function imagenHistoriaFuera(){
    let imagen = document.getElementById("Historia");
    imagen.style.left = "-400px";
}

function imagenPeliculas(){
    let imagen = document.getElementById("Peliculas");
    imagen.style.left = "50%";
    imagen.style.transform= "translate(-50%)";

}
function imagenPeliculasFuera(){
    let imagen = document.getElementById("Peliculas");
    imagen.style.left = "-750px";
}
function imagenGeografia(){
    let imagen = document.getElementById("Geografia");
    imagen.style.left = "50%";
    imagen.style.transform= "translate(-50%)";
}
function imagenGeografiaFuera(){
    let imagen = document.getElementById("Geografia");
    imagen.style.left = "-750px";
}
function imagenMatematicas(){
    let imagen = document.getElementById("Matematicas");
    imagen.style.left = "50%";
    imagen.style.transform= "translate(-50%)";

}
function imagenMatematicasFuera(){
    let imagen = document.getElementById("Matematicas");
    imagen.style.left = "-750px";
}
function imagenCiencias(){
    let imagen = document.getElementById("Ciencias");
    imagen.style.left = "50%";
    imagen.style.transform= "translate(-50%)";

}
function imagenCienciasFuera(){
    let imagen = document.getElementById("Ciencias");
    imagen.style.left = "-750px";
}
function botonEntrar(){
    let usuario = document.getElementById("Usuario");
    let entrar = document.getElementById("Entrar");
    let contrasena = document.getElementById("Contrasena");
    function contrasenaValida(con){
        return /[a-z]/.test(con) && /[A-Z]/.test(con) && /\d/.test(con)
    }
    if(usuario.value.trim() !== "" && contrasena.value.trim() !== "" && contrasenaValida(contrasena.value)){
        entrar.removeAttribute("disabled");
    }
    else {
        entrar.setAttribute("disabled", "disabled");
    }
}
function botonHistoria(){
    document.getElementById("Categorias").style.display = "none";
    document.getElementById("preguntasHistoria").style.display = "Block";
}
function botonGeografia(){
    document.getElementById("Categorias").style.display = "none";
    document.getElementById("preguntasGeografia").style.display = "Block";
}
function botonMatematicas(){
    document.getElementById("Categorias").style.display = "none";
    document.getElementById("preguntasMatematicas").style.display = "Block";
}
function botonPeliculas(){
    document.getElementById("Categorias").style.display = "none";
    document.getElementById("preguntasPeliculas").style.display = "Block";}
function botonCiencias(){
    document.getElementById("Categorias").style.display = "none";
    document.getElementById("preguntasCiencias").style.display = "Block";}

function pH1(){
    window.location.href = "Historia1.html";
}
function pH2(){
    window.location.href = "Historia2.html";
}
function pH3(){
    window.location.href = "Historia3.html";
}
function pM1(){
    window.location.href = "Matematicas1.html";
}
function pM2(){
    window.location.href = "Matematicas2.html";
}
function pM3(){
    window.location.href = "Matematicas3.html";
}
function pG1(){
    window.location.href = "Geografia1.html";
}
function pG2(){
    window.location.href = "Geografia2.html";
}
function pG3(){
    window.location.href = "Geografia3.html";
}
function pP1(){
    window.location.href = "Peliculas1.html"
}
function pP2(){
    window.location.href = "Peliculas2.html"
}
function pP3(){
    window.location.href = "Peliculas3.html"
}
function pC1(){
    window.location.href = "Ciencias1.html";
}
function pC2(){
    window.location.href = "Ciencias2.html";
}
function pC3(){
    window.location.href = "Ciencias3.html";
}


