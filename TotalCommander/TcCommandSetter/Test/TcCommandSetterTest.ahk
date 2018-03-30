#SingleInstance force

#Include %A_LineFile%\..\..\TcCommandSetter.ahk
#Include %A_LineFile%\..\_commands.ahk


new TcCommandSetter()
		.commands($commands)
		.prefix($prefix)
		.createCommands()
