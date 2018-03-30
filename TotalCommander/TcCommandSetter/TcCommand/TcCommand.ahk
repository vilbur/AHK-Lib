#Include %A_LineFile%\..\TcShortcut\TcShortcut.ahk

/** Class TCcommand
*/
Class TCcommand
{
	_commander_path	:= ""	
	_usercmd_ini	:= "" ; save commands
	_name	:= ""
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
	/**
	 */
	name( $name )
	{
		this._name_raw 	:= $name
		this._name 	:= "em_" this._name_raw		
		this._shortcut	:= new TcShortcut().name(this._name)
		return this 		
	}
	/**
	 */
	cmd( $cmd )
	{
		this._cmd := """" this._replaceCommanderPathEnvVariable($cmd) """"
		
		return this 		
	}
	/**
	 */
	param( $params* )
	{

		if( $params.length()>0 && $params[1]!=""  )
			For $i, $param in $params
				this._param .= this._escapeParameter($param) " "
				
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
			this._button :=this._replaceCommanderPathEnvVariable($icon)
		
		return this 		
	}
	/**
	 */
	create()
	{
		this._setDefaultMenu()
		this._setDefaultTooltip()		
		
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
	_writeToIni( $key )
	{
		
		if( this["_" $key ] != "" )
			IniWrite, % this["_" $key ],	% this._usercmd_ini, % this._name, %$key%		
	}
	/**
	 */
	_appendEmptyLine()
	{
		FileAppend, `n, % this._usercmd_ini	
	}
	/*---------------------------------------
		SET DEFAULTS
	-----------------------------------------
	*/
	/**
	 */
	_setDefaultMenu()
	{
		if( ! this._menu )
			this._menu := this._name_raw
	}
	/**
	 */
	_setDefaultTooltip()
	{
		if( ! this._tooltip )
			this._tooltip := this._menu
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

