#SingleInstance force

#Include %A_LineFile%\..\..\Path.ahk
/**
-----------------------------------------------
	TEST
-----------------------------------------------
*/

global $path := new Path("%temp%\_AHK_FileTest")

/** Path_isTest
*/
Path_Test(){
	dump($path.getPath(), "getPath()", 1)
	;dump($path.split(), "split", 1)
	;dump($path.basename(), "basename", 0)
	;dump($path.getPath(), "path", 0)
	;dump($path.parentDir(), "parentDir", 0)
	;dump($path.parentDirName(), "parentDir", 0)
	;dump($path.isAbsolute(), "isAbsolute", 0)
	;dump($path.isDir(), "isDir", 0)
	;dump($path.isFile(), "isFile", 0)
	;dump($path.isHardlink(), "isHardlink", 0)
	;dump($path.isFileMask(), "isFileMask", 0)
	;dump($path.isMaskAll(), "isMaskAll", 0)
	;dump($path.currentProcess(), "currentProcess", 0)
	;dump($path.combine("folder").getPath(), "combine forward", 0)
	;dump($path.combine("..\..\test").getPath(), "combine backward", 0)
	;dump($path.setPath("\changed\Path").getPath(), "path", 0)

}
/** Path_Exists
*/
Path_Exists(){
	$path_exists := new Path("%WinDir%").exist()
	new Path("%WinDir%\notExists").exist(true)
	new Path("%WinDir%\notExists").exist("Custom error message Path().exist()")

}
/** Path_MaskTest
*/
Path_MaskTest(){
	$mask_all := $path
	dump($path.combine("\*.txt").getFiles(), "getFiles() txt", 1)

	dump($mask_all.combine("\*.*").getFiles(), "getFiles() files", 1)
	dump($mask_all.getFiles(2), "getFiles() folders", 1)
	dump($mask_all.getFiles(1,1), "getFiles() files & folders recursive", 1)

}
/** relativeTest
*/
Path_relativeTest(){
	;$relative := $path.relative("c:\Windows")
	$relative := $path.relative("%temp%", "/")
	dump($relative, "$relative", 0)
	MsgBox,262144,, %$relative%
}
/*
-----------------------------------------------
	RUN TEST
-----------------------------------------------
*/
;Path_Test()
;Path_Exists()
;Path_MaskTest()
;Path_relativeTest()
