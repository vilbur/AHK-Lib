#SingleInstance force
;#Include  %A_ScriptDir%\ObjRegisterActive_TestClass.ahk
#Include  %A_ScriptDir%\..\ObjRegisterActive.ahk


;ObjRegisterActive(ObjRegisterActive_TestClass)

$test_get := ComObjActive( "{6B39CAA1-A320-4CB0-8DB4-352AA81E460E}")
$test_get.getVar()