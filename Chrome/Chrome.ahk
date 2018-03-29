;#NoTrayIcon
#SingleInstance force

/*
	save favicon of any website

	@EXAMPLE OF HOTSTRING CODE
		::geticon :: Chrome_GetFavIcon()

	Write 'geticon' anywhere in chrome, and current sites favicon will be saved with save dialog

*/
#Include  C:\GoogleDrive\Programs\Core\Chrome\_AhkScripts\Chrome\Chrome.ahk

/**
	CALL CLASS FUNCTION
*/
Chrome(){
	return % new Chrome()
}


/*
-----------------------------------------------
	TEST FUNCTIONS
-----------------------------------------------
*/
/** openChrome
*/
openChromeTest(){
	$Chrome := Chrome()
	;				.runChrome("google.com")
	;				.openUrl("youtube.com")
	;				.setMonitor(3)
	;				.setPosition(25,0)
	;				.setDimensions(75,100)
	;sleep,5000
	;$Chrome.toFront()
	;dump($Chrome, "$monitor", 1)
}

/*
-----------------------------------------------
	RUN TEST
-----------------------------------------------
*/
openChromeTest()
