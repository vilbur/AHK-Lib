#SingleInstance force

#Include %A_LineFile%\..\..\TcCommand.ahk
#Include %A_LineFile%\..\..\TcShortcut.ahk

/* Create command with shortcute
*/
$CommandCreate 	:= new TcCommand()

;$CommandCreate
;	.name("TcCommand-test")
;	.cmd("c:\GoogleDrive\TotalComander\TcCommand-test")
;	.param("Foo param")
;	.menu("Menu text")
;	.tooltip("If not defined, menu text is used")	
;	.icon("wcmicons.dll,43")
;	.create()
;	.shortcut( "ctr", "shift", "alt", "win", "f12" )
;	.create("force")		

new TcCommand()
	.name("TcCommand-escaped-path")
	.cmd("c:\GoogleDrive\TotalComander\TcCommand-test")
	.param("%P", "%T")
	.menu("Escape and add trailing slash to %P and %T params")
	.tooltip("Problems with quoting of path appear otherwise")	
	.create()



/* Delete command and shortcut
  
*/
;$CommandDelete := new TcCommand()

;$CommandDelete.name("TcCommand-test").delete()
		;.shortcut().delete()
	