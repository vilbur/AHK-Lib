#SingleInstance force

global $last_win
global $TcPaneWatcherCom
global $CLSID

/** TcPaneWatcher
 *
 */
Class TcPaneWatcher
{
	_active_pane := ""
	
	__New()
	{
		this.setOnWinMessage()
	}
	/**
	 */
	setOnWinMessage()
	{
		Gui +LastFound
		$hwnd := WinExist()
		
		DllCall( "RegisterShellHookWindow", UInt,$hwnd )
		$MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
		OnMessage( $MsgNum, "onWindowChange" )

		$last_win := "TTOTAL_CMD"
			
		return this
	}
	/**
	 */
	activePane()
	{
		return % this._active_pane
	}
	
}


/**
 */
onWindowChange(wParam, lParam)
{
	if(  wParam!=32772 )
		return
	if( $last_win == "TTOTAL_CMD" )
	{
		$active_window := WinActive("A")
		
		WinActivate, ahk_class TTOTAL_CMD 

		ControlGetFocus, $source_pane, ahk_class TTOTAL_CMD

		if( ! $TcPaneWatcherCom )
			$TcPaneWatcherCom := ComObjActive($CLSID)

		$TcPaneWatcherCom._active_pane := $source_pane

		WinActivate, ahk_id %$active_window% 

		$last_win := ""
	}
	else
	{
		WinGetClass, $win_class, ahk_id %lParam%

		if( $win_class=="TTOTAL_CMD" )
			$last_win := "TTOTAL_CMD"
	}
		
}
/*
    ObjRegisterActive(Object, CLSID, Flags:=0)
    
        Registers an object as the active object for a given class ID.
        Requires AutoHotkey v1.1.17+; may crash earlier versions.
    
    Object:
            Any AutoHotkey object.
    CLSID:
            A GUID or ProgID of your own making.
            Pass an empty string to revoke (unregister) the object.
    Flags:
            One of the following values:
              0 (ACTIVEOBJECT_STRONG)
              1 (ACTIVEOBJECT_WEAK)
            Defaults to 0.
    
    Related:
        http://goo.gl/KJS4Dp - RegisterActiveObject
        http://goo.gl/no6XAS - ProgID
        http://goo.gl/obfmDc - CreateGUID()
*/
registerTcPane(Object, CLSID, Flags:=0)
{
    static cookieJar := {}
    if (!CLSID) {
        if (cookie := cookieJar.Remove(Object)) != ""
            DllCall("oleaut32\RevokeActiveObject", "uint", cookie, "ptr", 0)
        return
    }
    if cookieJar[Object]
        throw Exception("Object is already registered", -1)
    VarSetCapacity(_clsid, 16, 0)
    if (hr := DllCall("ole32\CLSIDFromString", "wstr", CLSID, "ptr", &_clsid)) < 0
        throw Exception("Invalid CLSID", -1, CLSID)
    hr := DllCall("oleaut32\RegisterActiveObject"
        , "ptr", &Object, "ptr", &_clsid, "uint", Flags, "uint*", cookie
        , "uint")
    if hr < 0
        throw Exception(format("Error 0x{:x}", hr), -1)
    cookieJar[Object] := cookie
}

/**
 */
$CLSID	= %1%

$TcPaneWatcher 	:= new TcPaneWatcher()

registerTcPane($TcPaneWatcher, $CLSID)
