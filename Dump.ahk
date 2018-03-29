#Include %A_LineFile%\..\Dump\Dump.ahk
/*
	get new class object
*/
Dump($object,$label:="",$expand:=0){
	if($Dump == "") 
		$Dump := new Dump($Hwnd_in)				
		
	$Dump.add($object, $label,$expand)
}
