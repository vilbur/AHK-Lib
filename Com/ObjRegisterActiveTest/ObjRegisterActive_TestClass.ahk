#SingleInstance force

;https://autohotkey.com/boards/viewtopic.php?t=6148

; Register our object so that other scripts can get to it.  The second
; parameter is a GUID which I generated.  You should generate one unique

/**
	Class ObjRegisterActive_TestClass
*/
Class ObjRegisterActive_TestClass {
	
	/** test
	*/
	test(){
		MsgBox,262144,, TEST SUCCESS, 2
	}
	/** setVar
	*/
	setVar($value){
		this.var := $value
		return this
	}
	/** getVar
	*/
	getVar(){
		MsgBox,262144,, % this.var, 2
	}	
	
}
