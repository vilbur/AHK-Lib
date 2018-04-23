/* Class TcCore
*/
Class TcCore
{
	_process_name	:= ""
	_hwnd	:= ""

	/**
	 */
	_init()
	{
		this._setProcessName()
		this._setHwnd()
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


}