#SingleInstance force

global $TcPaneWatcherCom
global $last_win
global $CLSID

$CLSID	:= "{6B39CAA1-A320-4CB0-8DB4-352AA81E460E}"


/** Get focused control (file list) when Total commander window lost focus
  * 
 */  
runPaneWatcher()
{
	$hwnd := WinExist()
	
	try
	{
		$TcPaneWatcherCom := ComObjActive($CLSID)
	}	
	
	if( $TcPaneWatcherCom )
		$TcPaneWatcherCom.hwnd($hwnd)
	
	else
		Run, %A_LineFile%\..\..\TcPaneWatcher.ahk %$hwnd% %$CLSID%
}
/**  
 */
deleteLogFile()
{
	FileDelete, %A_LineFile%\..\log.tx
}

/**
 */
bindMessageOnWindowChange()
{
	Gui +LastFound
	hwnd := WinExist()
	
	DllCall( "RegisterShellHookWindow", UInt,hwnd )
	MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
	OnMessage( MsgNum, "ShellMessage" )
}
/**
 */
ShellMessage(wParam, lParam)
{
	if( wParam!=32772 )
		return
	
	WinGetClass, $last_class, ahk_id %$last_win%
	
	/** ON TOTAL COMMANDER GET FOCUS 
	 */
	if( $last_class == "TTOTAL_CMD" )
	{
		
		if( ! $TcPaneWatcherCom )
			$TcPaneWatcherCom := ComObjActive($CLSID)
		
		sleep, 500 ; WAIT THEN TcPaneWatcher se  t active pane
		
		/** LOG LAST CONTROL TO FILE 
		 */
		WinGetTitle, $win_title, ahk_id %$last_win%
		FileAppend, % (InStr( $win_title, "x64" )?"64bit":"32bit") ": " $TcPaneWatcherCom.focusedControl($last_win) "`n", %A_LineFile%\..\log.txt
		
		/** MESsAGE LAST CONTROL TO FILE 
		 */
		MsgBox,262144,, % (InStr( $win_title, "x64" )?"64bit":"32bit") ": " $TcPaneWatcherCom.focusedControl($last_win),1
	
		$last_win := ""
	}
	
	WinGetClass, $active_class, ahk_id %lParam%

	/** ON TOTAL COMMANDER BLUR
	 */
	if( $active_class=="TTOTAL_CMD" )
		$last_win := lParam
	
}

/** RUN TEST 
 */  
deleteLogFile()
runPaneWatcher()
bindMessageOnWindowChange()
