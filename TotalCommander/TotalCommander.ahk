/* Class TotalCommander
*/
Class TotalCommander
{
	_process_name	:= ""
	_hwnd	:= ""
	_previous_vindow	:= {"ahk_id":"","onTopState":""}

	/**
	 */
	_init()
	{
		this._setProcessName()
		this._setHwnd()
	}
	/** activate
	*/
	activate()
	{
		WinActivate, % this.hwnd()
	}
	/**
	 */
	hwnd()
	{
		return % "ahk_id " this._hwnd
	}
	/**
	 */
	proccesName()
	
	{
		return % this._process_name
	}
	/**
	 */
	_setProcessName()
	{
		WinGet, $process_name , ProcessName, ahk_class TTOTAL_CMD
		this._process_name := $process_name
	}
	/**
	 */
	_setHwnd()
	{
		WinGet, $hwnd , ID, ahk_class TTOTAL_CMD
		this._hwnd := $hwnd
	}
	/** Store id and and state of always on top for resotrion
	 */
	_saveActiveWindow()
	{
		this._previous_vindow :=	{"ahk_id" :	WinActive("A")
			,"onTopState":	this._isWindowALwaysOnTop()}
	}
	/** Activate & restore always on top state of previous window
	 */
	_restorePreviousWindow()
	{		
		if this._previous_vindow
		   WinActivate, % "ahk_id " this._previous_vindow.ahk_id
				
		$onTopState := this._previous_vindow.onTopState ? "On" : "Off"
		WinSet, AlwaysOnTop, %$onTopState%, A
	}
	/**
	 */
	_isWindowALwaysOnTop()
	{
		WinGet, ExStyle, ExStyle, A
		return (ExStyle & 0x8) == 8 ? true : false
	} 



}