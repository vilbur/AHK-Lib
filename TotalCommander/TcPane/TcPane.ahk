﻿#Include %A_LineFile%\..\includes.ahk

global $CLSID

$CLSID	:= "{6B39CAA1-A320-4CB0-8DB4-352AA81E460E}"

/*	Pane
	To get selection call this script in Total commander with parameter %S
*/
Class TcPane extends TcControlClasses
{
	_TcTabs 	:= new TcTabs().Parent(this)
	_TcPaneWatcher	:= ""
	_panes := {}	

	__New()
	{
		;$g_TcPane := this
		this._init()
		this._setPaneClasses()
		this._setPathClasses()
		this._setListBoxAndPathToPair()
		
		;$class_nn := new TcControlClasses(this._hwnd)
		;Dump(this._class_nn, "this._class_nn", 1)
		this._setPanes()
		
		this._runTcPaneWatcher()
		this._setTcPaneWatcher()		
				
		;sleep, 1000
		;Dump(this._TcPaneWatcher, "this._TcPaneWatcher", 1)
		;Dump(this, "this.", 1)
		;Dump(this._panes, "this._panes", 1)
		;this._setPanes()		
		;this._setPaneClasses()
		;this._setpathClasses()
		;this._setListBoxAndPathToPair()
		
		;Dump(this._class_nn, "TcPane._class_nn", 1)
	}

	/**
	 */
	_setPanes()
	{
		For $pane_class, $path_class in this._class_nn
			this._panes[$pane_class] := this._getPaneObject($pane_class, $path_class, A_Index)
	}
	/**
	 */
	_getPaneObject($pane_class, $path_class, $index)
	{
		return %	{"side":	$index == 1 ? "right" : "left"
			,"hwnd":	this._getControlHwnd($pane_class)
			,"path":	{"class":	$path_class
				,"hwnd":	this._getControlHwnd($path_class)}}
	}
	/**
	 */
	_getControlHwnd( $class_nn )
	{
		ControlGet, $hwnd, Hwnd,, %$class_nn%,  % this.hwnd()

		return $hwnd 
	}
	/** Get focused control (file list) when Total commander window lost focus
	  * 
	 */  
	_setTcPaneWatcher()
	{

		if( ! this._TcPaneWatcher )
			try
			{
				this._TcPaneWatcher := ComObjActive($CLSID).hwnd(this._hwnd)
			}
			
		if( ! this._TcPaneWatcher )
			this._runTcPaneWatcher()
	}

	/** Get focused control (file list) when Total commander window lost focus
	  * 
	 */  
	_runTcPaneWatcher()
	{
		$hwnd := this._hwnd
		
		Run, %A_LineFile%\..\TcPaneWatcher\TcPaneWatcher.ahk %$hwnd% %$CLSID%
		
		this._setTcPaneWatcher()
	}

	/** Get side of pane
	  *
	  * @return string "left|right"
	 */
	getPane($pane:="source")
	{
		$class_nn := this._getPaneClass( $pane )

		For $pane_class, $path_class in this._class_nn
			if( $pane_class==$class_nn )
				return A_Index == 1 ? "right" : "left"
	}
	/**
	 */
	updateActivePane(  )
	{
		sleep, 200
		MsgBox,262144,, % this._TcPaneWatcher.lastPane(this._hwnd),1
	}

	/** Set\Get active pane
	  *
	  * @param	string	$side "left|right" pane
	 */
	activePane($side:="")
	{
		$active_pane_side := this.getPane()
		
		if( ! $side )
			return $active_pane_side

		if( $side!=$active_pane_side ){
			;MsgBox,262144,, % "ACTIVETE " $side,2
			WinActivate,  % this.hwnd()
			sleep, 500
			ControlFocus, % this._getTargetPaneClass(), % this.hwnd()
		}
		
		return this
	}

	/** @return string path of active pane
	 */
	getPath($side:="left")
	{
		return % $side == this.getPane("source") ? this.getSourcePath() : this.getTargetPath()
	}
	
	/** @return string path of active pane
	 */
	getSourcePath()
	{
		$class_nn := this._class_nn[this._getSourcePaneClass()]

		return % this._getPathFromControl($class_nn)
	}
	/** @return string path of in active pane
	 */
	getTargetPath()
	{
		$class_nn := this._class_nn[this._getTargetPaneClass()]

		return % this._getPathFromControl($class_nn)
	}

	/** refresh pane
	*/
	refresh($pane:="source")
	{
		$process_name	:= this._process_name
		$dir	:= $pane == "source" ? this.getSourcePath() : this.getTargetPath()
		$pane	:= $pane == "source" ? "L" : "R"
		
		Run, %COMMANDER_PATH%\%$process_name% /O /S /%$pane%=%$dir%
	}
	/**
	 */
	_getPathFromControl($class_nn)
	{
		ControlGetText, $path , %$class_nn%, % this.hwnd()
		
		/* remove mask like "*.*" from end of path
		 */
		$path := RegExReplace( $path, "[\\\/]\*\.\*", "" ) 
		
		return $path
	}
	/*---------------------------------------
		GET CLASS NAMES
	-----------------------------------------
	*/
	/** @return string ClassNN of active pane
	  *
	  * NOTE: IT SEEM THAT ControlGetFocus WORKS WITHOUT WinActivate
	  *
	 */
	_getSourcePaneClass()
	{
		return % this._TcPaneWatcher.lastPane(this._hwnd)
	}
	/** @return string ClassNN of active pane
	 */
	_getTargetPaneClass()
	{
		$source_pane	:= this._getSourcePaneClass()

		For $pane_nn, $path_nn in this._class_nn
			if( $pane_nn != $source_pane )
				$target_pane := $pane_nn
		
		return $target_pane
	}
	/**
	  * @param string pane 'source|target'
	 */
	_getPanedHwnd( $pane:="source" )
	{
		$class_nn := this._getSourcePaneClass( $pane )

		ControlGet, $hwnd, Hwnd  ,, %$class_nn%, % this.hwnd()

		return $hwnd
	}
	/*---------------------------------------
		FALLBACKS FOR OBSOLETE METHODS
	-----------------------------------------
	*/
	getSourcePaneClass(){
		MsgBox,262144,, % "OBSOLETE METHOD:`n	TcPane.getSourcePaneClass()`n`nCHANGE IT TO:`n	TcPane._getSourcePaneClass()"
	}
	/** @return string ClassNN of active pane
	 */
	getTargetPaneClass(){
		MsgBox,262144,, % "OBSOLETE METHOD:`n	TcPane.getTargetPaneClass()`n`nCHANGE IT TO:`n	TcPane._getTargetPaneClass()"
	}
	/**
	  * @param string pane 'source|target'
	 */
	getPanedHwnd( $pane:="source" ){
		MsgBox,262144,, % "OBSOLETE METHOD:`n	TcPane.getPanedHwnd()`n`nCHANGE IT TO:`n	TcPane._getPanedHwnd()"
	}
	/**
	 */
	setActivePane(){
		MsgBox,262144,, % "OBSOLETE METHOD:`n	TcPane.setActivePane()`n`nCHANGE IT TO:`n	TcPane.activePane('left|right')"
	}
	/**
	 */
	getActivePane(){
		MsgBox,262144,, % "OBSOLETE METHOD:`n	TcPane.getActivePane()`n`nCHANGE IT TO:`n	TcPane.activePane()"
	}
	
	
	/*---------------------------------------
		GET CLASS NAMES ON INIT
	-----------------------------------------
	*/

	/*---------------------------------------
		ACCESSORS
	-----------------------------------------
	*/
	/** get TcTabs
	 */
	TcTabs()
	{
		return % this._TcTabs
	} 

}



/*  
*/
Class TcControlClasses extends TotalCommander
{
	_process_name	:= ""

	/* Getting of controls class is tricky, because Total commander is changing then dynamically
	   
	   "file listbox" & "path" has different classes for 32-bit & 64-bit version.
			They are changing if:
				"Separate tree"	is visible
				"FTP connection"	is visible				
	   	  
			TC version	  File tree	  Path
			--------------	---------------	----------------
			TOTALCMD64.EXE	LCLListBox(5-1)	Window(17-9)
			TOTALCMD.EXE	TMyListBox(2-1)	TPathPanel(2-1)
			
  */
	static _class_names :=	{"TOTALCMD.EXE":	{"listbox":	"TMyListBox"	;
			,"index":	[2, 1]	; [index of first control, value to remove for next control]
			,"path":	"TPathPanel"}	; 
		,"TOTALCMD64.EXE":	{"listbox":	"LCLListBox"	;
			,"index":	[17, 5]	; [index of first control, value to remove for next control]
			,"path":	"Window"}}	; 

	_class_nn	:= {} ; found class names
	
	/** search for existing classes for file listbox
		TMyListBox(2-1) | LCLListBox(5-1)
	 */
	_setPaneClasses()
	{
		$class_name := this._class_names[this.proccesName()].listbox
		$last_index := 5
		Loop, 2
		{
			$last_index := this._searchForPaneControl( $class_name, ( A_Index==1 ? $last_index : $last_index -1) )
			;Dump($last_index, "LISTBOX", 1)
			this._class_nn[$class_name $last_index] := {}
		}
	}
	/**
	 */
	_searchForPaneControl( $class_name, $last_index )
	{
		While, $last_index > 0
		{
			$last_index := this._searchExistingControl( $class_name, $last_index )
			ControlGetText, $text , % $class_name $last_index , % this.hwnd()

			if( $text )
				$last_index--
			else
				break
		}
		return $last_index
	} 
	
	/** search for existing classes for current path
	 * TPathPanel(2-1) | Window(17-9)
	 * 
	 * if can found disk info control then path is -1
	 * 
	 */
	_setPathClasses()
	{
		$class_name	:= this._class_names[this.proccesName()].path
		$indexes	:= this._class_names[this.proccesName()].index
		$panes_nn	:= this._getPanesClasses()

		$last_index := this._searchExistingControl( $class_name, $indexes[1] )		

		if( this._isDiskInfoControl( $class_name $last_index ) )
			$last_index--
		
		this._class_nn[$panes_nn[1]] := $class_name $last_index
		this._class_nn[$panes_nn[2]] := $class_name ($last_index - $indexes[2] )
	}
	/** If control is next "Disk space info" OR "Ftp info"
	  *
	  *  Controls next to disk dropdown menu E.G.:
	  *		1) 123 453 k of 987 654 k free
	  *		2) ftp://foo.ftp.address 
	 */
	_isDiskInfoControl( $class_name )
	{
		ControlGetText, $text , %$class_name%, % this.hwnd()

		return RegExMatch( $text, "i)(^ftp|free$)" )
	} 
	/** serach for number of control
		E.G.: LCLListBox1, LCLListBox2, LCLListBox3
	 */
	_searchExistingControl( $control_name, $number )
	{
		While $number>0
			if( this._isControlExists($control_name $number) )
				break
			else
				$number--

		return $number 		
	}

	/** find if control exists
	 */
	_isControlExists($class_nn)
	{
		ControlGet, $is_visible, Visible, , %$class_nn%,  % this.hwnd()

		return $is_visible
	}
	/** Pair LEFT "file listbox" with left "path" and vice versa
		Find right corner of list and path and compare it
		Left corner is changing if file tree is displayed
	 */
	_setListBoxAndPathToPair()
	{
		$panes_nn	:= this._getPanesClasses()
			
		ControlGetPos, $list_X,, $list_W, , % $panes_nn[1], % this.hwnd()
		
		ControlGetPos, $path_X,, $path_W, , % this._class_nn[$panes_nn[1]], % this.hwnd()		
		
		if( Round($list_X  $list_W+, -2) != Round($path_X +  $path_W, -2) )
		{
			this._class_nn :=	{$panes_nn[1]:this._class_nn[$panes_nn[2]]
				,$panes_nn[2]:this._class_nn[$panes_nn[1]]}
		}
		
	}
	/** get keys from this._class_nn
	 */
	_getPanesClasses()
	{
		$panes_nn	:= []

		For $pane_nn, $path_nn in this._class_nn
			$panes_nn.push($pane_nn)
		
		return $panes_nn	
	}
	/** get class of pane by "source|target"
	  * @param string $pane  "source|target"
	  */
	_getPaneClass( $pane )
	{
		return % $pane == "source" ? this._getSourcePaneClass() : this._getTargetPaneClass()
	}

	
}