
class funcionesMaster // clase que contendrá todas las funciones
{
	tag = "tut"; // este tag hará que las funciones se llamen tut_fnc_nombreDeFuncion
	
	class funcionesTest1 // clase que contiene las funciones de la carpeta de funciones
	{
		file = "funciones"; // esta es la carpeta donde están las funciones
		class funcion1 {}; // el archivo se llama fn_funcion1.sqf
		class funcion2 {}; // el archivo se llama fn_funcion2.sqf
	};

	// Esto lo comento, porque sólo es un ejemplo de cómo seguir añadiendo más funciones
	/*
	class funcionesTest2
	{
		file = "funciones\subcarpeta";
		class funcion3 {};
		class funcion4 {};
	};
	*/
};