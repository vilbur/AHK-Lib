/* Class TcCore
*/
Class TcCore
{
	_wincmd_ini	:= ""
	_process_name	:= ""	
	_hwnd	:= ""

	/**
	 */
	_init()
	{
		$wincmd_ini	= %Commander_Path%\wincmd.ini		
		this._wincmd_ini	:= $wincmd_ini
		
		this._setProcessName()
		this._setHwnd()
	}
	/**
	 */
	ahkId()
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
	saveConfig()
	{
		SendMessage  1075, 580, 0, , % "ahk_id " this._hwnd
		
		return this
	} 

}