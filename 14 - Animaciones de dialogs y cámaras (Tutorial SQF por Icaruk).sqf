
// Os ped�:

// Ahora ten�is todo lo necesario para hacer lo que pido:
/*
- Un indicador en un ladito de la pantalla que muestre la fatiga.
- Puede ser num�rico, si se os ocurre otra forma, go.
- Si tiene colorines seg�n el cansancio, mejor.
- No os voy a recordar c�mo se saca la fatiga.
*/



// Resultado:
// https://i.gyazo.com/dd7aa0f8efab1c87cecf0111591ae55f.gif

// S�, he aprovechado el control de txt del dialog anterior, no me apetec�a abrir el GUI Editor XD

// fatiga.hpp

class fatiga
{
	idd = -1; // ID del display
	duration = 1e+011
	onLoad = "uiNamespace setVariable ['fatiga', _this select 0];"; // esto se lanza al cargar
	onUnLoad = "uiNamespace setVariable ['fatiga', nil]; "; // esto se lanza al descargar
	
	class controls { // contenido del dialog
		class txt: RscText
		{
			idc = 3010;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			text = ""; //--- ToDo: Localize;
			x = 0.331906 * safezoneW + safezoneX;
			y = 0.7948 * safezoneH + safezoneY;
			w = 0.238219 * safezoneW;
			h = 0.0418 * safezoneH;
		};
	};
};



// fn_funcion3.sqf

("CapaFatiga" call BIS_fnc_rscLayer) cutRsc ["fatiga","PLAIN", 1, false];

disableSerialization;
_ui = uiNamespace getVariable "fatiga";
_txt = _ui displayCtrl 3010;

_staminaInicial = getStamina player;


while {true} do {
	_txt ctrlSetText str round (((getStamina player) / _staminaInicial) * 100);
	
	sleep 0.5;
};



// �Y ya est�! F�cil, si veis que getStamina es nuevo para vosotros (s� que lo es xD) lo busc�is en la wiki
// lo pusieron nuevo en un parche relativamente reciente.


// Ahora vamos a ver c�mo animar este mismo texto
// con ctrlSetPosition podremos mover la posici�n de ese texto.
 
// As� que en el loop vamos a a�adir la siguiente l�nea:

_txt ctrlSetPosition [(ctrlPosition _txt select 0) + 0.03, ctrlPosition _txt select 1, ctrlPosition _txt select 2, ctrlPosition _txt select 3];

// ctrlPosition devuelve [x,y,w,h] del control.
// Nosotros sumamos 0.01 a la posici�n X

// Oh, no ocurre nada. Muchos comandos que afectan a los dialogs necesitan

_txt ctrlCommit 0;

// Para "cometer" los cambios, as� que a�adimos esa l�nea justo debajo.
// Ahora s� que se mueve, pero queda un poco feo...
// Probemos con...

_txt ctrlCommit 0.5;

// Ahora sabemos que ese numerito es el tiempo que tarda en ejecutar los cambios.

// De esto no voy a explicar nada m�s, porque una vez sabes hacer esto, es repetirlo pero con distintos par�metros:
// Por ejemplo, lo pod�is probar con ctrlSetFade.

// Cada vez condenso m�s los tutoriales, as� que os cuelo por aqu� las animaciones de las c�maras:
// fn_funcion4.sqf

_objetivo = player;

titleText ["", "BLACK OUT", 0.5]; // para que no se vean "teleports" de c�mara
sleep 0.6;
titleText ["", "BLACK IN", 1.6];

_posIni = _objetivo modelToWorld [0, 20, 6]; // esto pillar�a la posici�n que est� 20 metros delante de _objetivo y a 6m de altura.
_posFin = _objetivo modelToWorld [0, 2, 1.7];

camTutorial = "camera" camCreate _posIni; // creo la c�mara

showCinemaBorder false; // quito los bordes feos
camTutorial cameraEffect ["INTERNAL", "BACK"];// me meto en la c�mara

_miroPrimero = _objetivo modelToWorld [-40, 100, 20]; // posici�n a la que mirar� primero
camTutorial camSetTarget _miroPrimero;
camTutorial camCommit 2;

camTutorial camSetTarget _objetivo;	 // apunto al objetivo
camTutorial camSetPos _posFin; // voy al objetivo
camTutorial camCommit 8; // hago las dos l�neas de arriba en el tiempo que marco


// Las posiciones se podr�an pillar directamente por coordenadas manualmente, pero as� tambi�n sab�is c�mo se obtienen
// las posiciones relativas a objetos.

// �Os pido que me hag�is una animaci�n de c�mara guay?
// Del palo... dando vueltas a vuestro soldado.
// De esto no har� soluci�n, porque es lo que ya hab�is visto pero con distintos par�metros.
// A parte mucha gente no lo podr� grabar, as� que no lo podr� ver :(

// Para el siguiente cap�tulo veremos los mission eventHandlers y el spawn de veh�culos.






