
// os ped�:

/*
quiero que me paséis una screen o un pastebin con el código de lo siguiente:

el temporizador de una bomba que use el los minutos y segundos que le metas como argumentos
a cada segundo te avisa del tiempo que queda
los últimos 3 segundos te avisa con un mensaje diferente
cuando explota se te pone la pantalla en negro
*/

// consejo: reutiliza el temporizador del anterior capítulo xD

// --- solución 1 ---

// molo.sqf
minutos = _this select 0;
segundos = _this select 1;

while {true} do {
	if ((minutos == 0) AND (segundos == 0)) exitWith {
		titleText ["", "BLACK"];
	};

	if (segundos == 0) then {
		minutos = minutos - 1;
		segundos = 59;
	};
	
	if ((minutos == 0) AND (segundos <= 3)) then {
		hint format ["���JODER sólo QUEDAN %1 SEGUNDOS!!!", segundos];
	} else {
		hint format ["%1:%2", minutos, segundos];
	};

	segundos = segundos - 1;
	sleep 1;
};
// la forma de llamarlo:
[1, 5] execVM "molo.sqf"; // el 1 serían minutos y el 5 serían segundos


// --- solución que yo haría ---

// molo.sqf
_minutos = _this select 0;
_segundos = _this select 1;
_texto = "Tiempo restante: %1:%2";

while {true} do {
	if ((_minutos == 0) AND (_segundos == 0)) exitWith {
		titleText ["", "BLACK"];
	};

	if (_segundos == 0) then {
		_minutos = _minutos - 1;
		_segundos = 59;
	};
	
	if ((_minutos == 0) AND (_segundos <= 3)) then {
		_texto = _texto + "\n�Joder!";
	};
	
	hint format [_texto, _minutos, _segundos];
	_segundos = _segundos - 1;
	sleep 1;
};
// la forma de llamarlo:
[1, 5] execVM "molo.sqf";


// ¿porqué uso variables con _ ?
// porque no voy a usar esas variables fuera de ese script, recordamos que si tenía _ sólo existía dentro de ese scope
// una variable normal existe en todos los sitios, en todos los scripts
// pero vamos a darle nombre:

/*
_var variable privada (sólo existe dentro de el script, en el ordenador de quien lo ejecuta)
var variable global (existe para quien ejecuta ese script, en todos los scripts, en el ordenador de quien lo ejecuta)
*/

/*
nuevo comando: switch
	switch (condicion) do {
		case condicion: { cosas};
		case condicion: { cosas};
		case condicion: { cosas};
		default {cosas por defecto}; // esto funciona como un else
	};

	
ejemplo1:

	switch (dinero) do {
		case 100: {tengo100};
		case 500: {tengo500};
		case 1000: {tengo1000};
	};

ejemplo2:
	
	switch (true) do {
		case (dinero > 100): {mayorque100};
		case (dinero > 500): {mayorque500};
		case (dinero > 1000): {mayorque1000};
	};
	
	
Si tenemos que comprobar muchas cosas, es suele ser mejor un switch que un if
porque si ponemos una serie de ifs haciendo mil preguntas, si la primera es verdad, va a seguir preguntando por las 999,
aquí en cuanto una sea verdad, se sale del switch.
*/

// vale, ahora vamos a hacer una pequeña prueba

dinero = 1000;
platano = 2;

// ya tenemos variables globales, ahora toca hacer tienda.sqf

_comprasOvendes = _this select 0;
_miobjeto = _this select 1;

_precio = 0; // digo que _precio es 0, sólo para declararlo en el scope superior, ya que si lo declaro dentro del switch sólo existirá ahí

switch (_miobjeto) do { // aquí, dependiendo del objeto que quiera comprar/vender _precio tendrí un valor u otro
	case "platano": {_precio = 100};
	default {_precio = 0}; // esto era un else, si mi objeto no es "platano" _precio es 0
};

if (_precio == 0) exitWith {hint "No puedes comprar/vender ese objeto"}; // como _miobjeto no está en la lista, no tiene precio, por lo tanto salimos del script

if (_comprasOvendes) then { // true es para comprar
	if (dinero < _precio) exitWith {hint "No tienes suficiente dinero"}; // comprobaciones
	
	dinero = dinero - _precio;
	if (_miobjeto == "platano") then {platano = platano + 1}; // depende de cuál sea _miobjeto, cambiará una variable u otra
} else { // false para vender
	if (_miobjeto == "platano") then { // si _miobjeto es "platano"
		if (platano <= 0) exitWith {hint "No tienes platanos"}; // y mi variable platano es menor o igual que 0, me salgo
		
		platano = platano - 1;
		dinero = dinero + _precio;
	};
};


// y lo llamaría así:
[true, "platano"] execVM "tienda.sqf"; // para comprar
[false, "platano"] execVM "tienda.sqf"; // para vender


/*
No sé si este escalón será demasiado, pero ahora quiero el código en spoiler o un pastebin de lo siguiente:

Una tienda como la que hemos hecho, pero que en lugar de sólo comprar y vender plátanos, tenga mínimo 6 ítems.
Hay que usar arrays para sacar los precios de los items, por ejemplo:
	[item, precio, item, precio]
	[[item, precio], [item, precio]]

Que cuando compres o vendas te diga algún mensaje como:
	Gracias por <comprar o vender> <item>, te ha costado <precio>

*/
