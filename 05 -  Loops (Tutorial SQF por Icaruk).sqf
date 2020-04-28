
// Os pedí:

// Ahora quiero que partiendo de que mi variable es un array

var = ["cosa"];

// añadáis a ese array las siguientes cosas:
// vuestro nombre de jugador
// vuestro bando
// la salud de vuestro soldado (comando damage, podéis buscar o probar directamente)
// la posición de vuestro soldado (comando getPos, podéis buscar o probar directamente)

// no vale hacer var = ["cosa", name player...] es trampa xD

// y al final del todo, poned una screen de un hint que diga en la primera frase todo vuestro array
// y en la segunda frase cuántos elementos tiene

// solución 1:

var pushBack (name player);
var pushBack (side player);
var pushBack (damage player);
var pushBack (getPos player);

hint format ["Mi array es %1\n Y tiene %2 elementos", var, count var];

// solución 2:

var = var + [name player, side player, damage player, getPos player];

hint format ["Mi array es %1\n Y tiene %2 elementos", var, count var];

// posible error:

var pushBack [name player, side player, damage player, getPos player];

// prueba y verás

/*
con esto lo que haremos será a nuestro array
	[ [meterle otro array] ]
en lugar de incluir elementos dentro de él

es decir, en realidad estamos haciendo esto:
*/

var = [[] + [name player, side player, damage player, getPos player]];

/*
nuevo comando: while
	while {condicion} do {cosas};
	
mientras {tengaDinero} hago {comprar};
while {tengaDinero} do {comprar}; 

atento, que aquí la condición no va con () sino con {}
*/

// pero claro, el bucle va a estar activo hasta que la condición deje de cumplirse o hasta que le digamos que se salga.
// Un bucle infinito que petaría el arma (puedes probar voluntariamente, te la podría haber jugado, pero soy bueno) sería:
	while {true} do {hint "boom"};
	
// mientras la verdad sea verdad, es decir siempre, nuestro un hint aparecerí.
// Nuestro amigo sleep nos ayudará

	while {true} do {
		hint "hola";
		sleep 5;
	};

// ¿te acuerdas de que en la consola no podía leer pausas porque era NSE (non-scheduled environment)?
// había que usar un spawn (SE), pues easy, lo metemos todo dentro de un spawn

0 spawn {
	while {true} do {
		hint "hola";
		sleep 5;
	};
};

/*
el spawn siempre necesita un argumento, aunque el argumento sea nada (nil), pero ese nada ya es algo para él
puede ir así:
	"" spawn {};
	0 spawn {};
	[] spawn {};
 
 el del 0 es el más rápido de escribir, por eso lo uso
 */
 
// entonces podemos hacer un temporizador tal que así:
// (hasta que no quitemos el menú de pausa, todo estarí congelado)

0 spawn {
	tiempo = 5;
	
	while {tiempo > 0} do {
		tiempo = tiempo - 1;
		hint format ["Tiempo: %1", tiempo];
		sleep 1;
	};
	
	hint "El tiempo se ha acabado";
};
	
// podemos observar que hasta que no salga del while, no sigue leyendo, se queda ahí atrapado dando vueltas

/*
nuevo comando: for 
	for "_variable" from numero to numero do {cosas};
	
para "_vueltas" desde 0 hasta 9 haz {puesDiezVueltasxD};
for "_vueltas" from 0 to 9 do {puesDiezVueltasxD};
*/

// con esto podemos hacer el temporizador de otra forma

0 spawn {
	tiempo = 5;
	
	for "_vueltas" from 0 to 4 do {
		tiempo = tiempo - 1;
		hint format ["Tiempo: %1", tiempo];
		sleep 1;
	};
};

/*
¡Anda! _variable
si tiene _ delante, significa que sólo estará disponible dentro de ese mismo scope
es decir, "_vueltas" sólo existiría dentro de los {} del for, fuera de ahí no existiría
pero esto lo explicaremos a fondo más tarde
*/

// ahora podemos hacer que ocurran cosas cuando queramos

0 spawn {
	tiempo = 10;
	
	while {true} do {
		tiempo = tiempo - 1;
		hint format ["Tiempo: %1", tiempo];
		
		sleep 1;	
	};
	
	if (tiempo <= 1) then {
		tiempo = 10;
		hint "El tiempo no baja de 1";
	};	
};

// Eh, eh , eh, ¡el tiempo se me pone en negativo!
// Primero, sal de la misión y entra, para salir del loop

/*
comando nuevo: exitWith
	if (condicion) exitWith {mevoy};
	sirve para salir del scope actual
	
if (noTengoDinero) exitWith {noEntroEnLaDiscoteca};
*/

// vamos a probar lo siguiente para enterlo mejor:


0 spawn {
	tiempo = 10;
	
	if (tiempo == 10) exitWith {
		hint "Pues me voy del spawn, y no leo nada m�s";
	};
	
	while {true} do {
		tiempo = tiempo - 1;
		hint format ["Tiempo: %1", tiempo];
		
		sleep 1;	
	};
	
	if (tiempo <= 1) then {
		tiempo = 10;
		hint "El tiempo no baja de 1";
	};	
};

// la línea 169 está dentro de los {} del spawn, es su scope (los scopes los estamos marcando con tabulaciones)
// y al hacer exitWith saldría de ahí, intentando leer la 186, en la cual acaba el spawn

// ahora entenderemos mejor qué es el scope

0 spawn {
	tiempo = 10;
	
	if (tiempo == 10) then {
		if (tiempo == 10) exitWith {
			hint "Pues me voy del if, y sigo leyendo abajo";
			sleep 3;
		};
	};
	
	while {true} do {
		if (tiempo <= 1) exitWith {
			hint "Salgo del loop";
			sleep 3;
		};
		
		tiempo = tiempo - 1;
		hint format ["Tiempo: %1", tiempo];
		
		sleep 1;	
		
		if (tiempo <= 1) then {
			tiempo = 10;
			hint "El tiempo no ha bajado de 1";
			sleep 2;
		};	
	};
};

// ahí, el exitWith sólo se estaría saliendo del scope de los {} del if que tiene en 195.

// vale ahora quiero el código en spoiler de un temporizador
// que muestre minutos y segundos (usando hint format), da igual cómo, 1:15 o 1m15s o en varias líneas.
// pero que tenga 1 minuto y 10 segundos y que cuando llegue a 0 ejecute la siguiente línea

titleText ["La luz se apaga", "BLACK", 5];





