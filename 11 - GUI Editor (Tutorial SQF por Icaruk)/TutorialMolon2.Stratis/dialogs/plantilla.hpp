
class nombreDeDialog
{
	idd = -1; // ID del display
	onLoad = "uiNamespace setVariable ['nombreDeDialog', _this select 0];"; // esto se lanza al cargar
	onUnLoad = "uiNamespace setVariable ['nombreDeDialog', nil]; "; // esto se lanza al descargar
	
	class controls { // contenido del dialog
		// Aquí pegas lo que hagas con el GUI Editor
	};
};

