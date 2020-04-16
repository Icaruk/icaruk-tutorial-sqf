
// Lo �ltimo que os dije fu� lo siguiente:

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
	- La de pasar a de negativo a positivo, y si es positivo, que lo deje igual.
	- Una funci�n que me une getPos y getMarkerPos en el mismo comando
	
�Que vuele la imaginaci�n... y google!
*/


// Lo de la funci�n �til, pueden ser mil mierdas, desde una calculadora, hasta convertidores de data types... 
// hay infinitas posibilidades.


// Vamos a ir al grano y rapidito:
// Primero ponemos la carpeta "TutorialMolon2.Stratis" de este tutorial en el mismo sitio que ten�ais el primer TutorialMolon.
// Ver�is que hay archivos nuevos, vamos por partes:

// Abrimos description.ext
// lo leemos y volvemos aqu� cuando os lo diga XD





// Ya deber�as estar de vuelta, as� que vamos a ir directamente al tajo
// Entramos en el editor 3D y cargamos la misi�n con ctrl + O.
// Bot�n central para colocar la c�mara y M para modo 3D.
// Pulsamos intro para entrar.

// Ahora pulsamos ESC y debajo del monitor hay 6 botones, uno de ellos es... GUI EDITOR... CHAN CHAAAAAAN.
// Cuando hayamos pulsado, tendremos que pulsar ESC de nuevo para cerrar el men� de pausa.
// Tenemos una cuadr�cula en medio de la pantalla.
// No voy a explicar los controles porque si puls�is H, os salen todos, as� que los le�is ahora xD

// Vamos a dejar claro el vocabulario:
// display --> tambi�n le llamo dialog, men� o di�logo, conunto de controles.
// control --> tambi�n le llamo control (en espa�ol), elemento dentro del dialog, por ejemplo un bot�n.

// Digamos que el display es la caja que contiene todos los controles.


// Ahora hacemos click derecho en medio de la pantalla
// Elegimos RscButton (m�s tarde explicar� los tipos m�s comunes)
// Ese cuadrado negro, lo puedes mover manteniendo click
// Y si mantienes ALT, le cambias el tama�o
// Si quieres moverlo con precisi�n, pulsa las flechas (del teclado)

// Para editar sus propiedades, click derecho sobre �l

// Rellenamos los siguientes datos:

/*
class (nombre del control)
	boton

text (texto que muestra, si es que puede hacerlo)
	CLICK

Position type:
	SAFEZONE
*/

// Ahora vuestro bot�n tiene un texto
// Vamos a crear otro control:

// click derecho bla bla RscEdit

/*
class: edit
text: soy texto
position type: safezone (esto SIEMPRE ser� as�, para minimizar incompatibilidades con otras resoluciones)
*/

// Lo m�o tiene esta forma
// https://i.gyazo.com/e36b7d3c53038c7aae9202d6d3be82a2.png

// Ahora lo que yo SIEMPRE hago es darle a ESC para que me pida guardar antes de salir, le digo que s�
// pongo el nombre del dialog: tutorial
// Ahora tienes algo en el portapapeles, ctrl + V en la l�nea 99 (aqu� abajo)

// >>> Borra esto y pega el tuyo aqu�
$[1.063,["tutorial",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],[1600,"boton",[1,"CLICK",["0.443281 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.134062 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[1400,"edit",[1,"soy texto",["0.443281 * safezoneW + safezoneX","0.4318 * safezoneH + safezoneY","0.134062 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]]


// deber�a de ser muy parecido al de la 100, que es el m�o
// esto es el "proyecto" de GUI Editor, si lo tienes en el portapapeles y abres GUI Editor, retomar�s eso que estabas haciendo

// abre GUI Editor de nuevo
// y ah� tienes tu dialog si haces m�s cambios, tendr�s que hacer lo mismo para guardar.
// Aconsejo guardar todos los proyectos en un .txt, pero de momento te dejo guardarlo aqu�. *

// * Gastos de guardado 1.12� / hora. IVA no inclu�do. Gastos de gesti�n 1.56� / minuto. Impuestos indirectos 9.43�.

// Si has cerrado el GUI Editor, �brelo
// Pulsamos SHIFT + CTRL + S
// Y pegamos en otro documento en blanco, pero deber�as de tener algo as�:

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
// Y pegamos el contenido dentro de "class controls {}" borrando mierda in�til, se nos queda algo as�:

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
			x = 0.443281 * safezoneW + safezoneX; // posici�n en el eje X
			y = 0.467 * safezoneH + safezoneY; // posici�n en el eje Y
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


// donde pone nombreDeDialog ponemos miPrimerDialog (no me se�is melones y lo hag�is aqu� eh, id a plantilla.hpp xD)
// doble click en la palabra, ctrl + H
// reemplazar todo

// Ahora dentro del juego ejecutamos:
createDialog "miPrimerDialog"

// pero dir� que no encuentra una mierda, as� que vamos a mirar en description.ext
// l�nea 19, parece que est� bien inclu�do
// pero el ArmA es muy gracioso y cada vez que cambiemos algo de description.ext hay que hacer lo siguiente:
// ESC, volver al editor
// ctrl  + O
// vuelves a cargar el proyecto de la misi�n
// entras y repites

createDialog "miPrimerDialog"

// y ah� est�, vuestra creaci�n

// Explico unos cuantos tipos de control y os mando deberes:

/*
rscButton: pues un bot�n, que pulsas y lanza el c�digo que le asignes
rscEdit: un cuadro de texto en el que puedes escribir cosas
IGUIBack: b�sicamente un fondo
rscListBox: una lista a la que le puedes a�adir elementos
rscText: un cuadro que muestra texto, pero no puedes escribir cosas
*/

// Consejos en el GUI Editor:

/*
Si pulsas o mantienes espacio, se iluminar�n de rosa/moraditoraro todos los controles
porque si son transparentes es jodido encontrarlos.

Si pulsas G se oculta la cuadr�cula

Si pulsas ctrl + B se pone todo el fondo gris, aunque yo prefiero mirar al cielo en primera persona

Si pulsas ctrl + L te saldr� un men� con las capas, rollo Photoshop, la que est� m�s abajo es la m�s profunda, pero ojo
que en el .hpp la que est� m�s arriba, es la m�s profunda.
Si aqu� las pones en orden, en el .hpp tambi�n lo estar�n.
Desde aqu� tambi�n puedes editar cada capa m�s c�modamente, por si tienes 50 controles superpuestos.

*/

// Ahora los deberes:

// Quiero un men� jodidamente bonito que tenga:

/*
- Un bot�n
- Un cuadro para meter texto
- Una lista
- Un texto
- Un fondo
*/

// Haced el men� pensando en que el bot�n a�adir� el texto editable en la lista,
// y el texto mostrar� el count de los elementos de la lista.
// M�s o menos.




// REPASO para hacer un dialog:

/*
- Tener el defines.hpp
- Tener la plantilla.hpp
- Inclu�r ambos en description.ext
- Meter lo que hagamos en el GUI Editor dentro de la plantilla
- Reiniciar el proyecto del editor
- createDialog "nombreDeTuDialog"
*/



