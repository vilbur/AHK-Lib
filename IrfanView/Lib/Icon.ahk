/** Class Icon
*/
Class Icon extends Parent
{
	
	_path_temp_dir	:= A_Temp
	;_path_temp_dir	:= A_ScriptDir 	
	;_dimensions	:= ["32x32",	"30x22"]
	_dimensions	:= ["32x32",	"30x22"]	
	_crop	:= ["3,6,24,24",	"2,6,24,12"]
	
	__New(){

	}

	/**
	 */
	path( $path:="" )
	{
		this._path := $path
		return this
	} 
	/**
	 */
	text( $text )
	{
		$text 	:= RegExReplace( $text, "[\s-]+", " " ) 
		$text_split	:= StrSplit( $text, A_Space )
		this._text	:= this._sanitizeAllStrings($text_split)

		For $i, $text in this._text
			this._downloadAndCropTextImage( $text )
		
		this._convertToIcon()
		this._deleteTempFiles()		
		
		return this
	}
	/**
	 */
	_sanitizeAllStrings( $strings )
	{
		$sanitized := []
		
		For $i, $string in $strings
			$sanitized.push(this._sanitizeString($string))
		
		return $sanitized
	}
	/** remove dashes
	  * remove [aeiou] if string is longer then 5 chars   
	 */
	_sanitizeString( $string )
	{
		;StringLower, $string, $string
		$string	:= RegExReplace( $string, "^[_-\s]+|[[_-\s]+]$", "" )
		;StringLen, $string_length, $string 
		$string_length := StrLen($string )

		if( $string_length>5 ){
			$string	:= RegExReplace( $string, "i)[aeiou]", "" )
			;MsgBox,262144,%$string_length%, %$string%,3 
			
			$string	:= SubStr($string, 1, 5 )
		}

		
		return $string
	}
	
	/**
	 */
	_downloadAndCropTextImage( $text )
	{
		$path := this._path_temp_dir "\\" $text ".gif"
		
		UrlDownloadToFile, % "https://dummyimage.com/" this._dimensions[this._text.length()] "/ffffff/000000.gif&text=" $text, %$path%
		sleep, 500
		Run, % this.Parent()._iview_path " " $path " /crop=(" this._crop[this._text.length()] ") /convert=" $path
		sleep, 500		
	}
	/**
	 */
	_convertToIcon()
	{
		Run, % this.Parent()._iview_path " " this._getPanoramaParameter() " /transpcolor=(255,255,255) /convert=" this._path
		;Run, % this.Parent()._iview_path " " this._getPanoramaParameter() " /convert=" this._path		
	}	
	/**
	 */
	_getPanoramaParameter()
	{
		if( this._text.length()==1 )
			return % this._getTempFilePath( this._text[1] )
			
		For $i, $text in this._text
			$files .= this._getTempFilePath( $text ) ","
		
		StringTrimRight, $files, $files, 1 
		
		return % " /panorama=(2," $files ")"
	}
	
	
	/**
	 */
	_deleteTempFiles()
	{
		sleep, 1000
		For $i, $text in this._text
			FileDelete, % this._getTempFilePath( $text )
		
	}
	/**
	 */
	_getTempFilePath( $file_name )
	{
		return % this._path_temp_dir "\\" $file_name ".gif"
	} 
	
	
}
  