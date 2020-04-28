
/*
Consejo N++

Si haces doble click en una palabra, se seleccionar� esa palabra y se iluminar�n todas las que sean iguales.
Muy �til para saber d�nde se est� usando X variable.
*/

// Os ped�:

/*
Ahora quiero, el c�digo en spoiler o en pastebin de lo siguiente:

Una tienda como la que hemos hecho (puedes reutilizar el c�digo y cambiarlo o hacer algo diferente)... �pero!
que cada �tem de la tienda tenga los siguientes par�metros:
	item
	precio
	stock

Si no queda stock, no puedes comprar el �tem, y si t� vendes �tems, el stock sube.
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
	// Aqu� _a vale 2
};
// Aqu� _a vale 2

// **************

// Caso 2, no declaramos:
if (true) do {
	_a = 2;
	// aqu� _a vale 2
};
// �Aqu� _a no existe!

// **************

// Caso 3, declaramos con private en el scope superior:
private "_a";
if (true) do {
	_a = 2;
	// Aqu� _a vale 2
};
// Aqu� _a vale 2

// **************

// Caso 4, private en scope inferior:
_a = 2
if (true) do {
	private "_a";
	_a = 99;
	// Aqu� _a vale 99
};
// Aqu� _a vale 2

// **************


// Soluci�n a partir de mi tienda anterior (de las muchas que hay)
// el array va as�: ["item", precio, stock]
// si el stock no est� definido, se pondr� en 9999

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
		_indice = _idx; // eso lo usar� m�s tarde para poder encontrar mi item dentro del array tienda
	};
};

if (_param) then {
	if (dinero < _precio) exitWith {hint "No tienes suficiente dinero"};
	if (_stock < 1) exitWith {hint "No queda de eso"};
	
	dinero = dinero - _precio;
	missionNamespace setVariable [_que, (missionNamespace getVariable _que) + 1]; // me a�ado el �tem
	(tienda select _indice) set [2, (tienda select _indice select 2) - 1]; // bajo stock
	
	hint format ["Gracias por comprar %1 por %2� (quedan %3 unidades)", _que, _precio, _stock - 1];
} else {
	if ((missionNamespace getVariable _que) <= 0) exitWith {hint "No puedes vender algo que no tienes"};
	
	dinero = dinero + _precio;
	missionNamespace setVariable [_que, (missionNamespace getVariable _que) - 1]; // me resto el �tem
	(tienda select _indice) set [2, (tienda select _indice select 2) + 1]; // subo stock
	
	hint format ["Gracias por vender %1 por %2� (quedan %3 unidades)", _que, _precio, _stock + 1];
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

// igual que estoy usando una variable publica, puedo usar una privada, que tendr�a las mismas propiedades de una variable privada:

_miFUncion = {
	cosas;
};

// y la llamar�a igual:

call _miFuncion;
0 spawn _miFuncion;

// Vamos a hacer una funci�n para pasar n�meros de negativo a positivo, ejemplo:

ica_fnc_negToPos = {
	private "_num";

	_num = _this select 0; // esto es el argumento que le meto

	if (_num < 0) then { // si no es negativo, no hago nada
		_num = _num * (-1);
	};

	_num // esto es lo que me devuelve la funci�n, sin ;
};

// Esta la llamar�a as�:
[-10] call ica_fnc_negToPos; // me devuelve 10

// uso pr�ctico:

_num = -10;
_numeroFinal = [_num] call ica_fnc_negToPos;


// Podr�a hacerlo de otra forma, para llamarla diferente:

ica_fnc_negToPos = {
	private "_num";

	_num = _this; // esto es el argumento que le meto

	if (_num < 0) then { // si no es negativo, no hago nada
		_num = _num * (-1);
	};

	_num // esto es lo que me devuelve la funci�n, sin ;
};

// Y la llamar�a as�:
-10 call ica_fnc_negToPos; // me devuelve 10

// Edit: ver comando "abs". Hace lo mismo y lo descubr� hace poco xD.

// �Porqu� uso private? Porque llamar a una funci�n es como si copiaras y pegaras el c�digo de la funci�n en el lugar que la llamas. 
// Entonces algunas variables podr�an interferirse aunque sean privadas (_var)
// Por ejemplo si uso _pepinos en un script y llamo a una funci�n que usa _pepinos, el _pepinos de la funci�n me puede sobreescribir el _pepinos del script.

// Al ser una variable, podr�a modificarla en todo momento y volver a llamarla. Pudiendo realizar cambios "en vivo".

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
Pero el problema de usar "" es que todo lo de dentro que lleve comillas tendr� que llevar comillas ""dobles"".
Y si se usan 'simples' lo de dentro tendr� que ir con "normales".

Pero tranqui, que el arma te dar� un error que no tiene nada que ver con eso y ahora al menos sabr�s porqu�.

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


// Hay una forma de compilar las funciones, al inicio de la partida, usando un .sqf por cada funci�n
// https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Adding_a_Function
// es un co�azo, pero es lo que hay que hacer con misiones grandes.


// Os recuerdo que si usamos call para llamar a una funci�n que tenga interrupciones (sleep, waitUntil...) no se esperar�, spawn s� que lo har�.
// Cuando hacemos call, es m�s r�pido porque es como si copiaras y pegaras c�digo dentro del script, pero cuando hacemos spawn, creamos un "hilo"
// paralelo y ah� ejecutamos cosas, por eso es m�s lento.


/*
Ahora os voy a pedir algo sencillito, para compensar estos dos �ltimos xD

Quiero una funci�n �til.
Ya sea de matem�ticas, de equiparte �tems... lo que sea. T� le metes argumentos y ella hace cosas �tiles.

Por ejemplo, cosas que tuve que hacerme:
	- Una funci�n para que me dijese de una lista de objetos, posiciones o markers, cu�l era el m�s cercano a mi jugador.
	- Una funci�n que cuente los �tems de X classname que tenga en mi inventario.
	- Una funci�n que me une getPos y getMarkerPos en el mismo comando.
	
�Que vuele la imaginaci�n... y google!
*/

