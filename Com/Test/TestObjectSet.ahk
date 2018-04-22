#SingleInstance force
;#Persistent

#Include  %A_ScriptDir%\ObjRegisterActive_TestClass.ahk
#Include  %A_ScriptDir%\..\ObjRegisterActive.ahk


; Register our object so that other scripts can get to it.  The second
; parameter is a GUID which I generated.  You should generate one unique
; to your script.  You can use [CreateGUID](http://goo.gl/obfmDc).

$test_object := Object()
$test_object.key := "valueX"

;$test_object := {"key":"value"}

ObjRegisterActive($test_object, "{6B39CAA1-A320-4CB0-8DB4-352AA81E460E}")


$test_set := ComObjActive( "{6B39CAA1-A320-4CB0-8DB4-352AA81E460E}")
;$test_set.setVar("test")

#Persistent
OnExit Revoke
return

Revoke:
; This "revokes" the object, preventing any new clients from connecting
; to it, but doesn't disconnect any clients that are already connected.
; In practice, it's quite unnecessary to do this on exit.
ObjRegisterActive($test_object, "")
ExitApp

