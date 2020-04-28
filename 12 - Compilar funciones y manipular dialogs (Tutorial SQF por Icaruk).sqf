
// Os pedí:

// Ahora los deberes:

// Quiero un menú jodidamente bonito que tenga:

/*
- Un botón
- Un cuadro para meter texto
- Una lista
- Un texto
- Un fondo
*/

// Haced el menú pensando en que el botón añadirá el texto editable en la lista,
// y el texto mostrará el count de los elementos de la lista.
// Más o menos.


// Yo hice esto:

// GUI Editor
https://i.gyazo.com/a61816d17d3337c29ac7ab9dc82e8008.png

$[1.063,["asd",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],[2200,"fondo",[1,"",["0.326751 * safezoneW + safezoneX","0.2976 * safezoneH + safezoneY","0.248531 * safezoneW","0.5478 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[1500,"lista",[1,"",["0.329844 * safezoneW + safezoneX","0.3922 * safezoneH + safezoneY","0.242344 * safezoneW","0.396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[1600,"boton",[1,"CLICK",["0.329844 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.242344 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[1400,"edit",[1,"texto editable",["0.331906 * safezoneW + safezoneX","0.3042 * safezoneH + safezoneY","0.238219 * safezoneW","0.0374 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[1000,"txt",[1,"texto",["0.331906 * safezoneW + safezoneX","0.7948 * safezoneH + safezoneY","0.238219 * safezoneW","0.0418 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]]

// Dialog
https://i.gyazo.com/cdf5d2dd70f9eddf1d579d114a6e9596.png

// Posiblemente os haya saltado un error de que en la lista no encuentra el scrollBar, porque no la tenemos definida en defines.hpp
// nuestra lista no tendrá scroll, pero de momento nos la pela.
// El color del botón puede que lo tengáis diferente, yo tengo la configuración de colores cambiada.
// El texto queda muy feo porque tiene fondo blanco, vamos a quitarlo ahora enseguida...

// Esto es mi plantilla.hpp
class miPrimerDialog
{
	idd = -1; // ID del display
	onLoad = "uiNamespace setVariable ['miPrimerDialog', _this select 0];"; // esto se lanza al cargar
	onUnLoad = "uiNamespace setVariable ['miPrimerDialog', nil]; "; // esto se lanza al descargar
	
	class controls { // contenido del dialog
		
		class fondo: IGUIBack
		{
			idc = 2200;
			x = 0.326751 * safezoneW + safezoneX;
			y = 0.2976 * safezoneH + safezoneY;
			w = 0.248531 * safezoneW;
			h = 0.5478 * safezoneH;
		};
		class lista: RscListbox
		{
			idc = 1500;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.3922 * safezoneH + safezoneY;
			w = 0.242344 * safezoneW;
			h = 0.396 * safezoneH;
		};
		class boton: RscButton
		{
			idc = 1600;
			text = "CLICK"; //--- ToDo: Localize;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.242344 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class edit: RscEdit
		{
			idc = 1400;
			text = "texto editable"; //--- ToDo: Localize;
			x = 0.331906 * safezoneW + safezoneX;
			y = 0.3042 * safezoneH + safezoneY;
			w = 0.238219 * safezoneW;
			h = 0.0374 * safezoneH;
		};
		class txt: RscText
		{
			idc = 1000;
			text = "texto"; //--- ToDo: Localize;
			x = 0.331906 * safezoneW + safezoneX;
			y = 0.7948 * safezoneH + safezoneY;
			w = 0.238219 * safezoneW;
			h = 0.0418 * safezoneH;
		};
	};
};


// Primero vamos a asignar una ID a cada control que vayamos a utilizar, por ejemplo si el fondo ni le vas a cambiar el color
// ni lo vas a animar ni nada, pues le pones un idc = -1
// Yo pondría números empezando por 5000, para que no cree conflicto con los idc que ya tiene ArmA.
// Y también le vamos a quitar el fondo a nuestro RscText, sólo hay que añadirle esta línea:

colorBackground[] = {0,0,0,0};

// {R, G, B, A}
// red, green, blue, alpha (transparencia)
// Por si os interesa:

colorText[] = {}; // color del texto
sizeEx = 0.05; // tamaño del texto
// https://community.bistudio.com/wiki/Dialog_Control


// Entonces quedaría algo asi:

class miPrimerDialog
{
	idd = -1; // ID del display
	onLoad = "uiNamespace setVariable ['miPrimerDialog', _this select 0];"; // esto se lanza al cargar
	onUnLoad = "uiNamespace setVariable ['miPrimerDialog', nil]; "; // esto se lanza al descargar
	
	class controls { // contenido del dialog
		
		class fondo: IGUIBack
		{
			idc = -1;
			x = 0.326751 * safezoneW + safezoneX;
			y = 0.2976 * safezoneH + safezoneY;
			w = 0.248531 * safezoneW;
			h = 0.5478 * safezoneH;
		};
		class lista: RscListbox
		{
			idc = 3000;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.3922 * safezoneH + safezoneY;
			w = 0.242344 * safezoneW;
			h = 0.396 * safezoneH;
		};
		class boton: RscButton
		{
			idc = 3001;
			text = "CLICK"; //--- ToDo: Localize;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.242344 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class edit: RscEdit
		{
			idc = 3002;
			text = "texto editable"; //--- ToDo: Localize;
			x = 0.331906 * safezoneW + safezoneX;
			y = 0.3042 * safezoneH + safezoneY;
			w = 0.238219 * safezoneW;
			h = 0.0374 * safezoneH;
		};
		class txt: RscText
		{
			idc = 3003;
			colorBackground[] = {0,0,0,0};
			text = "texto"; //--- ToDo: Localize;
			x = 0.331906 * safezoneW + safezoneX;
			y = 0.7948 * safezoneH + safezoneY;
			w = 0.238219 * safezoneW;
			h = 0.0418 * safezoneH;
		};
	};
};


// Tened en cuenta que cada vez que cambiéis algo de un .hpp (estarías modificando description.ext, porque hacer el #include es
// como copiar y pegar) habría que recargar el proyecto de la misión para que los cambios tengan efecto.

// Ahora que el control de texto tiene el fondo transparente, vamos a aprender en un plis a compilar funciones:

/*
- No creamos fn_funcion1.sqf dentro de la carpeta funciones, porque ya os lo he hecho yo.
- No creamos fn_funcion2.sqf dentro de la carpeta funciones, porque ya os lo he hecho yo.
- Miramos funciones.h
	Sí, los archivos siempre se tendrán que llamar fn_nombreDeFuncion.sqf para que los reconozca ArmA al compilar.
- Miramos description.ext línea 24, vemos que incluímos nuestro funciones.h
- Entramos al juego y miramos si tut_fnc_funcion1 y 2 existen
	Es decir, ponemos tut_fnc_funcion1 en monitor y nos debería de devolver algo.
*/

// ¿Porqué hacer esto? Rendimiento: execVM compila su contenido y lo lanza, a cada vez que hagas execVM.
// Si hacemos call a una función, la función ya está compilada de antes y sólo la lanza.

call tut_fnc_funcion1
call tut_fnc_funcion2

// Nos debería de hacer un hint diciendo "Esto es la función X"

// Ahora que tenemos las funciones compiladas, para testear es un poco coñazo porque cada vez que modifiquemos algo de la función
// Tendremos que hacer ESC, reiniciar para que vuelva a recompilar.
// O podemos hacer execVM "funciones\fn_funcion1.sqf"

// Vamos a pegar dentro de fn_funcion1.sqf todo el texto de aquí abajo y lo leemos, después seguimos leyendo en la línea 240 de este archivo.



// ----------------------------------------------------- 
// De aquí...
// ----------------------------------------------------- 

createDialog "miPrimerDialog"; // aquí creamos el dialog, como ya hemos hecho antes

// ¿Y ahora qué?
// Pues si os acordáis en el onLoad de nuestro dialog había un
// uiNamespace setVariable ['miPrimerDialog', _this select 0]

// que básicamente quiere decir:
// enLaCajaDeVariablesUI pongoVariable ['miPrimerDialog', esto]
// pero ya lo miraremos más a fondo más adelante.

// ¿Cómo accedemos a esa variable?

disableSerialization; // necesario para que las variables locales soporten variables de tipo UI. Esto sólo se pone una vez al principio del script y ya está.
_ui = uiNamespace getVariable "miPrimerDialog"; // _ui ahora contiene nuestro dialog

// Entonces a partir de ahí, podremos acceder a todos los controles que tengan idc

_lista = _ui displayCtrl 3000;
_boton = _ui displayCtrl 3001;
_edit = _ui displayCtrl 3002;
_txt = _ui displayCtrl 3003;

// vuestros números pueden ser diferentes, pero tienen que coincidir. Es decir si mi botón tiene el 3001, aseguraros de que
// _boton = _ui displayCtrl 3001 y no otro número diferente.

_boton ctrlSetText "PULSAR"; 
_txt ctrlSetText "Hola"; // cambio el texto del control, si lo permite

_boton buttonSetAction 'hint "HOLA"'; // le pone una acción al botón, pero va en STRING
// Fijaros en los tipos de comillas
/*
Si quiero meter un string dentro de un string tengo que poner doble comilla:
	" hint "HOLA" " // esto estaría mal
	' hint 'HOLA' ' // esto estaría mal

	" hint ""HOLA"" " 	// bien
	' hint ''HOLA'' ' 	// bien

	' hint "HOLA" ' 	// bien, este es el que uso siempre
*/



// Reiniciamos y lanzamos, o hacemos execVM
// Pulsamos sobre el botón

// Nos sale un hint diciendo HOLA
// Volvemos al archivo principal del tutorial

	
// ----------------------------------------------------- 
// ... hasta aquí.
// ----------------------------------------------------- 










// Ya estás de vuelta, vamos hacer que el botón lance una función, así que modificamos (en fn_funcion1.sqf) la línea:

_boton buttonSetAction 'hint "HOLA"';

// por:

_boton buttonSetAction 'call tut_fnc_funcion2';

// Si no queremos estar reiniciando para ver los cambios:

_boton buttonSetAction 'execVM "funciones\fn_funcion2.sqf"'; 

// Acordaros que cuando ya esté testeado habrá que cambiarlo a call.

// Ahora el botón debería de lanzar la función 2.
// Modificamos fn_funcion2.sqf:

// Hacemos 
disableSerialization;

// como siempre, y definimos _ui (o como os guste llamarlo) y todos los controles que vayamos a usar
// quedaría algo así:

disableSerialization;
// No hace falta crear el dialog, ya lo tenemos delante, sólo queremos modificar cosas
_ui = uiNamespace getVariable "miPrimerDialog";

_lista = _ui displayCtrl 3000;
_boton = _ui displayCtrl 3001;
_edit = _ui displayCtrl 3002;
_txt = _ui displayCtrl 3003;

// Cada vez que se pulse el botón se definirá todo eso, y vamos a hacer que lo que esté escrito en RscEdit nos salga en hint:

_textoDelEdit = ctrlText _edit;
hint _textoDelEdit;

/*
ctrlSetText ---> pones texto
ctrlText ---> obtienes texto
*/

// Probáis y vamos al siguiente paso, un poco más complicado:
// Cada vez que pulsemos el botón, vamos a meter _textoDelEdit como un elemento en la lista
// así que añadimos esta línea

_lista lbAdd _textoDelEdit;

// Probáis, contempláis vuestra creación y seguimos:
// Ahora vamos a hacer que _txt muestre la cantidad de elementos que tiene la lista:

_txt ctrlSetText (format ["Cantidad de elementos: %1", lbSize _lista]);

// Probáis y vamos a hacer que cuando hayan >=3 elementos, el botón se ponga naranja
// Y cuando hayan >=6 elementos se ponga rojo
// Y cuando hayan > 9 se borre la lista y se ponga el color default
// Empezamos:

_nElementos = lbSize _lista;

_color = [0, 0, 0, 0]; // este el color default que pusimos a _txt

if (_nElementos >= 3) then {
	_color = [1, 0.5, 0, 1];

	if (_nElementos >= 6) then {
		_color = [1, 0.5, 0, 1];
		
		if (_nElementos > 9) then { // es decir, cuando tengamos 10 o más
			_color = [1, 0, 0, 1];
			lbClear _lista; // limpiamos la lista		
		};
	};
};

_txt ctrlSetBackgroundColor _color;


// Probamos y contemplamos nuestra creación.
// Como os habréis fijado ya no explico cada comando de forma tan detallada
// Espero que con que veáis un ejemplo ya sepáis su sintaxis y qué hace
// y si no es así... tenéis la wiki xD

// Por cierto, con 
closeDialog 0;
// cerráis el menú que tengáis delante en estos momentos



// ¡Deberes!

// Quiero que en este menú, a parte de que el color de _txt cambie
// Cada elemento de la lista, dependiendo de su posición, tenga un color. Es decir:
// Los 3 primeros elementos tienen que ser blancos
// Los 3 siguientes naranjas
// Los 3 últimos rojos

// Investigar un poco en la wiki, que es sólo un comando, si queréis hacer algo más con el menú, sois libres, obviamente.
