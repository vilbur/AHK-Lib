#SingleInstance force

#Include %A_LineFile%\..\..\..\..\TcCore.ahk
#Include %A_LineFile%\..\..\TcTabsLoader.ahk
#Include %A_LineFile%\..\..\..\..\TcPane\TcPane.ahk

$TcTabsLoader 	:= new TcTabsLoader()


$TcTabsLoader.load(A_ScriptDir "\test-both-sides.tab")

sleep, 2000
$TcTabsLoader.load(A_ScriptDir "\test-both-sides.tab", "left")

sleep, 2000
$TcTabsLoader.load(A_ScriptDir "\test-both-sides.tab", "right")

