#SingleInstance force
#Persistent

;https://autohotkey.com/boards/viewtopic.php?t=6148

; Register our object so that other scripts can get to it.  The second
; parameter is a GUID which I generated.  You should generate one unique


#Include  %A_ScriptDir%\..\ObjRegisterActive.ahk
/**
	Class ObjRegisterActiveTest
*/
Class ObjRegisterActiveTest
{
	/** setVar
	*/
	setVar($value)
	{
		this.var := $value
		
		return this
	}
	/** getVar
	*/
	getVar()
	{
		;MsgBox,262144,, % this.var, 2
		return % this.var	
	}	
	
}

$CLSID	= %1%

;$ObjRegisterActiveTest 	:= new ObjRegisterActiveTest()

ObjRegisterActive(ObjRegisterActiveTest, $CLSID)
;ObjRegisterActive($ObjRegisterActiveTest, $CLSID)

