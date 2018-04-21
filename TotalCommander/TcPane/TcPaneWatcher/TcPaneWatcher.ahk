#SingleInstance force

global $last_win
global $TcPaneWatcher
global $CLSID

/** TcPaneWatcher
 *
 */
Class TcPaneWatcher
{
	
	
	_focused_controls := {}
	
	__New()
	{
		this.setOnWinMessage()
	}
	/**
	 */
	hwnd( $hwnd )
	{
		this._focused_controls[$hwnd]	:= ""
		
		$last_win := $hwnd
		
		return this
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

		;$last_win := "TTOTAL_CMD"
			
		return this
	}
	/**
	 */
	focusedControl( $hwnd_tc )
	{
		;Dump(this, "this.", 1)
		return % this._focused_control[$hwnd_tc]
	}
	/**
	 */
	onTcBlur( $hwnd_tc )
	{
		$active_window := WinActive("A")
		
		;MsgBox,262144,hwnd_tc, %$hwnd_tc%,2
		
		;sleep, 1000		
		WinActivate, ahk_id %$hwnd_tc% 

		;sleep, 1000
		ControlGetFocus, $source_pane, ahk_id %$hwnd_tc%
		;ControlGetFocus, $source_pane, ahk_class TTOTAL_CMD
		
		;MsgBox,262144,source_pane, %$source_pane%,3 
		
		;if( ! $TcPaneWatcherCom )
		;	$TcPaneWatcherCom := ComObjActive($CLSID)

		this._focused_control[$hwnd_tc] := $source_pane
		
		;Dump(this._focused_control, "this._focused_control", 1)

		WinActivate, ahk_id %$active_window%
	}
	
	
}


/**
 */
onWindowChange(wParam, lParam)
{

	if(  wParam!=32772 )
		return
		
	WinGetClass, $last_class, ahk_id %$last_win%
		
	if( $last_class == "TTOTAL_CMD" )
	{
		$TcPaneWatcher.onTcBlur( $last_win )
		
		$last_win := ""
	}
	
	WinGetClass, $win_class, ahk_id %lParam%
	
	if( $win_class=="TTOTAL_CMD" )
		$last_win := lParam
		;MsgBox,262144,, TC FOCUS,2 
	
		
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
$hwnd	= %1%
$CLSID	= %2%

$TcPaneWatcher := new TcPaneWatcher().hwnd($hwnd)

registerTcPane($TcPaneWatcher, $CLSID)
