#SingleInstance force

#Include %A_LineFile%\..\..\IrfanView.ahk


$IrfanView 	:= new IrfanView()


$IrfanView.Icon( A_ScriptDir "\Single.ico" ).text("Single")
;$IrfanView.Icon( A_ScriptDir "\TestIcon.ico" ).text("_Text1-Text2")

$IrfanView.Icon( A_ScriptDir "\longString.ico" ).text("laravel vendor")