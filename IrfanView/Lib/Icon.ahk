/** Class Icon
*/
Class Icon extends Parent
{
	
	_path_temp_dir	:= A_Temp
	_dimensions	:= ["32x32", "36x24"]
	_crop	:= ["3,6,24,24", "5,8,24,12"]
	
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
		this._text	:= this._sanitizeStrings($text_split)

		For $i, $text in this._text
			this._downloadAndCropTextImage( $text )
		
		this._convertToIcon()
		this._deleteTempFiles()		
		
		return this
	}
	/**
	 */
	_sanitizeStrings( $strings )
	{
		$sanitized := []
		
		For $i, $string in $strings
		{
			$string := RegExReplace( $string, "^[_-\s]+|[[_-\s]+]$", "" )
			StringLower, $string, $string
			
			if( $string )
				$sanitized.push($string)
		}
		return $sanitized
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
		;Dump(this._getPanoramaParameter(), "this._getPanoramaParameter()", 1)
		;Dump(this._path, "this._path", 1)
		
		Run, % this.Parent()._iview_path " " this._getPanoramaParameter() " /convert=" this._path
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
	_deleteTempFiles(  )
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
  