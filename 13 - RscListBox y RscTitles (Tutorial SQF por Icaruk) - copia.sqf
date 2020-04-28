
// Os ped�:

// �Deberes!

// Quiero que en este men�, a parte de que el color de _txt cambie
// Cada elemento de la lista, dependiendo de su posici�n, tenga un color. Es decir:
// Los 3 primeros elementos tienen que ser blancos
// Los 3 siguientes naranjas
// Los 3 �ltimos rojos

// Investigar un poco en la wiki, que es s�lo un comando, si quer�is hacer algo m�s con el men�, sois libres, obviamente.


// Posible soluci�n:
// fn_funcion2.sqf:


disableSerialization;
_ui = uiNamespace getVariable "miPrimerDialog";

_lista = _ui displayCtrl 3000;
_boton = _ui displayCtrl 3001;
_edit = _ui displayCtrl 3002;
_txt = _ui displayCtrl 3003;

_nElementosAntes = lbSize _lista; // antes de a�adir el elemento

_textoDelEdit = ctrlText _edit;
hint _textoDelEdit;

_colorLista = switch (true) do { // �porqu� lo hago as�? porque el switch devuelve el el {} del caso que sea true, as� que aprovecho diciendo que una variable equivale a lo que devuelve al switch.
	case (_nElementosAntes > 9): {[1, 1, 1, 1]}; // blanco
	case (_nElementosAntes >= 6): {[1, 0, 0, 1]}; // rojo
	case (_nElementosAntes >= 3): {[1, 0.5, 0, 1]}; // naranja
	
	default {[1, 1, 1, 1]} // blanco por defecto
};

// �Porqu� empiezo del m�s alto al m�s bajo?
// Porque el switch en cuanto encuentre algo true, saldr� y no seguir� leyendo, entonces si hubiesen 4 elementos:
// 4 > 3 �es true? s�, pues pongo color naranja y me salgo
// Por eso empiezo desde el m�s alto xD

_lista lbAdd _textoDelEdit;
_lista lbSetColor [_nElementos, _colorLista];

_nElementosDespues = lbSize _lista; // despu�s de a�adir el elemento

_txt ctrlSetText (format ["Cantidad de elementos: %1", _nElementosDespues]);



_color = [0, 0, 0, 0]; // este es el color default que pusimos a _txt

if (_nElementosDespues >= 3) then {
	_color = [1, 0.5, 0, 1];

	if (_nElementosDespues >= 6) then {
		_color = [1, 0, 0, 1];
		
		if (_nElementosDespues > 9) then { // es decir, cuando tengamos 10 o m�s
			lbClear _lista; // limpiamos la lista
			_color = [0, 0, 0, 0];
			_txt ctrlSetText "Cantidad de elementos: 0";
		};
	};
};

_txt ctrlSetBackgroundColor _color;


// �Y ya est�!
// Pero por si acaso explicar� lbSetColor

/*
_lista lbSetColor [_nElementos, _colorLista];
_control lbSetColor [�ndice, color];

si en el �ndice pon�is siempre un 0, el primer elemento (se cuenta como en los arrays) ser� de ese color.
Pero lo que hacemos es usar de �ndice el n�mero de elementos que hay antes de a�adir el siguiente elemento.

Hay 0 elementos, lbSize es 0.
A�ado un elemento, y el �ndice 0 lo coloreo.

Hay 1 elemento, lbSize es 1.
A�ado un elemento, y el �ndice 1 lo coloreo.

...
*/


// Ahora a partir de un array vamos a crear una lista
// Esto ir�a en fn_funcion1

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
	_lista lbSetData [_idx, _arrayInfo select _idx select 2]; // saco el data, s�lo permite STRING
	_lista lbSetValue [_idx, _arrayInfo select _idx select 3]; // saco el value, s�lo permite SCALAR
};


// Ejecutamos y veremos que la lista empieza con 4 elementos, con los colores que le hemos dicho
// �qu� es eso de value y data?
// A cada elemento se los podemos asignar para despu�s extraerlos, para ello vamos a usar un EH (EventHandler)
// Todos los EH de UI est�n aqu� --> https://community.bistudio.com/wiki/User_Interface_Event_Handlers

// Pero aqu� vamos a usar LBSelChanged, que saltar� cuando la selecci�n de la lista cambie.

// Como no puedo poner comentarios dentro del EH, porque el c�digo que acepta va en STRING,
// Os lo le�is y luego mir�is la explicaci�n

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
// lbCurSel sirve para que me diga el �ndice que tengo seleccionado de la lista (si tengo seleccionado el segundo elemento, lbCurSel me dar� 1)
// lbData y lbValue extraen la informaci�n del �ndice que les diga (es decir, del seleccionado)

//  Hago que _txt me muestre los valores

// Y si el valor de lo seleccionado actualmente es > 0, el bot�n se activa, si es menor se desactiva.
// �Porqu� lo pongo as�?
// Porque no me apetec�a poner esto:

if (_value < 0) then {
	_boton ctrlEnable false;
} else {
	_boton ctrlEnable true;
};

// ni esto:

_activado = if (_value < 0) then {false} else {true};
_boton ctrlEnable _activado;

// Bueno el EH lo ponemos justo despu�s de declarar nuestros controles.
// Probamos y contemplamos nuestra creaci�n.






// Seguimos contemplando...





// Un poco m�s...






// Vale ya est�, ahora vamos a seguir aprendiendo, pero sin tener que estar yo diciendo cada paso.
// Vamos a crear un peque�o indicador de fatiga.
// Un dialog nos impide movernos, porque lo tenemos delante y s�lo podemos interactuar con �l
// pero para eso est�n los RscTitles.

// El inventario del ArmA es dialog.
// El contador de munici�n es RscTitle.

// Creamos el dialog con el GUI Editor igual que siempre, pero tenemos inclu�r as� en description:

class RscTitles {
	#include "dialogs\fatiga.hpp"
};

// NO podemos tenerlo como dialog y como RscTitle a la vez. O uno u otro.

// En el .hpp tenemos que a�adir esto:
// Si no lo hac�is, os lo pedir�.

duration = 9e+012;

// 9 * 10 ^32 = 9000000000000
// Es decir, dura infinito.
// Tambi�n podr�amos a�adir:

fadeIn = 2;
fadeOut = 2;

// Es bastante obvio qu� hacen.

// En lugar de createDialog, se invocar�a con:

("CapaFatiga" call BIS_fnc_rscLayer) cutRsc ["fatiga","PLAIN", 1, false];

// �Qu� hace cada cosa? ---> https://community.bistudio.com/wiki/cutRsc
// Estamos usando el alternative syntax 2.

// Declarar�amos los controles como siempre lo hemos hecho y ya est�.
// Si quisi�ramos cerrar el RscTitle con:
	closeDialog 0;
// no funcionar�a, habr�a que usar:

("CapaFatiga" call BIS_fnc_rscLayer) cutText ["","PLAIN"];

// B�sicamente estamos sobreescribiendo esa capa con un texto vac�o, pero es as� como se hace xD

// Ahora ten�is todo lo necesario para hacer lo que pido:
/*
- Un indicador en un ladito de la pantalla que muestre la fatiga.
- Puede ser num�rico, si se os ocurre otra forma, go.
- Si tiene colorines seg�n el cansancio, mejor.
- No os voy a recordar c�mo se saca la fatiga.
*/

