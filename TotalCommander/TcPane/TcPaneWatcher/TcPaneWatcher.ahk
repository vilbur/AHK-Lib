#SingleInstance force
;#NoTrayIcon

global $TcPaneWatcher
global $last_win
global $CLSID

/** Watch Total Commander & Set last used control when Total Commander lost focus
 *
 *	Script has own file because of it use OnMessage(), in this way OnMessage does not collide with others OnMessages
 *	TcPaneWatcher is accesable via ComObject
 * 
 * @param	{hwnd:control_class}	_last_panes	store last used control class, key is hwnd of Total Commander (for use on multiple instances)
 *
 * @method	self	hwnd( integer $hwnd  )	
 * @method	string	lastPane( integer $hwnd )	get last focused control class 
 *      
 */
Class TcPaneWatcher
{
	_last_panes := {}
	
	__New()
	{
		this._setOnWinMessage()
	}
	/** Set hwnd for identification of Total Commander 
	  * @param	integer	$hwnd	hwnd of Total Commander 
	 */
	hwnd( $hwnd_tc )
	{
		this._last_panes[$hwnd_tc]	:= ""
		
		this._initLastPane( $hwnd_tc )
		
		return this
	}
	
	/** Get last focused pane
	  * @param	integer	$hwnd	hwnd of Total Commander 
	 */
	lastPane( $hwnd_tc )
	{
		return % this._last_panes[$hwnd_tc]
	}
	/**
	 */
	_initLastPane( $hwnd_tc )
	{
		$last_win := $hwnd_tc
		
		if( WinActive("ahk_id " $hwnd_tc) )
			this._setLastPane( $hwnd_tc )
	} 
	/** Set callback on focus change
	 */
	_setOnWinMessage()
	{
		Gui +LastFound
		$hwnd := WinExist()
		
		DllCall( "RegisterShellHookWindow", UInt,$hwnd )
		$MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
		OnMessage( $MsgNum, "onWindowChange" )
			
		return this
	}
	/** Set last used control on Total Commander lost focus
	  * Called by onWindowChange()
	  */
	_onTotalCommanderLostFocus( $hwnd_tc )
	{
		$active_window := WinActive("A")
			
		WinActivate, ahk_id %$hwnd_tc% 

		this._setLastPane( $hwnd_tc )
		
		WinActivate, ahk_id %$active_window%
	}
	/** Set last used control
	 */
	_setLastPane( $hwnd_tc )
	{
		ControlGetFocus, $source_pane, ahk_id %$hwnd_tc%

		if( this._isFileListControl( $source_pane ) )
			this._last_panes[$hwnd_tc] := $source_pane
	}
	/** Make sure that last control was list box
	 */
	_isFileListControl( $control_class )
	{
		return % RegExMatch( $control_class, "i)LCLListBox|TMyListBox" ) 
	} 
	
}

/** On Total Commander Get\Lost focus
 */
onWindowChange(wParam, lParam)
{
	if(  wParam!=32772 )
		return
		
	WinGetClass, $last_class, ahk_id %$last_win%
		
	if( $last_class == "TTOTAL_CMD" )
	{
		$TcPaneWatcher._onTotalCommanderLostFocus( $last_win )
		
		$last_win := ""
	}
	
	WinGetClass, $win_class, ahk_id %lParam%
	
	if( $win_class=="TTOTAL_CMD" )
		$last_win := lParam		
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


/** RUN WATCHER VIA FILE CALL
 */
$hwnd	= %1%
$CLSID	= %2%

$TcPaneWatcher := new TcPaneWatcher().hwnd($hwnd)

registerTcPane($TcPaneWatcher, $CLSID)
