
// os ped�:

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


// esta vez no voy a dar soluci�n, porque hay 999999999999999999999999999999999999999999999999999999999999999999999999999
// 9999999999999999999999999999999999999999999999999 soluciones posibles.

// Ahora vamos a hablar del multiplayer, es cuando tienes algo que mola un mont�n, lo metes a MP y no funciona nada.
// Primero vamos a aclarar un par de cosas:
// Si entras en el editor, eres servidor (porque t� has creado la sesi�n) y cliente (porque est�s unido a la sesi�n)
// pod�is comprobarlo con 

isServer
isDedicated
hasInterface

// seg�n eso: somos servidor, no somos servidor dedicado y tenemos interfaz.
// Entonces, las cosas en MP funcionan de la siguiente forma:

// Soy cliente, creo un veh�culo con createVehicle, y aparece delante de m�.
// El servidor se encarga de decirle al resto de clientes "Eh, ah� hay un veh�culo de tal tipo", y cada vez que se mueva, 
// a cada frame, le va a estar enviando la informaci�n a todos los clientes para que lo vean todo sincronizado.
// Por eso cuando hay desync los veh�culos dan tirones y se teletransportan, porque el servidor te env�a la informaci�n
// pero no suficiente para tener sensaci�n de movimiento normal.

// Si yo ahora como cliente:

var = 123;

// El servidor no tiene ni idea de qu� es var
// de la misma forma que si el servidor hace:

varserv = 456;

// el cliente no sabr�a ni que existe esa variable.

/*
nuevo comando: publicVariable
	publicVariable "var";
	convierte la variable en p�blica

puntosEquipoA = 150;
publicVariable "puntosEquipoA";
*/

// Si yo como cliente hago:

var = 123; publicVariable "var";

// El servidor, y todos los clientes sabr�an que var es 123.
// Si alg�n cliente entra despu�s de que se haya hecho la variable p�blica, el servidor le enviar� el valor de var
// al entrar.

// Pero si como cliente cambio la variable...

var = 789;

// ...pero sin publicarla, el servidor y el resto de clientes, seguir�n pensando que var vale 123.
// hay una variante de publicVariable que es publicVariableServer, dudo que sea necesario explicar qu� hace.

// Pero por si acaso, un cliente hace:

var = "hola";
publicVariableServer "var";

// El cliente que ten�a var le dice al server cu�nto vale la variable, s�lo al servidor, susurrado con amor.
// Esto es �til para no tener un flujo inmenso de datos en partidas con muchos jugadores
// �qu� co�o le importa a los 119 clientes que has comprado 3 pl�tanos y que se restan del stock?
// ya cuando vayan ellos a la tienda, que el servidor les informe del stock
// Menos variables p�blicas = menor flujo de datos = menos desync = mejor rendimiento

// Si en nuestro proyecto creamos init.sqf con este contenido:

hint "Bienvenido";

// Cada vez que entremos a la misi�n, veremos ese hint, porque todo el mundo pasa por el init al cargar la misi�n
// y todos cargan la misi�n, inclu�do el server o dedicado.

// Ahora ponemos:

if (isServer) then {
	varServer = "paratodos";
	publicVariable "varServer";
	varServer2 = "parami";
} else {
	varClient = 123;
	varClient2 = 456;
	publicVariableServer "varClient2";
};

// Guardamos la misi�n tal que as�: https://i.gyazo.com/df7d6b619935b29ce3c39e4966b8af22.png
// Se deber�a de haber guardado aqu� https://i.gyazo.com/f301f122dd3a47101a277bed66b5abab.png
// Que ser�a m�s o menos esta ruta:
//	C:\Program Files (x86)\Steam\steamapps\common\Arma 3\MPMissions

// Colocamos el archivo TADST.exe en la carpeta donde teng�is instalado Arma, al lado de arma3.exe y dem�s ejecutables.

// Ejecutamos TADST.exe 
// Rellenamos server name, password y admin password.
// Abajo del todo, pondr� server file: busc�is arma3server.exe en vuestra carpeta de Arma.
// En la pesta�a missions, eleg�s TutorialMolon.stratis
// Todo listo, click en LAUNCH
// Parece que se abre el arma de normal, pero no, os aparecer� una consola con la informaci�n del servidor y de qui�n entra.
// Eso es un servidor dedicado, no tiene interfaz.
// Ahora vais a entrar en vosotros mismos: ejecut�is arma como de normal, play >> multiplayer >> LAN
// Seguramente tendr�is que iniciar sin battleye, ya que no se pueden tener dos instances del mismo ejecut�ndose
// Aparecer� el nombre de vuestro server, y entr�is xD
// �ESC y no ten�is consola! :O
// Escrib�s en el chat: #login pass 
// (donde pone pass ten�is que poner la pass que pusisteis en "admin password" xD

// Ahora ya ten�is consola, comprobad estas cosas:

isServer
isDedicated
hasInterface
varServer
varServer2
varClient
varClient2

// varServer2 no existe para vosotros, s�lo la tiene el servidor
// �C�mo le pregunto al servidor si tiene X variable?
// Ejecut�is en GLOBAL:

if (isServer) then {
	if (!isNil {varServer2}) then {
		valor = varServer2;
		publicVariable "valor";
	};
};

// Hemos hecho que todo el mundo, clientes y servidor ejecuten el c�digo que hemos puesto ah�,
// ahora comprob�is si valor vale algo, deber�a valer "parami"
// Os borr�is la variable con valor = nil y probamos otra cosa.
// Ejecut�is en SERVER:
	
if (!isNil {varServer2}) then {
	valor = varServer2;
	publicVariable "valor";
};

// esto ser�a lo mismo que hemos hecho antes, pero s�lo lo ejecuta el servidor, 
// t�, cliente, que le has dado el bot�n, no ejecutar�s el c�digo.
// Una forma cutre de ejecutar c�digo en cierto jugador:

// En GLOBAL:
if (name player == "Icaruk") then {
	hint "Hola, este hint s�lo lo ves t�";
};

// Todo el mundo ejecutar�a el if, pero al no cumplir las condiciones dejar�an de seguir leyendo.

// A�n queda muuuuuucho por saber de MP, pero ya son cosas m�s complicadas o cosas que no s� xD
// No os iba a pedir nada, pero se me ha ocurrido lo siguiente:

/*
La tienda que ten�ais para comprar pl�tanos y movidas, la ten�is que pasar a MP. Es decir:

- El stock tiene que ser el mismo para todo el mundo
- El stock ir�a con publicVariable, no os com�is la cabeza con publicVariableServer y publicVariableClient

Cada vez que teng�is que testear, ten�is que guardar la misi�n como hemos hecho antes: "export to multiplayer missions".
Mirad bien que no est� en uso porque no se podr� sobreescribir, es decir: ten�is que cerrar el dedicado, para que deje de
usar la misi�n y poder sobreescribirla.
Aun as� os recomiendo poner un hint en el init.sqf que diga "v0.1" y la v�is subiendo para saber 100% que est�is usando
la misi�n que deber�ais.

Aaaanda que no me he comido la cabeza con eso, pensando que hab�a fixeado una cosa y estaba usando una antigua...
*/

// Por cierto, para hacerlo m�s f�cil..

/*
nuevo comando: addAction
	es local, s�lo tendr� la acci�n quien lo ejecute
	
	objeto addAction accion;

ejemplo:
*/

tioVendedor addAction [
	"�Qu� tienes a la venta?", // el texto de la acci�n
	'[argumentos] execVM "tienda.sqf"; ', // c�digo a ejecutar, fijaros en c�mo uso las comillas, probad a usarlas de otras formas.
	"", // argumentos que pasar�n al script, se pueden poner arriba o aqu� (yo siempre los pongo arriba y esto lo dejo en blanco)
	9, // prioridad, el 9 estar� m�s arriba que el 8, el 9999 estar� arriba del 9 xD
	false, // �quieres texto en medio de la pantalla cuando puedas elegir la acci�n?
	true, // �quieres esconder las acciones cuando uses una? (�til para hacer m�s dif�cil spamear una acci�n)
	"", // nizorra, algo de bindear la acci�n a una tecla, pero es tonter�a.
	"" // condici�n, por ejemplo: "(side player == WEST) AND ((player distance tioVendedor) < 3)". Ojo, se comprueba a cada frame, cuando est�s a 10 metros o menos.
];

// Aqu� pod�is ver addAction m�s extensamente https://community.bistudio.com/wiki/addAction
// No es necesario poner todos los par�metros, los par�metros que omit�is usar�n sus valores por defecto, que pod�is ver
// en el link que os he puesto.
// As� que para algo sencillo, con esto ser�a suficiente:

tioVendedor addAction ["�Qu� tienes a la venta?", '[argumentos] execVM "tienda.sqf"; '];

// Si en el editor creas una unidad llamada tioVendedor, y t� ejecutas la l�nea de arriba, se le pondr� una acci�n.
// Si en el editor, en la unidad llamada tioVendedor le quieres poner la acci�n en su init:

this addAction ["�Qu� tienes a la venta?", '[argumentos] execVM "tienda.sqf"; '];

// As� cualquiera que entre tendr� la acci�n sobre ese t�o.


