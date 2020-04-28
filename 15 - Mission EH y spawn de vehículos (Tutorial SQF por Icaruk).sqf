
// Os ped�:



// Nada, as� que sigamos xD

// Creaci�n de veh�culos:

// Para ArmA, player es un veh�culo,
// comprobamos en monitor:

vehicle player

// te dir� que est�s subido en un veh�culo... que eres t� mismo xD
// si te subes en un veh�culo (uno de ruedas y tal) saldr� que vehicle player es ese veh�culo
// as� que ya sabemos comprobar si estamos subidos en veh�culo o no:

vehicle player == player

// Vamos a comprobarlo, creando primero un veh�culo:

// className createVehicle posici�n
"B_Quadbike_01_F" createVehicle (getPos player);

// �C�mo sacamos la classname?
// O bien la miramos en el editor, o con typeOf objeto

typeOf player;
typeOf vehicle player;
typeOf cursorTarget;

// Nos subimos y comprobamos todo de antes

// Ahora vamos a a�adir en fn_funcion5.sqf lo siguiente:


while {true} do {

	"O_Soldier_A_F" createVehicle [2012.39,2773.58,0.00038147]; // creo a un enemigo al final de la cuesta
	
	sleep 8;
};

// Ejecutamos y probamos.

// Ehhhh �no reaccionan!
// �Os acord�is de que nuestra "alma" estaba en un veh�culo, que era nuestro soldado?
// Pues con createVehicle s�lo creamos veh�culos, faltan almas.

// Primero, antes de entrar en el while crearemos un grupo EAST (rojos):

_grupoRojo = createGroup EAST;

// Despu�s crearemos soldados con alma y los meteremos a ese grupo

"O_Soldier_A_F" createUnit [[2012.39,2773.58,0.00038147], _grupoRojo];

// Hacemos los cambios necesarios en funcion5 y probamos a matar unos cuantos.

// La IA est� chet�sima, te mata de un disparo en la cabeza nada m�s verte, as� que vamos a calmarles un poco...

_unit = "O_Soldier_A_F" createUnit [[2012.39,2773.58,0.00038147], _grupoRojo];
_unit setSkill 0.2;

// Reiniciamos y probamos.

// Aaaargg qu� putada, con createVehicle s� que podemos hacer esto:

_cosa = "classname" createVehicle [0,0,0];

// Pero con createUnit no, tenemos que buscar la forma de poder asignarle una variable...

"O_Soldier_A_F" createUnit [[2012.39,2773.58,0.00038147], _grupoRojo, "unidad = this", 0.2];

// �C�mo s� eso? Porque miro la wiki y s� lo que es cada campo:

/*
className 		// STRING
	createUnit
posici�n 		// ARRAY
grupo 			// GROUP
init 			// STRING, aqu� ponemos c�digo en string que se ejecutar� al crearse la unidad, es como el init.sqf pero de la unidad.
skill 			// SCALAR, con esto nos ahorramos lo de setSkill
rango 			// STRING, esto nos la pela basto
*/

// Entonces funcion5 se me quedar�a as�:


_grupoRojo = createGroup EAST;

while {true} do {

	"O_Soldier_A_F" createUnit [[2012.39,2773.58,0.00038147], _grupoRojo, "unidad = this", 0.2];

	sleep 8;
};

// Ahora que tenemos una referencia a la unidad reci�n creada, podremos hacerle cosas.
// Ojo porque a los 8 segundos la siguiente unidad que se cree pasar� a ser "unidad" y perderemos la referencia de la anterior.

// Vamos a meterle un EH de "Killed"
// https://community.bistudio.com/wiki/Arma_3:_Event_Handlers

// Buscamos ese EH y miramos qu� devuelve:

_this select 0 // ser�a qui�n tiene el EH
_this select 1 // ser�a qu�en le ha matado

// entonces a�adimos esto justo despu�s de crear la unidad, y probamos a matarle.
// Yo me he puesto player allowDamage false para que no me maten xD

unidad addEventHandler ["Killed", "
	hint format ['%1 ha matado a %2', name (_this select 1), _this select 0];
"];

// Probamos y cada vez que matemos a alguien saldr� un hint.
// Ahora vamos a hacer que se muevan hacia nuestra posici�n:

unidad doMove (getPos player);

// Reiniciamos, ejecutamos y probamos.
// Esto tiene un "problema", una vez que la unidad se cree, pillar� mi posici�n e ir� hacia all�, si me muevo
// de esa posici�n, la unidad seguir� llendo a la misma posici�n.
// La soluci�n ser�a crear un "cerebro" para cada unidad spawneada que le diga cont�nuamente d�nde est� su objetivo.
// De normal, se crea un grupo y se le asigna un l�der, el resto de unidades del grupo hacen caso del l�der, as�
// s�lo har�a falta 1 cerebro.

// M�s info --> https://community.bistudio.com/wiki/Category:Command_Group:_Unit_Control


// Bueno, con todo lo que hemos aprendido a lo largo de 15 cap�tulos os voy a pedir el GRAN PROYECTO.
// Va a ser bastante libre, pero mínimo tiene que tener los siguientes puntos:

/*
- Singleplayer (1 jugador)
- Que trate de aguantar oleadas de enemigos
- Que haya un indicador (RscTitle) de cu�ntos enemigos quedan de esta oleada, y cu�ntas oleadas quedan para terminar.
- Que tengas 5 vidas (por ejemplo). Info sobre respawn --> https://community.bistudio.com/wiki/Description.ext#respawn
- Que empiece con un movimiento de c�mara to guapo.
- Que al empezar te salga un men� donde puedas elegir entre varias posiciones a defender (opcional).
- Que mole mucho.
*/

// Esto conforme me vay�is enviando las misiones, las ir� corrigiendo, si es posible, por TS. 
// Para ahorrar tiempo y tal xD
// Pod�is preguntarme cosillas por el foro, y por TS si s�n cosas muy gordas.
// Ale, �suerte!



