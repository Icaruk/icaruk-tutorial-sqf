
// Lo último que os dije fué lo siguiente:

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
	- La de pasar a de negativo a positivo, y si es positivo, que lo deje igual.
	- Una función que me une getPos y getMarkerPos en el mismo comando
	
¡Que vuele la imaginación... y google!
*/


// Lo de la función útil, pueden ser mil mierdas, desde una calculadora, hasta convertidores de data types... 
// hay infinitas posibilidades.


// Vamos a ir al grano y rapidito:
// Primero ponemos la carpeta "TutorialMolon2.Stratis" de este tutorial en el mismo sitio que teníais el primer TutorialMolon.
// Veréis que hay archivos nuevos, vamos por partes:

// Abrimos description.ext
// lo leemos y volvemos aquí cuando os lo diga XD





// Ya deberías estar de vuelta, así que vamos a ir directamente al tajo
// Entramos en el editor 3D y cargamos la misión con ctrl + O.
// Botón central para colocar la cámara y M para modo 3D.
// Pulsamos intro para entrar.

// Ahora pulsamos ESC y debajo del monitor hay 6 botones, uno de ellos es... GUI EDITOR... CHAN CHAAAAAAN.
// Cuando hayamos pulsado, tendremos que pulsar ESC de nuevo para cerrar el menú de pausa.
// Tenemos una cuadrícula en medio de la pantalla.
// No voy a explicar los controles porque si pulsáis H, os salen todos, así que los leéis ahora xD

// Vamos a dejar claro el vocabulario:
// display --> también le llamo dialog, menú o diálogo, conunto de controles.
// control --> también le llamo control (en español), elemento dentro del dialog, por ejemplo un botón.

// Digamos que el display es la caja que contiene todos los controles.


// Ahora hacemos click derecho en medio de la pantalla
// Elegimos RscButton (más tarde explicaré los tipos más comunes)
// Ese cuadrado negro, lo puedes mover manteniendo click
// Y si mantienes ALT, le cambias el tamaño
// Si quieres moverlo con precisión, pulsa las flechas (del teclado)

// Para editar sus propiedades, click derecho sobre él

// Rellenamos los siguientes datos:

/*
class (nombre del control)
	boton

text (texto que muestra, si es que puede hacerlo)
	CLICK

Position type:
	SAFEZONE
*/

// Ahora vuestro botón tiene un texto
// Vamos a crear otro control:

// click derecho bla bla RscEdit

/*
class: edit
text: soy texto
position type: safezone (esto SIEMPRE será así, para minimizar incompatibilidades con otras resoluciones)
*/

// Lo mío tiene esta forma
// https://i.gyazo.com/e36b7d3c53038c7aae9202d6d3be82a2.png

// Ahora lo que yo SIEMPRE hago es darle a ESC para que me pida guardar antes de salir, le digo que sí
// pongo el nombre del dialog: tutorial
// Ahora tienes algo en el portapapeles, ctrl + V en la línea 99 (aquí abajo)

// >>> Borra esto y pega el tuyo aquí
$[1.063,["tutorial",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],[1600,"boton",[1,"CLICK",["0.443281 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.134062 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[1400,"edit",[1,"soy texto",["0.443281 * safezoneW + safezoneX","0.4318 * safezoneH + safezoneY","0.134062 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]]


// debería de ser muy parecido al de la 100, que es el mío
// esto es el "proyecto" de GUI Editor, si lo tienes en el portapapeles y abres GUI Editor, retomarás eso que estabas haciendo

// abre GUI Editor de nuevo
// y ahí tienes tu dialog si haces más cambios, tendrás que hacer lo mismo para guardar.
// Aconsejo guardar todos los proyectos en un .txt, pero de momento te dejo guardarlo aquí. *

// * Gastos de guardado 1.12€ / hora. IVA no incluído. Gastos de gestión 1.56€ / minuto. Impuestos indirectos 9.43€.

// Si has cerrado el GUI Editor, ábrelo
// Pulsamos SHIFT + CTRL + S
// Y pegamos en otro documento en blanco, pero deberías de tener algo así:

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Icaruk, v1.063, #Zyriba)
////////////////////////////////////////////////////////

class boton: RscButton
{
	idc = 1600;
	text = "CLICK"; //--- ToDo: Localize;
	x = 0.443281 * safezoneW + safezoneX;
	y = 0.467 * safezoneH + safezoneY;
	w = 0.134062 * safezoneW;
	h = 0.044 * safezoneH;
};
class edit: RscEdit
{
	idc = 1400;
	text = "soy texto"; //--- ToDo: Localize;
	x = 0.443281 * safezoneW + safezoneX;
	y = 0.4318 * safezoneH + safezoneY;
	w = 0.134062 * safezoneW;
	h = 0.033 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

// Vale pues, vamos a plantilla.hpp
// Y pegamos el contenido dentro de "class controls {}" borrando mierda inútil, se nos queda algo así:

class nombreDeDialog
{
	idd = -1; // ID del display
	onLoad = "uiNamespace setVariable ['nombreDeDialog', _this select 0];"; // esto se lanza al cargar
	onUnLoad = "uiNamespace setVariable ['nombreDeDialog', nil]; "; // esto se lanza al descargar
	
	class controls { // contenido del dialog

		class boton: RscButton // nombre de control : clase de control
		{
			idc = 1600; // IDC = IDControl, esto ahora lo cambiaremos
			text = "CLICK";
			x = 0.443281 * safezoneW + safezoneX; // posición en el eje X
			y = 0.467 * safezoneH + safezoneY; // posición en el eje Y
			w = 0.134062 * safezoneW; // width --> ancho
			h = 0.044 * safezoneH; // height --> alto
		};
		class edit: RscEdit
		{
			idc = 1400;
			text = "soy texto";
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.4318 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};


// donde pone nombreDeDialog ponemos miPrimerDialog (no me seáis melones y lo hagáis aquí eh, id a plantilla.hpp xD)
// doble click en la palabra, ctrl + H
// reemplazar todo

// Ahora dentro del juego ejecutamos:
createDialog "miPrimerDialog"

// pero dirá que no encuentra una mierda, así que vamos a mirar en description.ext
// línea 19, parece que está bien incluído
// pero el ArmA es muy gracioso y cada vez que cambiemos algo de description.ext hay que hacer lo siguiente:
// ESC, volver al editor
// ctrl  + O
// vuelves a cargar el proyecto de la misión
// entras y repites

createDialog "miPrimerDialog"

// y ahí está, vuestra creación

// Explico unos cuantos tipos de control y os mando deberes:

/*
rscButton: pues un botón, que pulsas y lanza el código que le asignes
rscEdit: un cuadro de texto en el que puedes escribir cosas
IGUIBack: básicamente un fondo
rscListBox: una lista a la que le puedes añadir elementos
rscText: un cuadro que muestra texto, pero no puedes escribir cosas
*/

// Consejos en el GUI Editor:

/*
Si pulsas o mantienes espacio, se iluminarán de rosa/moraditoraro todos los controles
porque si son transparentes es jodido encontrarlos.

Si pulsas G se oculta la cuadrícula

Si pulsas ctrl + B se pone todo el fondo gris, aunque yo prefiero mirar al cielo en primera persona

Si pulsas ctrl + L te saldrá un menú con las capas, rollo Photoshop, la que está más abajo es la más profunda, pero ojo
que en el .hpp la que está más arriba, es la más profunda.
Si aquí las pones en orden, en el .hpp también lo estarán.
Desde aquí también puedes editar cada capa más cómodamente, por si tienes 50 controles superpuestos.

*/

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




// REPASO para hacer un dialog:

/*
- Tener el defines.hpp
- Tener la plantilla.hpp
- Incluír ambos en description.ext
- Meter lo que hagamos en el GUI Editor dentro de la plantilla
- Reiniciar el proyecto del editor
- createDialog "nombreDeTuDialog"
*/



