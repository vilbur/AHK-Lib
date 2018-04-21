#SingleInstance force

global $TcPaneWatcherCom
global $last_win
global $CLSID

$CLSID	:= "{6B39CAA1-A320-4CB0-8DB4-352AA81E460E}"


/** RUN TEST
  *
  *
  *
  *      
 */  

/**
 */
deleteLogFile()
{
	FileDelete, %A_LineFile%\..\log.tx
}
/**
 */
runPaneWatcher()
{
	Run, %A_LineFile%\..\..\TcPaneWatcher.ahk %$CLSID%
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
	if(  wParam!=32772 )
		return
		
	if( $last_win == "TTOTAL_CMD" ){
		
		if( ! $TcPaneWatcherCom )
			$TcPaneWatcherCom := ComObjActive($CLSID)
		
		sleep, 100 ; WAIT THEN TcPaneWatcher set active pane
		
		FileAppend, % "PANE-" $TcPaneWatcherCom.activePane() "`n", %A_LineFile%\..\log.txt 
		;MsgBox,262144,, % "Active pane: " $TcPaneWatcherCom.activePane(),3 
	
		$last_win := ""
	}
	else
	{
		WinGetClass, $win_class, ahk_id %lParam%
		
		if( $win_class=="TTOTAL_CMD" )
			$last_win := "TTOTAL_CMD"
	}
}

/** RUN TEST 
 */  
deleteLogFile()
runPaneWatcher()
bindMessageOnWindowChange()
