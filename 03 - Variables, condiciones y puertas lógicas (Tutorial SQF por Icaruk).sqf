
// Os pedí esto:

// Vale pues, quiero el código y una screen en el foro que muestre un hint parecido a esto:

Hola me llamo <Tunombre>.
Soy del bando <Tubando>.
Mi variable1 vale <valor>,
Mi variable2 vale <valor>.

Y su suma es <suma>.


Pene.

// Solución 1, visualmente fácil, ocupando bastante espacio

	hint format ["
		Hola me llamo %1.\n
		Soy del banco %2.\n
		Mi variable1 vale %3,\n
		Mi variable2 vale %4.\n\n
		
		Y su suma es %5.\n\n\n
		
		
		Pene.
	",
		name player, 
		side player,
		var1,
		var2, 
		var1 + var2	
	];

// Solución 2, visualmente normal, ocupando espacio normal

	hint format ["
		Hola me llamo %1.\n
		Soy del banco %2.\n
		Mi variable1 vale %3,\n
		Mi variable2 vale %4.\n\n
		Y su suma es %5.\n\n\n
		Pene.
	", name player, side player, var1, var2, var1 + var2];

// Solución 3, visualmente es una jodida línea, ocupando... una línea

	hint format ["Hola me llamo %1.\nSoy del banco %2.\nMi variable1 vale %3,\nMi variable2 vale %4.\n\nY su suma es %5.\n\n\nPene.", name player, side player, var1, var2, var1 + var2];

// Hay más soluciones, pero serían mezclas de las 3 que he puesto.

/*
Seguimos con variables
Ya sabemos que si hacemos
var1 = algo
var1 va a valer algo
también puedo decir que una variable valga lo que otra variable
var1 = var2
*/

// La cosa está es que si salimos y entramos de la misión, var1 y var2 no valdrán nada
// bueno, esas y cualquiera que tengamos
// ahora mismo ponemos en monitor

pene

// y no va a devolver nada, es nil
// nil es nada, no vale nada
// acabas de aprender a borrar una variable.
// ejecutas

pene = 1;

// miras monitor y ha cambiado su valor
// ejecutas

pene = nil;

// miras su valor, y no tiene valor
// igual que las variables lucas, paco, asdfg y cualquier mierda que te inventes.
// si no defines una variable (hacer var1 = algo), será nil, no existirá

// ejecutas

num1 = 10; 
num2 = 5;

// vamos a ver en monitor los siguientes operators

10 > 5
10 == 10
num1 > num2
num1 < num2
num1 == num2
num1 == num1
3 > 3
3 >= 3
3 >= 2
10 != 10
10 != 999999


/*
> mayor que
< menor que
== igual que
>= mayor o igual que
<= menor o igual que
!= no igual que
*/

// devolverá true o false según si es verdad o mentira
// true o false es otro data type: BOOL

/*
recopilamos los data types hasta ahora:

string "hola"
numero 123
bool true/false
*/


// todo esto nos lleva a las condiciones
// una condicion es una pregunta que al final será true o false, 1 o 0 en binario, abierta o cerrada en la puerta

/*
empezamos por el if
	if (condicion) then {cosas};
	
si la condición es verdad hago cosas

si (tengoDinero) entonces {comproCosas};
if (tengoDinero) then {comproCosas};

*/

//ejecuta cada línea por separado
if (true) then {hint "¡Verdad1!"};
if (false) then {hint "¡Verdad2!"};
if (1 == 1) then {hint "¡Verdad3!"};
if (10 > 1) then {hint "¡Verdad4!"};
if (10 != 10) then {hint "¡Verdad5!"};
if (1 + 1 == 2) then {hint "¡Verdad6!"};
if ("Hola" == "Hola") then {hint "¡Verdad7!"};
if ("HOLA" == "hola") then {hint "¡Verdad8!"};
if ("HOLA" isEqualTo "hola") then {hint "¡Verdad9!"};
if (1 isEqualTo 1) then {hint "¡Verdad10!"};
if !(true) then {hint "¡Mentira!"}; // ! delante de una condición es una negación. Realmente estoy preguntando si TRUE no es TRUE xD.

// El texto de verdad2 no debería de haber aparecido, porque le hemos dado directamente la respuesta: no
// El texto de verdad5 no debería de haber aparecido porque 10 es igual a 10, y estamos preguntando si 10 es diferente de 10, respuesta: no (false)
// El texto de verdad9 tampoco debería de haber aparecido porque el comando isEqualTo sí que distingue mayúsculas de minúsculas
// Más ejemplos por si acaso:


//ejecuto
num1 = 10; 
num2 = 5;

// ejecuta por separado
if (num1 == 10) then {hint "La variable num1 es 10"};
if (num2 == 10) then {hint "La variable num2 no es 10 (es 5, pero no he preguntado eso)"};
if (num1 == num2) then {hint "Las variable num1 y num2 no son iguales"};

// Bien, ya tenemos algo de control sobre lo que ocurre pero queremos más
// queremos hacer muchas preguntas

if (num1 == 10) then {hint "Verdad 1"};
if (num1 != 9999) then {hint "Verdad 2"};
if (num1 >= 10) then {hint "Verdad 3"};
if (num1 < 9999) then {hint "Verdad 4"};

// esto no nos renta, porque hemos hecho 4 preguntas, para hacer 4 cosas iguales, pero por separado
// queremos hacer una gran pregunta y hacer una sola cosa

/*
puertas lógicas: agrupar condiciones con AND y &&
	condición AND condición
	condición && condición
	
es lo mismo

	si ((tengoDinero) Y (puedoGastarlo)) entonces {comproCosas};
	if ((tengoDinero) AND (puedoGastarlo)) then {comproCosas};
	
*/

// miramos esto en monitor

num1 == 10 AND num1 != 999

// y dará true, porque num1 es 10 AND no es 999
// si lo usamos en un if puede ir de varias formas:

if (num1 == 10 AND num1 != 999) then {};
if ((num1 == 10) AND (num1 != 999)) then {};

/*
más puertas lógicas: agrupar condiciones con OR y || (este símbolo se escribe con ALTGR + 1)
	condición OR condición
	condición || condición
	
es lo mismo

	si ((tengoDinero) O (meInvitan)) entonces {comproCosas};
	if ((tengoDinero) OR (meInvitan)) then {comproCosas};
	
También se puede poner con menos paréntesis:

	if (tengoDinero OR meInvitan) then {comproCosas};
*/

// miramos esto en monitor

2 > 1 OR 1 > 9999999999999

// 2 es mayor que 1
// 1 no es mayor que 9999999999999
// va a dar true, porque haces dos preguntas, si cualquiera de las dos es verdad, la "puerta" se abre

// ejemplos con if

if (10 == 10 OR 999 == 1) then {};
if (num1 == 10 OR num2 == 999) then {};


/*
Teniendo en cuenta que:
	num1 vale 10
	num2 vale 5

Quiero que me pongáis el código de un hint que diga el nombre de mi jugador y mi bando, en dos líneas diferentes...
¡PERO!
que sólo se ejecute si se cumplen todas estas condiciones:
	num1 es 10
	num2 es 5
	num1 y num2 no sean iguales
	num1 o num2 sean menores que 20
	
*/

// Pista: agrupar las condiciones por bloques, para que cada bloque formado por pequeños bloques parecidos den true o false













