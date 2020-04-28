
// Aclaración: pointer = puntero

// Vuelvo para explicar algo que puede dar problemas si no se conoce.
// Una vez entendido, se puede aprovechar su gran potencial.


// Voy a poner varios ejemplos para que lo podáis entender:


// *************************
// Ejemplo 1 (abstracto):
// *************************

/*

Tu casa (equivaldría al valor de una variable)
	  ____
	 / 	  \
	/      \
	|______|



Tu dirección (equivaldría al pointer)
	C/ Pepito de los Palotes 16, puerta 99


Esa dirección indica dónde está tu casa, si la sigues llegas a ella.
No vas a llevar tu casa a cuestas para enseñarle a alguien dónde vives.
Almacenarías esa dirección en algún sitio (papel, email...) y lo entregarías.

contenedor de dirección --> dirección --> casa

*/



// *************************
// Ejemplo 2 (C++):
// *************************

int numero = 5; // variable con un valor
int *pNumero;	// pointer (sólo declarado, sin valor)

pNumero = &numero; // pNumero ahora contiene la dirección de numero

// pNumero valdría por ejemplo 4561987 (dirección en memoria)
// numero seguiría valiendo 5

numero2 = *numero; // numero2 valdría 5, haciendo el siguiente recorrido:

// numero2 --> 4561987 --> 5
// ¿Te acuerdas del ejemplo 1? Es muy parecido.



// *************************
// Ejemplo 3 (cómic):
// *************************

/*

https://i.imgur.com/vcVFDe0.jpg (doble click para abrir el link)

Manolo tiene un saco de patatas (Manolo es una variable que contiene un valor).
Manolo está cansado porque las patatas pesan mucho.
Manolo deja las patatas y se pira a su casa pensando que mañana volverá a por ellas porque se acuerda de dónde las dejó (ahora Manolo es un pointer).
Rojo le pregunta a Manolo dónde están las patatas (&numero del ejemplo 2).
Manolo señala el lugar en el que dejó las patatas.
Rojo le roba las patatas a Manolo, Manolo se enfada.

rojo --> manolo --> lugar de patatas --> patatas


Si Manolo tuviese que llevar todas las patatas que transporta, no podría cargar con todas ellas.
Manolo es listo y las deja todas en un almacén, sabiendo la localización de todas las patatas.

Por cierto no lo he dicho, Manolo es patatista.

*/



// *************************
// Ejemplo 3 (SQF):
// *************************

// En SQF los pointers sólo se pueden hacer con OJBECTS y ARRAYS.

_veh = "classname" createVehicle (getPos player); // _veh es un pointer del vehículo que acabamos de crear
_veh2 = _veh; // obviamente no hemos clonado el vehículo, sólo tenemos una referencia de la referencia del vehículo.


// Con arrays, primero vamos a experimentar el problema:

0 spawn {
	
	arr = ["a", "b", "c", "d"]; // tengo mi array
	arr2 = arr; // he copiado mi array a otra variable
	
	arr2 deleteAt 3; // borro "d" de la copia de mi array
	
};


// Si observamos los valores resultantes:

arr // ["a","b","c"]
arr2 // ["a","b","c"]


// Resulta que automáticamente, al asignar un valor de tipo ARRAY a una variable,
// la variable no contiene el valor, sino su dirección.



// Ha ocurrido lo siguiente: https://i.gyazo.com/9c05c3be6be8ef2f89a73bebe3ddaee7.png (parte de arriba)

// Primero arr y arr2 apuntan a la misma dirección (de ahí nuestro problema).
// Pero al hacer

arr2 = +arr;

// conseguimos que arr2 apunte a otra dirección que contiene una copia del valor de arr (parte de abajo de la imagen).
// A partir de aquí podríamos modificar arr2 sin tocar arr. Pero ocupará el doble de memoria, obviamente.


// ¿Cómo se rompe un pointer?

0 spawn { 
	
	arr = ["a", "b", "c", "d"];
	arr2 = arr;
	
	arr2 = arr2 + ["e"]; // aquí estaríamos añadiendo un elemento más, pero a su vez romperíamos el pointer porque...
	
	arr2 deleteAt 3;
	
};

// ... estaríamos diciendo:	 arr2 = (el valor al que apunta arr1) + ["e"]
// Ya estamos duplicando.



// Ejemplo práctico:

// Primero MAL, luego BIEN
// Una función que borrará el último elemento del array que le demos, pero sin modificarlo. Es decir nos devuelve el resultado.


fnc_borraUltimoMAL = {
	
	_arr = param [0];
	
	_arr deleteAt ((count _arr) -1);
	_arr
	
};


arr = ["a", "b", "c", "d"];
resultado = [arr] call fnc_borraUltimoMAL;


// Veremos que la función nos ha tocado el array que le hemos dado, y no queríamos eso.
// Ahora lo haremos bien.


fnc_borraUltimoBIEN = {
	
	_arr = +(param [0]);
	
	_arr deleteAt ((count _arr) -1);
	_arr
	
};


arr = ["a", "b", "c", "d"];
resultado = [arr] call fnc_borraUltimoBIEN;


// Veremos que la función va to guay y hace justo lo que queremos.
// Tenemos nuestro array <arr> intacto y <resultado> sin el último elemento.


// La tienda del capítulo 8 se podría hacer "multi-tienda"
// es decir, tener:

tienda1 = [["platano", 100], ["manzana", 100], ["pera", 100], ["kiwi", 100], ["agua", 200], ["droga", 1000]];
tienda2 = [["coche1", 100], ["coche2", 100], ["coche3", 100]];
tienda3 = [["arma1", 100], ["arma2", 100], ["arma3", 100]];

// Al llamar a la tienda se especificaría en qué número de tienda estamos
// y usaríamos un pointer para modificar el array que corresponde.

// No lo voy a hacer porque ya tenéis un nivel suficiente para probarlo vosotros mismos
// y a lo mejor no os apetece hacerlo en ese código inútil y preferís usarlo en algo vuestro que vayáis a usar.

// Hasta aquí el capítulo de hoy, ¡nos leemos otro día!


















<3
