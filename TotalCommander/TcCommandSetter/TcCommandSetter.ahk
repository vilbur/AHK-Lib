#Include %A_LineFile%\..\TcCommand\TcCommand.ahk

/** TcCommandSetter
  *
  * Mass creator for TcCommands
  *
  */
Class TcCommandSetter
{
	_TcCommand 	:= new TcCommand()
	_commands	:= {} ; definition for commands
	_prefix	:= ""	; 
	
	
	/** set definition for commands
	  *
	  * @param object $commands {"command":	[ "MENU",	"TOOLTIP",	"ICONPATH",	"PARAMETERS"	]}
	  */
	commands( $commands:="" )
	{
		this._commands := $commands
		
		return this
	}
	/** set prefix
	  * @param	string	$prefix	for commands name, menu and tooltip text
	 */
	prefix( $prefix:="" )
	{
		this._prefix := $prefix
		
		return this		
	} 
	
	/** Create all commands
	 */
	createCommands()
	{
		$prefix_name := RegExReplace( this._prefix, "\s+", "" ) 
		
		For $command, $values in this._commands
			this._TcCommand.clone()
					.name( $prefix_name $command)
					.param($values[4])
					.menu( this._getMenuText( $values ) )
					.tooltip( this._getTooltip( $values ) )
					.icon($values[3])			
					.create()
	}
	
	/**
	 */
	_getMenuText( $values )
	{
		return $values[1] ? this._prefix $values[1] : ""
	} 
	/**
	 */
	_getTooltip( $values )
	{
		return $values[2] ? this._prefix $values[2] : ""
	} 
	
	
}

