/* Class TotalCommander
*/
Class TotalCommander
{
	_process_name	:= ""
	_hwnd	:= ""
	_previous_vindow	:= ""

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
	/**
	 */
	_saveActiveWindow()
	{
		this._preview_vindow := WinActive("A")
	}
	/**
	 */
	_restorePreviousWindow()
	{
		if this._previous_vindow
		   WinActivate, ahk_id this._previous_vindow
	}



}