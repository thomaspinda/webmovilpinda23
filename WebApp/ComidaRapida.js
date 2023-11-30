Hamburguesa = document.getElementById("Hamburguesa");
Pizza = document.getElementById("Pizza");
HotDog = document.getElementById("HotDog");
Ensalada = document.getElementById("Ensalada");
Papas = document.getElementById("Papas");


function Calculado(){
    ValorHam = Hamburguesa.value*3000;
    ValorPiz = Pizza.value*4200;
    ValorHot = HotDog.value*2500;
    ValorEns = Ensalada.value*1600;
    ValorPap = Papas.value*2000;
    if(ValorHam < 0 || ValorPiz < 0 || ValorHot < 0 || ValorEns < 0 || ValorPap < 0){
        alert("¡Error!: no ingrese valores negativos")
        document.getElementById("Total").innerText = ""
        document.getElementById("IVA").innerText = ""
        document.getElementById("Neto").innerText = ""
    }
    else{
    Total = ValorHam + ValorPiz + ValorHot + ValorEns + ValorPap;
    Neto = Total/1.19;
    IVA = Total-Neto;
    document.getElementById("Total").innerText = "Total a Pedir: $"+Total;
    document.getElementById("IVA").innerText = "IVA: $"+IVA.toFixed(2);
    document.getElementById("Neto").innerText ="Valor Neto: $"+ Neto.toFixed(2);
    }
}
