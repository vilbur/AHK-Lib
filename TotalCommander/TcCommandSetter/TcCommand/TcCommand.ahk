#Include %A_LineFile%\..\TcShortcut\TcShortcut.ahk

/** Class TCcommand
*/
Class TCcommand
{
	_commander_path	:= ""	
	_usercmd_ini	:= "" ; save 
	
	_prefix	:= ""	
	;_name	:= ""
	_section	:= ""	
	
	_cmd	:= ""		
	_param	:= ""
	_menu	:= ""	
	_tooltip	:= ""	
	_button	:= "%systemroot%\system32\shell32.dll,43"			
	
	/** _setTabsPath
	 */
	__New()
	{
		$commander_path	= %Commander_Path%	
		$_usercmd_ini	= %Commander_Path%\usercmd.ini		
		this._commander_path	:= $commander_path		
		this._usercmd_ini	:= $_usercmd_ini		
	}
	/** set prefix
	  * @param	string	$prefix	for commands name, menu and tooltip text
	 */
	prefix( $prefix:="" )
	{
		this._prefix := $prefix
		
		return this		
	} 
	;/**
	; */
	;name( $name )
	;{
	;	this._name 	:= $name
	;	;this._shortcut	:= new TcShortcut().name(this._name)
	;	return this 		
	;}
	/**
	 */
	cmd( $cmd )
	{
		this._cmd := $cmd 
		
		return this 		
	}
	/**
	 */
	param( $params* )
	{
		this._param 	:= $params

		return this
	}
	/**
	 */
	menu( $menu_title )
	{
		this._menu := $menu_title
		
		return this 		
	}	
	/**
	 */
	tooltip( $tooltip )
	{
		this._tooltip := $tooltip
		
		return this 		
	}
	/**
	 */
	icon( $icon )
	{
		if( $icon )
			this._button := $icon

		return this 		
	}
	/**
	 */
	create()
	{
		this._setSection()
		
		this._writeToIni( "menu" )		
		this._writeToIni( "cmd" )
		this._writeToIni( "param" )
		this._writeToIni( "tooltip" )		
		this._writeToIni( "button" )
		
		this._appendEmptyLine()
		
		return this
	}
	/**
	 */
	delete( )
	{
		if( this._name )
			IniDelete, % this._usercmd_ini, % this._name
		return this
	}
	/**
	 */
	shortcut( $keys* )
	{
		if( $keys )
			return % this._shortcut.keys($keys)
		
		return this._shortcut
	}
	

	/**
	 */
	_setSection()
	{
		$prefix_name := RegExReplace( this._prefix, "\s+", "" ) 
		this._section := "em_" $prefix_name "-" this._cmd
	} 
	/**
	 */
	_writeToIni( $key )
	{
		$value := this["_get" $key "Value" ]()
	
		if( $value != "" )
			IniWrite, %$value%,	% this._usercmd_ini, % this._section, %$key%		
	}
	/**
	 */
	_appendEmptyLine()
	{
		FileAppend, `n, % this._usercmd_ini	
	}
	/*---------------------------------------
		GET VALUES
	-----------------------------------------
	*/
	/**
	 */
	_getPrefix()
	{
		return this._prefix ? this._prefix " - " : ""
	
	} 

	/**
	 */
	_getMenuValue()
	{
		return this._getPrefix() RegExReplace( this._cmd, "[-_]", " " ) 
	}
	/**
	 */
	_getCmdValue()
	{
		return this._replaceCommanderPathEnvVariable(this._cmd)
	}
	/**
	 */
	_getParamValue()
	{
		if( this._param.length()>0 && this._param[1]!=""  )
			For $i, $param in this._param
				$params .= this._escapeParameter($param) " "
				
		return $params
	}
	/**
	 */
	_getTooltipValue()
	{
		return this._tooltip ? this._getPrefix() this._tooltip : this._getMenuValue()
	}
	/**
	 */
	_getButtonValue()
	{
		return this._replaceCommanderPathEnvVariable(this._button)
	}	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	
	/** Replace path to %COMMANDER_PATH% back
			E.G.: "C:\TotalCommander" >>> "%COMMANDER_PATH%"
	 */
	_replaceCommanderPathEnvVariable( $path )
	{
		$commander_path_rx := RegExReplace( this._commander_path, "i)[\\\/]+", "\\" )
		return % RegExReplace( $path, "i)" $commander_path_rx, "%COMMANDER_PATH%" ) 
	}
	/** escape and quote %T & %P parameter
	 */
	_escapeParameter( $param )
	{
		if( RegExMatch( $param, "i)^%[TP]$" )  )
			return % """" $param "\""" ;;;;;; "
		
		return %$param%
	} 
}

