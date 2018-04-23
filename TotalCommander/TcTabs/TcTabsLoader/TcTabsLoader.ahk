/** TcTabsLoader
 *
 */
Class TcTabsLoader extends TcCore
{
	_usercmd_ini	:= "" ; save commands
	_cmd_name	:= "em_TcTabsLoader_load-tabs"
	_command_exists	:= 0
	
	/** _setTabsPath
	 */
	__New()
	{
		this._init()
		this._setIniFile( "usercmd.ini" )		
	}
	/** load tabs file
	 */
	load( $tab_file_path )
	{
		this._setCommandExistsTest()
		this._editCommandLoadTabs("OPENTABS """ $tab_file_path """")
		sleep, 100
		this._createShortcut()
		this._restartCommanderIfFirstTimeLoad()
		this._executeShortcut()
	}

	/** Edit command in wincmd.ini
		This command is loading tab files
	 */
	_editCommandLoadTabs( $open_tabs_cmd )
	{
		IniWrite, %$open_tabs_cmd%, % this._usercmd_ini, % this._cmd_name, cmd
	}
	
	/** create command in wincmd.ini
	 */
	createCommandRunTabSwitcher()
	{
		$param := """%P\""" ; "
		IniWrite, % A_ScriptDir "\TabsSwitcher.ahk",	% this._usercmd_ini, % this._cmd_run_tabswitcher, cmd
		IniWrite, %$param%,	% this._usercmd_ini, % this._cmd_run_tabswitcher, param		
	}
	
	/** create keyboard shortcut to run this._cmd_name command
		create keyboard shortcut in section "ShortcutsWin"
		section "ShortcutsWin" runs keyboard shortcuts with win key 
	 */
	_createShortcut()
	{
		$keyboard_shortcut :=  ; Ctrl + alt + Shift
		this._setShortcutToIni( "ShortcutsWin", "CAS+F9", this._cmd_name )
	}
	/**
	  create command in Usercmd.ini
	 */
	_setShortcutToIni( $section, $key, $value )
	{
		IniWrite, %$value%, % this._wincmd_ini, %$section%, %$key%
	}
	
	/**
		https://autohotkey.com/docs/commands/WinExist.htm#function
	 */
	_executeShortcut()
	{

		ControlSend,, {LWin down}{Ctrl down}{Alt down}{Shift down}{F9}{LWin up}{Ctrl up}{Alt up}{Shift up}, % this.ahkId()
	}
	/**
	 */
	_setCommandExistsTest()
	{
		IniRead, $command_exists, % this._usercmd_ini, % this._cmd_name, cmd, 0
		
		this._command_exists
	}  
 
	/** Total Commander needs restart, if command does not exists yet
	 */
	_restartCommanderIfFirstTimeLoad()
	{
		if( ! this._command_exists )
			return
			
		MsgBox, 4, , Command for loading does not exists yet.`n`nTotal Commander needs to be restarted
		IfMsgBox, Yes
			return % this._restartTotalCommander()
			
		exitApp
	}  
	/**
	 */
	_restartTotalCommander()
	{
		$commadner_process	:= this.proccesName()
		$commadner_path	= %Commander_Path%\%$commadner_process%
		
		WinClose , % this.ahkId()
		
		sleep, 200
		Run *RunAs %$commadner_path%
		
		WinWait, ahk_class TTOTAL_CMD,,2
		
		this._init()
	}  
	
	
	
	
	
}