#SingleInstance force

#Include %A_LineFile%\..\..\TcCommandSetter.ahk

	;;;COMMAND	       MENU	       TOOLTIP	       ICON	PARAMETERS
$commands :=	{"command-full":	[ "Menu Text",	"Toolitip Text",	"%systemroot%\system32\shell32.dll",	"%P"	]							
	,"command-empty":	[ "",	"",	"",	""	]}
	

new TcCommandSetter()
		.commands($commands)
		.prefix("TcCommandSetter - Test - ")
		.createCommands()
