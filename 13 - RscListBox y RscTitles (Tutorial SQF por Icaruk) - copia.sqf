
// Os pedí:

// ¡Deberes!

// Quiero que en este menú, a parte de que el color de _txt cambie
// Cada elemento de la lista, dependiendo de su posición, tenga un color. Es decir:
// Los 3 primeros elementos tienen que ser blancos
// Los 3 siguientes naranjas
// Los 3 últimos rojos

// Investigar un poco en la wiki, que es sólo un comando, si queréis hacer algo más con el menú, sois libres, obviamente.


// Posible solución:
// fn_funcion2.sqf:


disableSerialization;
_ui = uiNamespace getVariable "miPrimerDialog";

_lista = _ui displayCtrl 3000;
_boton = _ui displayCtrl 3001;
_edit = _ui displayCtrl 3002;
_txt = _ui displayCtrl 3003;

_nElementosAntes = lbSize _lista; // antes de añadir el elemento

_textoDelEdit = ctrlText _edit;
hint _textoDelEdit;

_colorLista = switch (true) do { // ¿porqué lo hago así? porque el switch devuelve el el {} del caso que sea true, así que aprovecho diciendo que una variable equivale a lo que devuelve al switch.
	case (_nElementosAntes > 9): {[1, 1, 1, 1]}; // blanco
	case (_nElementosAntes >= 6): {[1, 0, 0, 1]}; // rojo
	case (_nElementosAntes >= 3): {[1, 0.5, 0, 1]}; // naranja
	
	default {[1, 1, 1, 1]} // blanco por defecto
};

// ¿Porqué empiezo del más alto al más bajo?
// Porque el switch en cuanto encuentre algo true, saldrá y no seguirá leyendo, entonces si hubiesen 4 elementos:
// 4 > 3 ¿es true? sí, pues pongo color naranja y me salgo
// Por eso empiezo desde el más alto xD

_lista lbAdd _textoDelEdit;
_lista lbSetColor [_nElementos, _colorLista];

_nElementosDespues = lbSize _lista; // después de añadir el elemento

_txt ctrlSetText (format ["Cantidad de elementos: %1", _nElementosDespues]);



_color = [0, 0, 0, 0]; // este es el color default que pusimos a _txt

if (_nElementosDespues >= 3) then {
	_color = [1, 0.5, 0, 1];

	if (_nElementosDespues >= 6) then {
		_color = [1, 0, 0, 1];
		
		if (_nElementosDespues > 9) then { // es decir, cuando tengamos 10 o más
			lbClear _lista; // limpiamos la lista
			_color = [0, 0, 0, 0];
			_txt ctrlSetText "Cantidad de elementos: 0";
		};
	};
};

_txt ctrlSetBackgroundColor _color;


// ¡Y ya está!
// Pero por si acaso explicaré lbSetColor

/*
_lista lbSetColor [_nElementos, _colorLista];
_control lbSetColor [índice, color];

si en el índice ponéis siempre un 0, el primer elemento (se cuenta como en los arrays) será de ese color.
Pero lo que hacemos es usar de índice el número de elementos que hay antes de añadir el siguiente elemento.

Hay 0 elementos, lbSize es 0.
Añado un elemento, y el índice 0 lo coloreo.

Hay 1 elemento, lbSize es 1.
Añado un elemento, y el índice 1 lo coloreo.

...
*/


// Ahora a partir de un array vamos a crear una lista
// Esto iría en fn_funcion1

_blanco = [1, 1, 1, 1];
_verde = [0.1, 1, 0.1, 1];
_rojo = [1, 0.1, 0.1, 1];

_arrayInfo = [
	["Paco", _rojo, "paco", -100], // nombreVisual, color, data, value
	["Antonio", _blanco, "antonio", 100],
	["Pepe", _verde, "pepe", 5000],
	["Manolo", _blanco, "manolo", 200]
];


for "_idx" from 0 to (count _arrayInfo) -1 do {
	
	_lista lbAdd (_arrayInfo select _idx select 0); // saco el nombreVisual
	_lista lbSetColor [_idx, _arrayInfo select _idx select 1]; // saco el color
	_lista lbSetData [_idx, _arrayInfo select _idx select 2]; // saco el data, sólo permite STRING
	_lista lbSetValue [_idx, _arrayInfo select _idx select 3]; // saco el value, sólo permite SCALAR
};


// Ejecutamos y veremos que la lista empieza con 4 elementos, con los colores que le hemos dicho
// ¿qué es eso de value y data?
// A cada elemento se los podemos asignar para después extraerlos, para ello vamos a usar un EH (EventHandler)
// Todos los EH de UI están aquí --> https://community.bistudio.com/wiki/User_Interface_Event_Handlers

// Pero aquí vamos a usar LBSelChanged, que saltará cuando la selección de la lista cambie.

// Como no puedo poner comentarios dentro del EH, porque el código que acepta va en STRING,
// Os lo leéis y luego miráis la explicación

_lista ctrlAddEventHandler ["LBSelChanged",'
	_ui = uiNamespace getVariable "miPrimerDialog";
	_lista = _ui displayCtrl 3000;
	_boton = _ui displayCtrl 3001;
	_txt = _ui displayCtrl 3003;	
	
	_idxLista = lbCurSel _lista;
	_data = _lista lbData _idxLista;
	_value = _lista lbValue _idxLista;
	
	_txt ctrlSetText format ["%1 tiene valor %2", _data, _value];
	
	_boton ctrlEnable (_value > 0);
'];


// Primero declaro todos los controles que voy a usar
// lbCurSel sirve para que me diga el índice que tengo seleccionado de la lista (si tengo seleccionado el segundo elemento, lbCurSel me dará 1)
// lbData y lbValue extraen la información del índice que les diga (es decir, del seleccionado)

//  Hago que _txt me muestre los valores

// Y si el valor de lo seleccionado actualmente es > 0, el botón se activa, si es menor se desactiva.
// ¿Porqué lo pongo así?
// Porque no me apetecía poner esto:

if (_value < 0) then {
	_boton ctrlEnable false;
} else {
	_boton ctrlEnable true;
};

// ni esto:

_activado = if (_value < 0) then {false} else {true};
_boton ctrlEnable _activado;

// Bueno el EH lo ponemos justo después de declarar nuestros controles.
// Probamos y contemplamos nuestra creación.






// Seguimos contemplando...





// Un poco más...






// Vale ya está, ahora vamos a seguir aprendiendo, pero sin tener que estar yo diciendo cada paso.
// Vamos a crear un pequeño indicador de fatiga.
// Un dialog nos impide movernos, porque lo tenemos delante y sólo podemos interactuar con él
// pero para eso están los RscTitles.

// El inventario del ArmA es dialog.
// El contador de munición es RscTitle.

// Creamos el dialog con el GUI Editor igual que siempre, pero tenemos incluír así en description:

class RscTitles {
	#include "dialogs\fatiga.hpp"
};

// NO podemos tenerlo como dialog y como RscTitle a la vez. O uno u otro.

// En el .hpp tenemos que añadir esto:
// Si no lo hacéis, os lo pedirá.

duration = 9e+012;

// 9 * 10 ^32 = 9000000000000
// Es decir, dura infinito.
// También podríamos añadir:

fadeIn = 2;
fadeOut = 2;

// Es bastante obvio qué hacen.

// En lugar de createDialog, se invocaría con:

("CapaFatiga" call BIS_fnc_rscLayer) cutRsc ["fatiga","PLAIN", 1, false];

// ¿Qué hace cada cosa? ---> https://community.bistudio.com/wiki/cutRsc
// Estamos usando el alternative syntax 2.

// Declararíamos los controles como siempre lo hemos hecho y ya está.
// Si quisiéramos cerrar el RscTitle con:
	closeDialog 0;
// no funcionaría, habría que usar:

("CapaFatiga" call BIS_fnc_rscLayer) cutText ["","PLAIN"];

// Básicamente estamos sobreescribiendo esa capa con un texto vacío, pero es así como se hace xD

// Ahora tenéis todo lo necesario para hacer lo que pido:
/*
- Un indicador en un ladito de la pantalla que muestre la fatiga.
- Puede ser numérico, si se os ocurre otra forma, go.
- Si tiene colorines según el cansancio, mejor.
- No os voy a recordar cómo se saca la fatiga.
*/

