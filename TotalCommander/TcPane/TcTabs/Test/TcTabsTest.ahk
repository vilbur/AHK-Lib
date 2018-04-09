#SingleInstance force

#Include %A_LineFile%\..\..\..\TcPane.ahk

$TcPane 	:= new TcPane()
$TcTabs 	:= $TcPane.TcTabs()

$TcTabs.getTabs("left")