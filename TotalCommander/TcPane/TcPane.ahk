#Include %A_LineFile%\..\..\TotalCommander.ahk
/*	Pane
	To get selection call this script in Total commander with parameter %S
*/
Class TcPane extends TotalCommander
{
	
	/* File tree & curretn path has has dynamic classes,
	   They are different for 32-bit & 64-bit version.
			They are changing if:
				"Separate tree"	is visible
				"FTP connection"	is visible				
	   	  
			TC version	  File tree	  Path
			--------------	---------------	----------------
			TOTALCMD64.EXE	LCLListBox(5-1)	Window(17-9)
			TOTALCMD.EXE	TMyListBox(2-1)	TPathPanel(2-1)
			
  */
	_class_names :=	{"TOTALCMD.EXE":	{"listbox":	"TMyListBox"	;
			,"index":	[2, 1]	; [index of first control, value to remove for next control]
			,"path":	"TPathPanel"}	; 
		,"TOTALCMD64.EXE":	{"listbox":	"LCLListBox"	;
			,"index":	[17, 5]	; [index of first control, value to remove for next control]
			,"path":	"Window"}}	; 

	_class_nn := {} ; found class names
	
	__New()
	{
		this._init()
		this._setPaneClasses()
		this._setpathClasses()
		Dump(this._class_nn, "this._class_nn", 1)
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
		;MsgBox,262144,source_pane, %$source_pane%
		For $pane_nn, $path_nn in this._class_nn
			if( $pane_nn != $source_pane )
				$target_pane := $pane_nn
		
		;MsgBox,262144,target_pane, %$target_pane%		
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
		$class_nn := this._class_nn[this.getSourcePaneClass()]

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
	/** search for existing classes for file tree
		TMyListBox(2-1) | LCLListBox(5-1)
	 */
	_setPaneClasses()
	{
		$class_name := this._class_names[this.proccesName()].listbox
		$last_index := 5
		Loop, 2
		{
			$last_index := this._searchExistingControl( $class_name, $last_index )
			this._class_nn[$class_name ($last_index +1)] := {}
		}
	}
	/** search for existing classes for current path
		TPathPanel(2-1) | Window(17-9)
	 */
	_setpathClasses(  )
	{
		$class_name	:= this._class_names[this.proccesName()].path
		$indexes	:= this._class_names[this.proccesName()].index
		$panes_nn	:= []
		
		For $pane_nn, $path_nn in this._class_nn
			$panes_nn.push($pane_nn)
		
		$last_index := this._searchExistingControl( $class_name, $indexes[1] )	+ 1		

		if( this._isDiskSpaceControl( $class_name $last_index ) )
			$last_index--
		
		this._class_nn[$panes_nn[1]] := $class_name $last_index
		this._class_nn[$panes_nn[2]] := $class_name ($last_index - $indexes[2] )	
	}
	/**
	 */
	_isDiskSpaceControl( $class_name )
	{
		ControlGetText, $text , %$class_name%, % this.hwnd()
		return RegExMatch( $text, "i)free$" )
	} 
	/** serach for number of control
		E.G.: LCLListBox1, LCLListBox2, LCLListBox3
	 */
	_searchExistingControl( $control_name, $number )
	{
		;$exists := this._isControlExists($control_name $number)
		;$number++
		While $number>0
			;$exists	:= this._isControlExists($control_name $number--)
			if( this._isControlExists($control_name $number--) ) 
				break
				
		;Dump($number, "number", 1)
		return $number			
	}

	/** find if control exists
	 */
	_isControlExists($class_nn)
	{
		;Dump($class_nn, "class_nn", 1)
		ControlGet, $is_visible, Visible, , %$class_nn%,  % this.hwnd()
		;ControlGet, $is_visible, Hwnd , , %$class_nn%,  % this.hwnd()		
		;Dump($is_visible, $class_nn, 1)
		return $is_visible
		;return $is_visible ? $class_nn : 0
	}





}
