#NoEnv
/* Download and unzip files specified in .ini file
*
*	Designed to batch downloading from github
*
*
*
*/


$ini_path	:=  RegExReplace( A_ScriptFullPath, "\.(ahk|exe)$", ".ini" )

if( ! FileExist($ini_path)  ){
	IniWrite, /relative-or-absolute-path-to-download-dir, %$ini_path%, url-dir, http://www.sample-videos.com/text/Sample-text-file-10kb.txt
	
	MsgBox,262144, INI FILE DOES NOT EXITS, % "Example .ini file has been created`n`n" $ini_path
	exitApp
}




IniRead, $sections, %$ini_path%, url-dir
	Loop Parse, $sections, `n
		downLoadFile(A_LoopField)




MsgBox,262144, DOWNLOAD SUCCESS, Files has been downloaded
exitApp





/** downLoadFile
*/
downLoadFile($key_value)
{
	$key_value	:= StrSplit($key_value, "=")
	$url	:= $key_value[1]
	$dir	:= $key_value[2]
	
	if( ! RegExMatch( $dir, "i)[A-Z]:[\\\/]" ) )
		$dir	= %A_ScriptDir%%$dir%
	
	SplitPath, $url, $file_name, , $extension
	$file_path	= %$dir%\%$file_name%
	
	FileCreateDir, %$dir%
		
	UrlDownloadToFile, %$url%, %$file_path%

	if( $extension == "zip")
	{
		Unzip($file_path, $dir)
		FileDelete, %$file_path% 
	}
}

Unzip($zip_path, $location)
{
    $fso := ComObjCreate("Scripting.FileSystemObject")
    If Not $fso.FolderExists($location)  ;http://www.autohotkey.com/forum/viewtopic.php?p=402574
       $fso.CreateFolder($location)
    $psh  := ComObjCreate("Shell.Application")
    $psh.Namespace( $location ).CopyHere( $psh.Namespace( $zip_path ).items, 4|16 )
}
