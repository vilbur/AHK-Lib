#SingleInstance force
;#Persistent

#Include  %A_ScriptDir%\..\ObjRegisterActive.ahk


generateCLSID()
{
    VarSetCapacity(pguid, 16, 0)
    if !(DllCall("ole32.dll\CoCreateGuid", "ptr", &pguid)) {
        size := VarSetCapacity(sguid, (38 << !!A_IsUnicode) + 1, 0)
        if (DllCall("ole32.dll\StringFromGUID2", "ptr", &pguid, "ptr", &sguid, "int", size))
            return StrGet(&sguid)
    }
    return ""
}


;$CLSID	:= generateCLSID()
$CLSID	:= "{6B39CAA1-A320-4CB0-8DB4-352AA81E460E}"


try 
{
	$ObjRegisterActiveTest := ComObjActive($CLSID)
}


if( $ObjRegisterActiveTest )
{
	
	$ObjRegisterActiveTest.setVar("Test success")

	$ObjRegisterActiveTestGet := ComObjActive($CLSID)
	;
	MsgBox,262144,, % $ObjRegisterActiveTestGet.getVar(),2

}else
	Run, %A_LineFile%\..\ObjRegisterActiveTest.ahk %$CLSID%