
/*
Consejo N++

Si haces doble click en una palabra, se seleccionará esa palabra y se iluminarán todas las que sean iguales.
Muy útil para saber dónde se está usando X variable.
*/

// Os pedí:

/*
Ahora quiero, el código en spoiler o en pastebin de lo siguiente:

Una tienda como la que hemos hecho (puedes reutilizar el código y cambiarlo o hacer algo diferente)... ¡pero!
que cada ítem de la tienda tenga los siguientes parámetros:
	item
	precio
	stock

Si no queda stock, no puedes comprar el ítem, y si tú vendes ítems, el stock sube.
*/

// Antes aprenderemos dos comandos nuevos:

/*
nuevo comando: isNil
	isNil {variable};
	devuelve BOOL

pregunta si la variable es nil
	
a = 0;
isNil {a}; // da false, porque existe
isNil {b}; // da true, porque NO existe
*/

/*
nuevo comando: private
	private string
	private array

private "_variable";
private ["_var1", "_var2", "_var3"];

Define la(s) variable(s) en el scope actual.

Ejemplo con colorines:
*/

// Caso 1, declaramos en el scope superior:
_a = 0;
if (true) do {
	_a = 2;
	// Aquí _a vale 2
};
// Aquí _a vale 2

// **************

// Caso 2, no declaramos:
if (true) do {
	_a = 2;
	// aquí _a vale 2
};
// ¡Aquí _a no existe!

// **************

// Caso 3, declaramos con private en el scope superior:
private "_a";
if (true) do {
	_a = 2;
	// Aquí _a vale 2
};
// Aquí _a vale 2

// **************

// Caso 4, private en scope inferior:
_a = 2
if (true) do {
	private "_a";
	_a = 99;
	// Aquí _a vale 99
};
// Aquí _a vale 2

// **************


// Solución a partir de mi tienda anterior (de las muchas que hay)
// el array va así: ["item", precio, stock]
// si el stock no está definido, se pondrá en 9999

platano = 1;
manzana = 0;
pera = 0;
kiwi = 0;
agua = 0;
droga = 0;
dinero = 2000;

// tienda.sqf:

if (isNil {tienda}) then { // con esto me aseguro de que si no existe la variable, la defino. Y si ya existe, no hago nada.
	tienda = [["platano", 100, 5], ["manzana", 100, 5], ["pera", 100, 5], ["kiwi", 100, 5], ["agua", 200], ["droga", 1000, 5]];
};

_param = _this select 0;
_que = _this select 1;


private ["_precio", "_stock", "_indice"];

for "_idx" from 0 to (count tienda)-1 do {
	if ((tienda select _idx select 0) == _que) exitWith {
		_precio = tienda select _idx select 1;
		_stock = if (isNil {tienda select _idx select 2}) then {9999} else {tienda select _idx select 2};
		_indice = _idx; // eso lo usaré más tarde para poder encontrar mi item dentro del array tienda
	};
};

if (_param) then {
	if (dinero < _precio) exitWith {hint "No tienes suficiente dinero"};
	if (_stock < 1) exitWith {hint "No queda de eso"};
	
	dinero = dinero - _precio;
	missionNamespace setVariable [_que, (missionNamespace getVariable _que) + 1]; // me añado el ítem
	(tienda select _indice) set [2, (tienda select _indice select 2) - 1]; // bajo stock
	
	hint format ["Gracias por comprar %1 por %2€ (quedan %3 unidades)", _que, _precio, _stock - 1];
} else {
	if ((missionNamespace getVariable _que) <= 0) exitWith {hint "No puedes vender algo que no tienes"};
	
	dinero = dinero + _precio;
	missionNamespace setVariable [_que, (missionNamespace getVariable _que) - 1]; // me resto el ítem
	(tienda select _indice) set [2, (tienda select _indice select 2) + 1]; // subo stock
	
	hint format ["Gracias por vender %1 por %2€ (quedan %3 unidades)", _que, _precio, _stock + 1];
};


/*

*******************************************************

*/

// Funciones, aprendamos a hacer funciones:

miFuncion = {
	cosas;
};

// ya sabemos hacer funciones, ahora aprendamos a llamarlas

call miFuncion; 	// NSE
0 spawn miFuncion; 	// SE

// igual que estoy usando una variable publica, puedo usar una privada, que tendría las mismas propiedades de una variable privada:

_miFUncion = {
	cosas;
};

// y la llamaría igual:

call _miFuncion;
0 spawn _miFuncion;

// Vamos a hacer una función para pasar números de negativo a positivo, ejemplo:

ica_fnc_negToPos = {
	private "_num";

	_num = _this select 0; // esto es el argumento que le meto

	if (_num < 0) then { // si no es negativo, no hago nada
		_num = _num * (-1);
	};

	_num // esto es lo que me devuelve la función, sin ;
};

// Esta la llamaría así:
[-10] call ica_fnc_negToPos; // me devuelve 10

// uso práctico:

_num = -10;
_numeroFinal = [_num] call ica_fnc_negToPos;


// Podría hacerlo de otra forma, para llamarla diferente:

ica_fnc_negToPos = {
	private "_num";

	_num = _this; // esto es el argumento que le meto

	if (_num < 0) then { // si no es negativo, no hago nada
		_num = _num * (-1);
	};

	_num // esto es lo que me devuelve la función, sin ;
};

// Y la llamaría así:
-10 call ica_fnc_negToPos; // me devuelve 10

// Edit: ver comando "abs". Hace lo mismo y lo descubrí hace poco xD.

// ¿Porqué uso private? Porque llamar a una función es como si copiaras y pegaras el código de la función en el lugar que la llamas. 
// Entonces algunas variables podrían interferirse aunque sean privadas (_var)
// Por ejemplo si uso _pepinos en un script y llamo a una función que usa _pepinos, el _pepinos de la función me puede sobreescribir el _pepinos del script.

// Al ser una variable, podría modificarla en todo momento y volver a llamarla. Pudiendo realizar cambios "en vivo".

/*
nuevo comando: compileFinal

miFuncion = compileFinal {
	cosas;
};
miFuncion = compileFinal "
	cosas;
";

Convierte una variable en una constante, impidiendo modificarla.
Muchas veces se pueden sustituir los {} por "" o por ''.
Por ejemplo en el isNil "var" es lo mismo que isNil {var}.
Pero el problema de usar "" es que todo lo de dentro que lleve comillas tendrá que llevar comillas ""dobles"".
Y si se usan 'simples' lo de dentro tendrá que ir con "normales".

Pero tranqui, que el arma te dará un error que no tiene nada que ver con eso y ahora al menos sabrás porqué.

ejemplos a colores:
*/

funcion = {
	_this = "string";
};

funcion = "
	_this = ""string"";
";

funcion = '
	_this = "string";
';


// Hay una forma de compilar las funciones, al inicio de la partida, usando un .sqf por cada función
// https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Adding_a_Function
// es un coñazo, pero es lo que hay que hacer con misiones grandes.


// Os recuerdo que si usamos call para llamar a una función que tenga interrupciones (sleep, waitUntil...) no se esperará, spawn sí que lo hará.
// Cuando hacemos call, es más rápido porque es como si copiaras y pegaras código dentro del script, pero cuando hacemos spawn, creamos un "hilo"
// paralelo y ahí ejecutamos cosas, por eso es más lento.


/*
Ahora os voy a pedir algo sencillito, para compensar estos dos últimos xD

Quiero una función útil.
Ya sea de matemáticas, de equiparte ítems... lo que sea. Tú le metes argumentos y ella hace cosas útiles.

Por ejemplo, cosas que tuve que hacerme:
	- Una función para que me dijese de una lista de objetos, posiciones o markers, cuál era el más cercano a mi jugador.
	- Una función que cuente los ítems de X classname que tenga en mi inventario.
	- Una función que me une getPos y getMarkerPos en el mismo comando.
	
¡Que vuele la imaginación... y google!
*/

