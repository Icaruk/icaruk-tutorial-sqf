
// os pedí:

/*
No sé si este escalón será demasiado, pero ahora quiero el código en spoiler o un pastebin de lo siguiente:

Una tienda como la que hemos hecho, pero que en lugar de sólo comprar y vender plátanos, tenga mínimo 6 ítems.
Hay que usar arrays para sacar los precios de los items, por ejemplo:
	[item, precio, item, precio]
	[[item, precio], [item, precio]]

Que cuando compres o vendas te diga algún mensaje como:
	Gracias por <comprar o vender> <item>, te ha costado <precio>

*/

// posible solución (mejorable ahora después)

// variables:

platano = 1;
manzana = 0;
pera = 0;
kiwi = 0;
agua = 0;
droga = 0;

dinero = 1000;

// tienda.sqf:

_param = _this select 0;
_que = _this select 1;

_tienda = [["platano", 100], ["manzana", 100], ["pera", 100], ["kiwi", 100], ["agua", 200], ["droga", 1000]];
_precio = 0;

for "_idx" from 0 to (count _tienda)-1 do { // _idx va a ir subiendo de 0 hasta (6-1)
	if ((_tienda select _idx select 0) == _que) exitWith {
		_precio = _tienda select _idx select 1;
	};
};

if (_param) then {
	if (dinero < _precio) exitWith {hint "No tienes suficiente dinero"};
	
	dinero = dinero - _precio;
	
	switch (_que) do {
		case "platano": {platano = platano + 1};
		case "manzana": {manzana = manzana + 1};
		case "pera": {pera = pera + 1};
		case "kiwi": {kiwi = kiwi + 1};
		case "agua": {agua = agua + 1};
		case "droga": {droga = droga + 1};
	};	
	
	hint format ["Gracias por comprar %1 por %2€", _que, _precio];
} else {
	if (
		((_que == "platano") AND (platano <= 0)) OR
		((_que == "manzana") AND (manzana <= 0)) OR
		((_que == "pera") AND (pera <= 0)) OR
		((_que == "kiwi") AND (kiwi <= 0)) OR
		((_que == "agua") AND (agua <= 0)) OR
		((_que == "droga") AND (droga <= 0))
	) exitWith {hint "No puedes vender algo que no tienes"};

	dinero = dinero + _precio;
	
	switch (_que) do {
		case "platano": {platano = platano - 1};
		case "manzana": {manzana = manzana - 1};
		case "pera": {pera = pera - 1};
		case "kiwi": {kiwi = kiwi - 1};
		case "agua": {agua = agua - 1};
		case "droga": {droga = droga - 1};
	};
	
	hint format ["Gracias por vender %1 por %2€", _que, _precio];
};

// ejecuto con:
[true, "platano"] execVM "tienda.sqf";

// compruebo mis variables mirando este array
[dinero, platano, manzana, pera, kiwi, agua, droga]

// -----------------------------------------------------------
// _tabla lo podría hacer de otra forma:

/*
nuevo comando: find
	array find elemento
	string find elemento
	
["a", "b", "c"] find "b" // devuelve 1
"hola" find "o" // devuelve 1
*/

_tienda = ["platano", 100, "manzana", 100, "pera", 100, "kiwi", 100, "agua", 200, "droga", 1000];
_precio = 0;

_idx = _tienda find _que;
_precio = _tienda select (_idx + 1);

// el problema de esto es que si queremos ampliar el array con elementos, por ejemplo:
// que los precios de compra y venta sean diferentes

_tienda = ["platano", 100, 50, "pera", 100, 50, ... ]

// tendría que poner el nuevo elemento para toooodas las cosas de la tienda, con el sistema que he utilizado arriba:

_tienda = [["platano", 100, 50], ["pera", 100] ... ]

// puedo decir, por ejemplo: si pera no tiene 3 elementos, es que no se puede vender
// pero vamos, hay  mil millones de formas de hacer esto.

// Para hablar de la optimización del código, vamos a comentar unas cuantas cosas, muy útiles:
// La optimización puede ser visual o de rendimiento, aquí hablo de ambas.

/*
Sin optimizar:

	_deboDinero = true;
	
	if (dinero >= 0) then {
		_deboDinero = false;
	} else {
		_deboDinero = true;
	};

Optimizado

	_deboDinero = if (dinero >= 0) then {false} else {true};

Da igual ponerlo en varias líneas, pero como así se queda tan corto y es fácil de leer, mejor en una

Esto pasa lo mismo con switch:

	_estado = switch (dinero) do {
		case 0: {"pobre"};
		case 3000: {"normal"};
		case 10000: {"rico"};
		case 999999: {"millonario"};
	};

*/

/*
nuevo comando: getVariable / setVariable
	namespace getVariable "variable"
	namespace setVariable ["variable", valor, public];

missionNamespace será la "caja" que contiene todas las variables que hemos estado usando hasta ahora (sólo las que no tienen _)
lo de public por defecto está en false, pero si queremos que la variable sea pública es decir, que todos los ordenadores
la sepan, sería lo mismo que hacer << publicVariable "variable" >> pero bueno, ya iremos viendo eso xD

entonces, preguntar en monitor:
	missionNamespace getVariable "dinero";
	
será lo mismo que preguntar por:
	dinero
	

De igual forma que:
	missionNamespace setVariable ["dinero", 100];

será lo mismo que:
	dinero = 100;
	
	
La ventaja de usar setVariable y getVariable es que podemos formar la variable mediante format:

	_prefijo = "din";
	_sufijo = "ero";

	missionNamespace getVariable (format ["%1%2", _prefijo, _sufijo]);
	
Ahora cambiamos _sufijo por lo que queramos y podemos preguntar infinitas variables, en una línea.	
*/

// Ahora vamos a optimizar la tienda que he puesto antes:


// tienda.sqf:

_param = _this select 0;
_que = _this select 1;

_tienda = [["platano", 100], ["manzana", 100], ["pera", 100], ["kiwi", 100], ["agua", 200], ["droga", 1000]];

_precio = for "_idx" from 0 to (count _tienda)-1 do { // _idx va a ir subiendo de 0 hasta (6-1)
	if ((_tienda select _idx select 0) == _que) exitWith { // estoy en el array que contiene mi _que
		_tienda select _idx select 1; // selecciono el precio de mi _que
	};
};

if (_param) then {
	if (dinero < _precio) exitWith {hint "No tienes suficiente dinero"};
	
	dinero = dinero - _precio;
	missionNamespace setVariable [_que, (missionNamespace getVariable _que) + 1];	
	
	hint format ["Gracias por comprar %1 por %2€", _que, _precio];
} else {
	
	if ((missionNamespace getVariable _que) <= 0) exitWith {hint "No puedes vender algo que no tienes"};

	dinero = dinero + _precio;
	missionNamespace setVariable [_que, (missionNamespace getVariable _que) - 1];	
	
	hint format ["Gracias por vender %1 por %2€", _que, _precio];
};


// Joder, ahora sí que es fácil meter 10000000 elementos en la lista, porque ya no se depende
// del código de la tienda, sólo del array que contiene ítems, precios y demás parámetros.

// Se puede hacer más por optimizar, como por ejemplo hacer las preguntas indicadas en el momento indicado, 
// no vale de nada, por ejemplo, preguntar lo mismo 3 veces a lo largo del script, hay que buscar el sitio o la forma
// de poder hacer la pregunta sólo una vez.

// Otra forma de hacer esto...
_precio = for "_idx" from 0 to (count _tienda)-1 do { // _idx va a ir subiendo de 0 hasta (6-1)
	if ((_tienda select _idx select 0) == _que) exitWith { // estoy en el array que contiene mi _que
		_tienda select _idx select 1; // selecciono el precio de mi _que
	};
};

// ...es con un forEach:

/*
nuevo comando: forEach
	{comandos} forEach array;
	
{meComo _x} forEach _caramelos;
{_x setDamage 1} forEach [player, paco, antonio];


Esa última línea sería lo mismo que:

	player setDamage 1;
	paco setDamage 1;
	antonio setDamage 1;


forEach tiene varias variables reservadas:
	_x sería el elemento actual del array que estamos mirando.
	_forEachIndex sería el select por el que vamos.
	
Imagínate que tienes 100 unidades a las que hacer eso, pues las metes en un array y con un forEach le aplicas todo lo que quieras a todas.
Cuando digo unidades, pueden ser variables o lo que sea.
*/

_precio = 0; // declaro precio en el scope superior
{ 	// esto va a recorrer cada uno de los elementos de tienda
	// en la primera vuelta _x sería ["platano", 100], en la segunda vuelta ["manzana", 100], y así hasta el final.
	if ((_x select 0) == _que) exitWith { // (primera vuelta)-->  (["platano", 100] select 0) es "platano", y lo comparo con _que
		_precio = _x select 1; // si coinciden, exitWith y selecciono el select 1 para obtener el precio
	};
} forEach _tienda;

// Que es lo mismo que...

_precio = ({
	if ((_x select 0) == _que) exitWith {
		_x select 1;
	};
} forEach _tienda);





/*
Ahora quiero, el código en spoiler o en pastebin de lo siguiente:

Una tienda como la que hemos hecho (puedes reutilizar el código que te he puesto y cambiarlo o hacer algo diferente)... ¡pero!
que cada ítem de la tienda tenga los siguientes parámetros:
	item
	precio
	stock

Si no queda stock, no puedes comprar el ítem, y si tú vendes ítems, el stock sube.
El mensaje de cuando compras y vendes, te tiene que informar del stock actual del ítem que has comprado/vendido.

Es bastante complicado, yo me he tenido que comer un poco la cabeza, PERO AQUÍ VENIMOS A COMERNOS LA CABEZA.
*/



