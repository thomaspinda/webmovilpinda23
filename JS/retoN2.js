let Nota1 = prompt("Ingrese la primera nota: ");
let Nota2 = prompt("Ingrese la segunda nota: ");
let Nota3 = prompt("Ingrese la tercera nota: ");

if(!isNaN(Nota1) && !isNaN(Nota2) && !isNaN(Nota3) && Nota1>1 && Nota1<7 && Nota2>1 && Nota2<7 && Nota3>1 && Nota3<7){
    let N1 = Nota1*0.4;
    let N2 = Nota2*0.3;
    let N3 = Nota3*0.3;
    let pp = N1+N2+N3;
    alert("Su promedio ponderado es de: "+ pp);
    if(pp<3.95){
    alert("Usted ha reprobado la asignatura");
    }
    if(pp>3.95 && pp<4.95){
    alert("Usted debe dar examen");
    }
    if(pp>4.95){
    alert("Usted ha aprobado");
    }
}
else{
    alert("Ingrese un valor valido");
};
