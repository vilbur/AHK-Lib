#Include %A_LineFile%\..\..\TotalCommander.ahk
/*	Pane
	To get selection call this script in Total commander with parameter %S
*/
Class TcPane extends TotalCommander
{
	
	/* Total commander has different classes for 32-bit & 64-bit version.
	   Numbers of these controls are changing too
	  
	  */
	_class_names :=	{"TOTALCMD.EXE":	{"listbox":	"TMyListBox"	; 
			,"path":	"TPathPanel"	; 
			,"index":	[2, 1]}	; 
		,"TOTALCMD64.EXE":	{"listbox":	"LCLListBox"	; 
			,"index":	[14, 9]	; 
			,"path":	"Window"}}	; 

	_class_nn := {} ; found class names
	
	__New()
	{
		this._init()
		this._setPaneClasses()
		this._setpathClasses()
		;Dump(this._class_nn, "this._class_nn", 1)
	
	}

	/** @return string ClassNN of active pane
	 */
	getSourcePaneClass()
	{
		this._saveActiveWindow()

		WinActivate, % this.hwnd()

		ControlGetFocus, $source_pane, % this.hwnd()

		this._restorePreviousWindow()

		return %$source_pane%
	}
	/** @return string ClassNN of active pane
	 */
	getTargetPaneClass()
	{
		$source_pane	:= this.getSourcePaneClass()
		
		;Dump(this._class_nn, $source_pane, 1)
		;$process_name	:= this.proccesName()
		;if( $process_name == "TOTALCMD.EXE")
		;	return % $source_pane == "TMyListBox2" ? "TMyListBox1" : "TMyListBox2"
		;else
		;	return % $source_pane == "LCLListBox2" ? "LCLListBox1" : "LCLListBox2"
		For $pane_nn, $path_nn in this._class_nn
			if( $pane_nn != $source_pane )
				$target_pane := $pane_nn
			
		;Dump($target_pane, "target_pane", 1)
		return $target_pane
	}
	/**
	  * @param string pane 'source|target'
	 */
	getPanedHwnd( $pane:="source" )
	{
		$class_nn := $pane == "source" ? this.getSourcePaneClass() : this.getTargetPaneClass()

		ControlGet, $hwnd, Hwnd  ,, %$class_nn%, % this.hwnd()

		return $hwnd
	}
	/** @return string path of active pane
	 */
	getSourcePath()
	{
		;Dump(this.getSourcePaneClass(), "this.getSourcePaneClass()", 1)
		;Dump(this._class_nn[this.getSourcePaneClass()], "this._class_nn[this.getSourcePaneClass()]", 1)
		$class_nn := this._class_nn[this.getSourcePaneClass()]
		;Dump($class_nn, "class_nn", 1)
		;Dump(this._getPath($class_nn), "this._getPath($class_nn)", 1)
		return % this._getPath($class_nn)
	}
	/** @return string path of in active pane
	 */
	getTargetPath()
	{
		$class_nn := this._class_nn[this.getTargetPaneClass()]

		return % this._getPath($class_nn)
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
	_getPath($class_nn)
	{
		
		ControlGetText, $path , %$class_nn%, % this.hwnd()
		
		if( ! $path )
		{
			RegExMatch( $class_nn, "i)([^\d]+)(\d+)", $class_nn_match )
			return this._getPath( $class_nn_match1 ($class_nn_match2 + 1) )
		}

		SplitPath, $path,, $path_dir ; remove mask liek "*.*" from end of path

		return $path_dir
	}
	/*---------------------------------------
		GET CLASS NAMES
	-----------------------------------------
	*/
	/** search for existing classes for file listbox
		LCLListBox\d | TMyListBox\d
	 */
	_setPaneClasses()
	{
		Loop, 2
		{
			$listbox_class := this._searchExistingControl( this._class_names[this.proccesName()].listbox, A_Index )
			this._class_nn[$listbox_class]	:= {}
		}
	}
	/** search for existing classes for current path
		TPathPanel\d | Window\d
	 */
	_setpathClasses(  )
	{
		$indexes := this._class_names[this.proccesName()].index
		
		For $pane_nn, $path_nn in this._class_nn
			this._class_nn[$pane_nn] := this._searchExistingControl( this._class_names[this.proccesName()].path, $indexes[A_Index] )
	}
	/** serach for number of control
		E.G.: LCLListBox1, LCLListBox2, LCLListBox3
	 */
	_searchExistingControl( $control_name, $number )
	{
		$exists := this._isControlExists($control_name $number)

		;if( ! $exists )
		While ! $exists 
			$exists	:= this._isControlExists($control_name $number++)

		return $control_name $number				
	}

	/** find if control exists
	 */
	_isControlExists($class_nn)
	{
		ControlGet, $is_visible, Visible, , %$class_nn%,  % this.hwnd()
		return $is_visible
		;Dump($is_visible, $class_nn, 1)
		;return $is_visible ? $class_nn : 0
	}





}
