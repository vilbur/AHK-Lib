


$ini_path	:=  RegExReplace( A_ScriptFullPath, "\.(ahk|exe)$", ".ini" )

if( ! FileExist($ini_path)  ){
	IniWrite, /relative-or-absolute-path-to-download-dir, %$ini_path%, url-dir, http://www.sample-videos.com/text/Sample-text-file-10kb.txt
	
	MsgBox,262144, INI FILE DOES NOT EXITS, % "Example .ini file has been created`n`n" $ini_path
	exitApp
}


IniRead, $sections, %$ini_path%, url-dir
	Loop Parse, $sections, `n
		downLoadFile(A_LoopField)

/** downLoadFile
*/
downLoadFile($key_value)
{
	$key_value	:= StrSplit($key_value, "=")
	$url	:= $key_value[1]
	$dir	:= RegExReplace( RegExMatch( $key_value[2], "i)[A-Z]:[\\\/]" ) ? $key_value[2] : A_ScriptDir "\\" $key_value[2], "[\\/]+", "\\")
	SplitPath, $url, $file_name
	
	FileCreateDir, %$dir%
	
	UrlDownloadToFile, %$url%, %$dir%\%$file_name%
}

	
