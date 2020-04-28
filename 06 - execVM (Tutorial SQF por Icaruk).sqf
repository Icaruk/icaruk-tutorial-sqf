
// vale ahora quiero el código en spoiler de un temporizador
// que muestre minutos y segundos (usando hint y format), da igual cómo, 1:15 o 1m15s o en varias líneas.
// pero que tenga 1 minuto y 10 segundos y que cuando llegue a 0 ejecute la siguiente línea

titleText ["La luz se apaga", "BLACK", 5];


// solución 1
// loop infinito, del cual salgo cuando minutos y segundos son 0 y ejecuto lo que hay en el exitWith

0 spawn {
	minutos = 1;
	segundos = 10;

	
	while {true} do {
		
		if ((minutos == 0) AND (segundos == 0)) exitWith {
			titleText ["La luz se apaga", "BLACK", 5];
		};

		if (segundos == 0) then {
			minutos = minutos - 1;
			segundos = 59;
		};

		hint format ["%1:%2", minutos, segundos];
		segundos = segundos - 1;
		sleep 1;
	};
};

// solución 2
// loop con condición, cuando salgo del loop, lee la última línea

0 spawn {
	minutos = 1;
	segundos = 10;
	
	
	while {(minutos >= 0) AND (segundos >= 0)} do {
		
		if ((segundos == 0) AND (minutos > 0)) then {
			minutos = minutos - 1;
			segundos = 59;
		};

		hint format ["%1:%2", minutos, segundos];
		segundos = segundos - 1;
		sleep 1;
	};
	
	titleText ["La luz se apaga", "BLACK", 5];
};

// hay más soluciones, pero ahora no se me ocurren más
// también habéis aprendido un comando nuevo, que voy a ampliar:

/*
comando nuevo: titleText
	titleText [string, efecto, tiempo]
	
ejemplos abajo
*/

// ir probando uno a uno
// si no se pone tiempo, por defecto es 1

titleText ["Texto instantáneo", "PLAIN"]; 
titleText ["Texto poco a poco en 5s", "PLAIN", 5]; 
titleText ["Texto", "PLAIN DOWN"]; 
titleText ["Texto", "BLACK"]; 
titleText ["Texto", "BLACK FADED"]; 
titleText ["Texto", "BLACK IN"]; 
titleText ["Texto", "BLACK OUT"]; 
titleText ["Texto", "WHITE IN"]; 
titleText ["Texto", "WHITE OUT"]; 


// supongo que sabréis cómo se quita la pantalla en negro (o en blanco)... pues sobreescribiendo con un texto sin pantalla en negro xD
// también podéis dejar el texto vacío con este string:

titleText ["", "BLACK", 5]; 

// bla bla bla, ahora nos dejamos de mierdas de escribir código en consola y aprendemos a usar...

/*
nuevo comando: execVM
	argumento execVM ruta
	
execVM "molo.sqf";
execVM "carpeta\molo.sqf";
player execVM "molo.sqf";
"asd" execVM "molo.sqf";
123 execVM "molo.sqf";
[player] execVM "molo.sqf";
*/

// el spawn necesita un argumento, aquí no es necesario
// vamos a crear en nuestra carpeta de misión, en raíz, el archivo "molo.sqf"
// escribimos y guardamos lo siguiente:

hint "Funciona bien, molo";

// Entramos en la misión y ejecutamos lo siguiente:

execVM "molo.sqf";

// y hasta que no quitáis el menú de pausa no ocurre nada.
// Ahora dentro del archivo molo.sqf cambiamos el texto del hint por lo que nos salga de los huevos
// pero que sea algo diferente, y sin salir de la misión, volvéis a ejecutar el execVM
// y os habrá cambiado el texto, al vuelo, mientras jugáis.
// execVM era SC (scheduled environment) y permite pausas en la ejecución, como sleep y waitUntil

/*
comando nuevo: waitUntil
	waitUntil {condicion};

esperaHasta {tenerDinero};
waitUntil {tenerDinero};

comprueba la condición dentro de {} a CADA FRAME
*/

/*
comando nuevo: stance
	stance unidad

stance player
devuelve un string:
	"STAND"
	"CROUCH"
	"PRONE"
*/

// ahora escribimos en nuestro molo.sqf

waitUntil {stance player == "PRONE"};
hint "Te has tumbado";

// cuando ejecutemos, hasta que no nos tumbemos no saldrá nuestro hint
// y una vez que hayamos salido del waitUntil nunca volveremos a él, no es un loop
// es un "sleep especial", un sleep con condición
// podemos impedir que el waitUntil se ejecute a cada frame:

waitUntil {stance player == "PRONE"; sleep 1};
hint "Te has tumbado";

// con esto comprobamos condición, después esperamos 1 sec, y volvemos a repetir
// es decir, al tumbarnos nuestro mensaje puede tardar en aparecer entre 0 y 1 segundos.
// Borramos todo lo que tenemos en molo.sqf y ponemos esto:

hint format ["Argumento(s): \n%1", _this];

// cuando ejecutamos nos dará error, diciendo que _this no está definido...
// ¿y qué cojones es _this?
// _this hace referencia a TODOS los argumentos que le metas
// ahora vamos a cambiar la forma en la que usamos execVM

[] execVM "molo.sqf";

// nos dice que _this es el array vacío que le hemos metido

(name player) execVM "molo.sqf";

// ahora que _this es un string con nuestro nombre

["primero", "segundo", "tercero"] execVM "molo.sqf";

// ahora _this es un array que contiene esos 3 strings
// y ya sabéis seleccionar elementos de un array, así que...

/*
quiero que me paséis una screen o un pastebin con el código de lo siguiente:

el temporizador de una bomba que use los minutos y segundos que le metas como argumentos
a cada segundo te avisa del tiempo que queda
los últimos 3 segundos te avisa con un mensaje diferente
cuando explota se te pone la pantalla en negro
*/

// consejo: reutiliza el temporizador del anterior capítulo xD
