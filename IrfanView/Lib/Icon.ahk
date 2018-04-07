/** Create text icon via IrfanView
*/
Class Icon extends Parent_iv
{
	;_path_temp_dir	:= A_Temp "\IrfanView\icons"
	_path_temp_dir	:= A_ScriptDir 	
	_dimensions	:= ["32x32",	"30x22"]	
	_crop	:= ["3,6,24,24",	"2,6,24,12"]
	
	_background	:= "white"
	_forground	:= "black"
	
	/** path to icon
	 */
	path( $path:="" )
	{
		this._path := $path
		return this
	}
	/**
		@param string color $background
		@param string color $forground		
		
		colors "black|white|red|green|blue"
	 */
	color( $background:="", $forground:="" )
	{
		if( $background )
			this._background	:= $background
		if( $forground )
			this._forground	:= $forground		
		
		return this
	} 
	/**
	 */
	text( $text )
	{
		$text 	:= RegExReplace( $text, "[\s-]+", " " ) 
		$text_split	:= StrSplit( $text, A_Space )
		this._text	:= this._sanitizeAllStrings($text_split)
		
		return this
	}
	/**
	 */
	create()
	{		
		For $i, $text in this._text
			this._downloadAndCropTextImage( $text )
		
		this._convertToIcon()
		this._deleteTempFiles()	
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
		$whitepace	:= ""
		$string	:= RegExReplace( $string, "^[_-\s]+|[[_-\s]+]$", "" )
		$string_length	:= StrLen($string )

		if( $string_length>5 )
			$string	:= RegExReplace( $string, "i)[aeiou]", "" )			

		;$string	:= SubStr( $string "++++", 1, 5 )
		
		return $string
	}
	
	/**
	 */
	_downloadAndCropTextImage( $text )
	{
		$path	:= this._path_temp_dir "\\" $text ".gif"
		$colors	:=  "/" this._getColor( this._background ) "/" this._getColor( this._forground ) 
		
		UrlDownloadToFile, % "https://dummyimage.com/" this._dimensions[this._text.length()] $colors ".gif&text=" $text, %$path%		
		sleep, 500

		Run, % this.Parent()._iview_path " " $path " /crop=(" this._crop[this._text.length()] ") /convert=" $path
		;sleep, 500		
	}
	/** Merge temp images, set transparent color, save to final icon file
	 */
	_convertToIcon()
	{
		
		Run, % this.Parent()._iview_path " " this._getPanoramaParameter() " /transpcolor=(255,255,255) /convert=" this._path
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
	/**
	 */
	_getColor( $color )
	{
		StringLower, $color, $color
		
		if( $color=="black" )
			return "000000"
			
		else if( $color=="white" )
			return "ffffff"
			
		else if( $color=="red" )
			return "e40000"
		
		else if( $color=="green" )
			return "05e400"
			
		else if( $color=="blue" )
			return "0086e4"

	} 
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  