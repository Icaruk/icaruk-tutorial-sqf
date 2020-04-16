
// os pedí:

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


// esta vez no voy a dar solución, porque hay 999999999999999999999999999999999999999999999999999999999999999999999999999
// 9999999999999999999999999999999999999999999999999 soluciones posibles.

// Ahora vamos a hablar del multiplayer, es cuando tienes algo que mola un montón, lo metes a MP y no funciona nada.
// Primero vamos a aclarar un par de cosas:
// Si entras en el editor, eres servidor (porque tú has creado la sesión) y cliente (porque estás unido a la sesión)
// podéis comprobarlo con 

isServer
isDedicated
hasInterface

// según eso: somos servidor, no somos servidor dedicado y tenemos interfaz.
// Entonces, las cosas en MP funcionan de la siguiente forma:

// Soy cliente, creo un vehículo con createVehicle, y aparece delante de mí.
// El servidor se encarga de decirle al resto de clientes "Eh, ahí hay un vehículo de tal tipo", y cada vez que se mueva, 
// a cada frame, le va a estar enviando la información a todos los clientes para que lo vean todo sincronizado.
// Por eso cuando hay desync los vehículos dan tirones y se teletransportan, porque el servidor te envía la información
// pero no suficiente para tener sensación de movimiento normal.

// Si yo ahora como cliente:

var = 123;

// El servidor no tiene ni idea de qué es var
// de la misma forma que si el servidor hace:

varserv = 456;

// el cliente no sabría ni que existe esa variable.

/*
nuevo comando: publicVariable
	publicVariable "var";
	convierte la variable en pública

puntosEquipoA = 150;
publicVariable "puntosEquipoA";
*/

// Si yo como cliente hago:

var = 123; publicVariable "var";

// El servidor, y todos los clientes sabrían que var es 123.
// Si algún cliente entra después de que se haya hecho la variable pública, el servidor le enviará el valor de var
// al entrar.

// Pero si como cliente cambio la variable...

var = 789;

// ...pero sin publicarla, el servidor y el resto de clientes, seguirán pensando que var vale 123.
// hay una variante de publicVariable que es publicVariableServer, dudo que sea necesario explicar qué hace.

// Pero por si acaso, un cliente hace:

var = "hola";
publicVariableServer "var";

// El cliente que tenía var le dice al server cuánto vale la variable, sólo al servidor, susurrado con amor.
// Esto es útil para no tener un flujo inmenso de datos en partidas con muchos jugadores
// ¿qué coño le importa a los 119 clientes que has comprado 3 plátanos y que se restan del stock?
// ya cuando vayan ellos a la tienda, que el servidor les informe del stock
// Menos variables públicas = menor flujo de datos = menos desync = mejor rendimiento

// Si en nuestro proyecto creamos init.sqf con este contenido:

hint "Bienvenido";

// Cada vez que entremos a la misión, veremos ese hint, porque todo el mundo pasa por el init al cargar la misión
// y todos cargan la misión, incluído el server o dedicado.

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

// Guardamos la misión tal que así: https://i.gyazo.com/df7d6b619935b29ce3c39e4966b8af22.png
// Se debería de haber guardado aquí https://i.gyazo.com/f301f122dd3a47101a277bed66b5abab.png
// Que sería más o menos esta ruta:
//	C:\Program Files (x86)\Steam\steamapps\common\Arma 3\MPMissions

// Colocamos el archivo TADST.exe en la carpeta donde tengáis instalado Arma, al lado de arma3.exe y demás ejecutables.

// Ejecutamos TADST.exe 
// Rellenamos server name, password y admin password.
// Abajo del todo, pondrá server file: buscáis arma3server.exe en vuestra carpeta de Arma.
// En la pestaña missions, elegís TutorialMolon.stratis
// Todo listo, click en LAUNCH
// Parece que se abre el arma de normal, pero no, os aparecerá una consola con la información del servidor y de quién entra.
// Eso es un servidor dedicado, no tiene interfaz.
// Ahora vais a entrar en vosotros mismos: ejecutáis arma como de normal, play >> multiplayer >> LAN
// Seguramente tendréis que iniciar sin battleye, ya que no se pueden tener dos instances del mismo ejecutándose
// Aparecerá el nombre de vuestro server, y entráis xD
// ¡ESC y no tenéis consola! :O
// Escribís en el chat: #login pass 
// (donde pone pass tenéis que poner la pass que pusisteis en "admin password" xD

// Ahora ya tenéis consola, comprobad estas cosas:

isServer
isDedicated
hasInterface
varServer
varServer2
varClient
varClient2

// varServer2 no existe para vosotros, sólo la tiene el servidor
// ¿Cómo le pregunto al servidor si tiene X variable?
// Ejecutáis en GLOBAL:

if (isServer) then {
	if (!isNil {varServer2}) then {
		valor = varServer2;
		publicVariable "valor";
	};
};

// Hemos hecho que todo el mundo, clientes y servidor ejecuten el código que hemos puesto ahí,
// ahora comprobáis si valor vale algo, debería valer "parami"
// Os borráis la variable con valor = nil y probamos otra cosa.
// Ejecutáis en SERVER:
	
if (!isNil {varServer2}) then {
	valor = varServer2;
	publicVariable "valor";
};

// esto sería lo mismo que hemos hecho antes, pero sólo lo ejecuta el servidor, 
// tú, cliente, que le has dado el botón, no ejecutarás el código.
// Una forma cutre de ejecutar código en cierto jugador:

// En GLOBAL:
if (name player == "Icaruk") then {
	hint "Hola, este hint sólo lo ves tú";
};

// Todo el mundo ejecutaría el if, pero al no cumplir las condiciones dejarían de seguir leyendo.

// Aún queda muuuuuucho por saber de MP, pero ya son cosas más complicadas o cosas que no sé xD
// No os iba a pedir nada, pero se me ha ocurrido lo siguiente:

/*
La tienda que teníais para comprar plátanos y movidas, la tenéis que pasar a MP. Es decir:

- El stock tiene que ser el mismo para todo el mundo
- El stock iría con publicVariable, no os comáis la cabeza con publicVariableServer y publicVariableClient

Cada vez que tengáis que testear, tenéis que guardar la misión como hemos hecho antes: "export to multiplayer missions".
Mirad bien que no esté en uso porque no se podrá sobreescribir, es decir: tenéis que cerrar el dedicado, para que deje de
usar la misión y poder sobreescribirla.
Aun así os recomiendo poner un hint en el init.sqf que diga "v0.1" y la váis subiendo para saber 100% que estáis usando
la misión que deberíais.

Aaaanda que no me he comido la cabeza con eso, pensando que había fixeado una cosa y estaba usando una antigua...
*/

// Por cierto, para hacerlo más fácil..

/*
nuevo comando: addAction
	es local, sólo tendrá la acción quien lo ejecute
	
	objeto addAction accion;

ejemplo:
*/

tioVendedor addAction [
	"¿Qué tienes a la venta?", // el texto de la acción
	'[argumentos] execVM "tienda.sqf"; ', // código a ejecutar, fijaros en cómo uso las comillas, probad a usarlas de otras formas.
	"", // argumentos que pasarán al script, se pueden poner arriba o aquí (yo siempre los pongo arriba y esto lo dejo en blanco)
	9, // prioridad, el 9 estará más arriba que el 8, el 9999 estará arriba del 9 xD
	false, // ¿quieres texto en medio de la pantalla cuando puedas elegir la acción?
	true, // ¿quieres esconder las acciones cuando uses una? (útil para hacer más difícil spamear una acción)
	"", // nizorra, algo de bindear la acción a una tecla, pero es tontería.
	"" // condición, por ejemplo: "(side player == WEST) AND ((player distance tioVendedor) < 3)". Ojo, se comprueba a cada frame, cuando estás a 10 metros o menos.
];

// Aquí podéis ver addAction más extensamente https://community.bistudio.com/wiki/addAction
// No es necesario poner todos los parámetros, los parámetros que omitáis usarán sus valores por defecto, que podéis ver
// en el link que os he puesto.
// Así que para algo sencillo, con esto sería suficiente:

tioVendedor addAction ["¿Qué tienes a la venta?", '[argumentos] execVM "tienda.sqf"; '];

// Si en el editor creas una unidad llamada tioVendedor, y tú ejecutas la línea de arriba, se le pondrá una acción.
// Si en el editor, en la unidad llamada tioVendedor le quieres poner la acción en su init:

this addAction ["¿Qué tienes a la venta?", '[argumentos] execVM "tienda.sqf"; '];

// Así cualquiera que entre tendrá la acción sobre ese tío.


