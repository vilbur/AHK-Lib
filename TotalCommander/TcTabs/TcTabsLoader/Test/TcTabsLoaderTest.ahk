#SingleInstance force

#Include %A_LineFile%\..\..\..\..\TcCore.ahk
#Include %A_LineFile%\..\..\TcTabsLoader.ahk

$TcTabsLoader 	:= new TcTabsLoader()



$TcTabsLoader.load(A_ScriptDir "\test-both-sides.tab")